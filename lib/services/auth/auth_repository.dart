import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/typedefs/failure.dart';
import '../../core/typedefs/type_defs.dart';
import '../providers.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository(
      auth: ref.read(authProvider),
      googleSignIn: ref.read(googleSignInProvider),
    ));

class AuthRepository {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _googleSignIn = googleSignIn;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  FutureEither<void> signInWithGoogle(bool isFromLogin) async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider
            .addScope('https://www.googleapis.com/auth/contacts.readonly');
        await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

        final GoogleSignInAuthentication googleAuth =
            await googleUser!.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        if (isFromLogin) {
          await _auth.signInWithCredential(credential);
        } else {
          await _auth.currentUser!.linkWithCredential(credential);
        }
      }
      if (_auth.currentUser != null) {
        return right(null);
      }

      return left(Failure('User Cant Login'));
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          return left(
              Failure("The provider has already been linked to the user."));
        case "invalid-credential":
          return left(Failure("The provider's credential is not valid."));
        case "credential-already-in-use":
          return left(Failure(
              "The account corresponding to the credential already exists, "
              "or is already linked to a Firebase User."));
        // See the API reference for the full list of error codes.
        default:
          return left(Failure("Unknown error about Firebase Auth."));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid logOut() async {
    try {
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }

      return right(await _auth.signOut());
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
