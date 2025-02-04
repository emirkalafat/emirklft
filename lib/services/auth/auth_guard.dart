import 'package:beamer/beamer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGuard extends BeamGuard {
  AuthGuard()
      : super(
          pathPatterns: ['/admin'],
          check: (context, location) {
            return FirebaseAuth.instance.currentUser != null;
          },
          beamToNamed: (origin, target) => '/auth',
        );
}
