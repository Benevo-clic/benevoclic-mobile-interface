import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../util/globals.dart' as globals;

class AuthService {
  var _auth = FirebaseAuth.instance;

  /*getToken() async {
    print(globals.id);
  }*/

  Stream<User?> get userChanged => _auth.authStateChanges();

  Future<void> authAnonymous() =>
      _auth.signInAnonymously().then((credential) => "anonymous");

  authAdressPassword(email, password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    print("token Email/password");
    print(result);
    print(await result.user!.getIdToken());
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
    globals.id = googlAuth!.idToken!;

    await FirebaseAuth.instance.signInWithCredential(credential);
    print(googlAuth!);
    print("token gmail");
    print(googlAuth!.idToken!);
  }

  createAccount(email, password) async {
    
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
          
      print(user.user?.getIdToken(true));
      _auth.currentUser?.sendEmailVerification();
      
  }

  /*signInWithFacebook() async{

  }*/


  
}
