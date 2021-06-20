import 'package:fan_page/models/appuser.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //user obj
  Appuser? _userFromFirebase(User user) {
    // ignore: unnecessary_null_comparison
    return user != null ? Appuser(uid: user.uid) : null;
  }

  //auth change user stream
  //Stream<User> get user {
  //  return _auth.authStateChanges();
  //}

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebase(user!);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  //sign in w/ email and pass
  Future signInEmailPass() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "barry.allen@example.com",
        password: "SuperSecretPassword!"
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
      }
    }
  }
  //register with email and pass
  Future register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: "barry.allen@example.com",
        password: "SuperSecretPassword!"
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
  isSignedIn() {
    _auth
    .authStateChanges()
    .listen((User? user) {
      if (user == null) {
       print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }
  Future signEmOut() async {
    await _auth.signOut();
  }
}