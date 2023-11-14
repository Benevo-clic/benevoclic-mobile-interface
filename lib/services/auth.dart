import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../globals.dart' as globals;

class AuthService {
  var _auth = FirebaseAuth.instance;

  getToken() async {
    print(globals.token);
  }

  Stream<User?> get userChanged => _auth.authStateChanges();

  Future<void> authAnonymous() =>
      _auth.signInAnonymously().then((credential) => "anonymous");

  authAdressPassword(email, password) async {
    
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print(_auth.currentUser?.getIdTokenResult(true));
      globals.token = "";
      globals.token = _auth.currentUser?.getIdToken(true) as String;
    
  }

  

  Future<void> logout() => _auth.signOut().then((value) => null);

  Future<void>? deleteAccount() => _auth.currentUser?.delete();

  singInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googlAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googlAuth?.accessToken,
      idToken: googlAuth?.idToken,
    );
    globals.token = googlAuth!.idToken!;

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential.user?.displayName);
  }

  createAccount(email, password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
