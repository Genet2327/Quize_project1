

import 'package:firebase_auth/firebase_auth.dart';

class AuthServise {
  static final _auth = FirebaseAuth.instance;

  static Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);


      return null;
    } on FirebaseAuthException catch (e) {
      return _parseSignInAuthException(e);
    }
  }

  static Future createAccountWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      // TODO use _auth to create an account
      return null;
    } on FirebaseAuthException catch (e) {
      return _parseCreateAccountAuthException(e);
    }
  }

  static String? getUserId() {
    final user = _auth.currentUser;
    print('User  Id {$user}');
    if(user == null)
      return null;
    return user.uid;

    // TODO
  }

  static bool isSignedIn() {
    final user = _auth.currentUser;
    if(user == null)
      return false ;
    return true;
    // TODO
    return false;
  }

  static void signOut() {
    _auth.signOut();
    // TODO
  }

  static String _parseSignInAuthException(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return 'Email address is not formatted correctly';
      case 'user-not-found':
      case 'wrong-password':
      case 'user-disabled':
        print('this should be hit');
        return 'Invalid username or password';
      case 'too-many-requests':
      case 'operation-not-allowed':
      default:
        return 'An unknown error occurred';
    }
  }

  static String _parseCreateAccountAuthException(
      FirebaseAuthException exception) {
    switch (exception.code) {
      case 'weak-password':
        return 'Password is too weak';
      case 'invalid-email':
        return 'Email address is not formatted correctly';
      case 'email-already-in-use':
        return 'This email address already exists';
      default:
        return 'An unknown error occurred';
    }
  }
}
