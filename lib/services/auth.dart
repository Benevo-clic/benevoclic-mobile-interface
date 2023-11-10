import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final _auth = FirebaseAuth.instance;
  
  Future<void> authAnonymous() =>
  _auth.signInAnonymously().then((credential) => "anonymous");

  Future<void> authAdressPassword(email, password) => 
  _auth.signInWithEmailAndPassword(email: email, password: password)
  .then((credential) => credential);
  
  Stream<User?> get userChanged => _auth.authStateChanges(); 

  Future<void> logout() => _auth.signOut().then((value) => null);
}