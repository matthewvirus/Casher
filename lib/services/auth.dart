import 'auth_user.dart';
import 'package:casher/pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

String errorMessage = '';

class AuthService{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<AuthUser?> signInWithEmailAndPassword(String email, String password) async{
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      firebaseUser = user;
      errorMessage = '';
      return AuthUser.fromFirebase(user);
    } on FirebaseAuthException catch (error){
      errorMessage = error.message!;
    }
    return null;
  }

  Future<AuthUser?> signUpWithEmailAndPassword(String email, String password) async{
    try {
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      firebaseUser = user;
      errorMessage = '';
      return AuthUser.fromFirebase(user);
    } on FirebaseAuthException catch (error){
      errorMessage = error.message!;
    }
    return null;
  }

  Future logOut() async {
    await _firebaseAuth.signOut();
    firebaseUser?.refreshToken;
  }

  Stream<AuthUser?> get currentUser {
    return _firebaseAuth.authStateChanges()
        .map((User? user) => user != null ? AuthUser.fromFirebase(user) : null);
  }
}