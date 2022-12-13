import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class KinAlertFirebaseUser {
  KinAlertFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

KinAlertFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<KinAlertFirebaseUser> kinAlertFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<KinAlertFirebaseUser>(
      (user) {
        currentUser = KinAlertFirebaseUser(user);
        return currentUser!;
      },
    );
