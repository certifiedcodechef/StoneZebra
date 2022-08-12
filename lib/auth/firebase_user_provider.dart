import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class StoneZebraFirebaseUser {
  StoneZebraFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

StoneZebraFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<StoneZebraFirebaseUser> stoneZebraFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<StoneZebraFirebaseUser>(
            (user) => currentUser = StoneZebraFirebaseUser(user));
