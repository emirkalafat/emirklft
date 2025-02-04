import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../core/typedefs/failure.dart';
import '../../core/typedefs/type_defs.dart';
import '../providers.dart';

final authRepositoryProvider = Provider<AuthRepository>(
    (ref) => AuthRepository(auth: ref.read(authProvider)));

class AuthRepository {
  final FirebaseAuth _auth;

  AuthRepository({required FirebaseAuth auth}) : _auth = auth;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  FutureVoid logOut() async {
    try {
      return right(await _auth.signOut());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
