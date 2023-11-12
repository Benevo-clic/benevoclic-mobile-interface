import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  var _auth = FirebaseAuth.instance;

  Stream<User?> get userChanged => _auth.authStateChanges();

  Future<void> authAnonymous() =>
      _auth.signInAnonymously().then((credential) => "anonymous");

  /*Future<void> authAdressPassword(email, password) =>  _auth
      .signInWithEmailAndPassword(email: email, password: password)
      .then((credential) => credential);*/

  authAdressPassword(email, password) async { 
    try{
      var excep = await _auth.signInWithEmailAndPassword(email: email, password: password);
      print(excep);
    }on FirebaseAuthException catch (e){
      print(e);
    }
  }
  Future<void> logout() => _auth.signOut().then((value) => null);

  Future<void>? deleteAccount() => _auth.currentUser?.delete();

  /*Future<void> singInWithGoogle(email, password) =>  _auth
      .signInWithEmailAndPassword(email: email, password: password)
      .then((credential) => credential);*/

  singInWithGoogle() async {

    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googlAuth = await googleUser?.authentication; 

    AuthCredential credential =  GoogleAuthProvider.credential(
      accessToken: googlAuth?.accessToken,
      idToken: googlAuth?.idToken,
    );

    UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential.user?.displayName);
    //_auth = userCredential.user! as FirebaseAuth;
  }
}
