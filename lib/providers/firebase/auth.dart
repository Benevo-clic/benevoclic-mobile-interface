import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:namer_app/providers/api/request.dart';
import 'package:namer_app/util/globals.dart' as globals;

class AuthService {
  var _auth = FirebaseAuth.instance;
  Stream<User?> get userChanged => _auth.authStateChanges();

  authAdressPassword(email, password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    //connexion();

    print("token Email/password");
    print(result.credential?.token);
    print(result.user?.emailVerified);
    globals.id = (await result.user!.getIdToken())!;
    print(globals.id);
  }

  /*Future<void> logout() => _auth.signOut().then((value) => null);*/

  Future<void> logout() async {
    print(globals.id);
    //await logout();
    _auth.signOut();
  }

  Future<void>? deleteAccount() => _auth.currentUser?.delete();

  singInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googlAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googlAuth?.accessToken,
      idToken: googlAuth?.idToken,
    );

    UserCredential userInfo =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(userInfo.additionalUserInfo?.isNewUser);
    String? token = await userInfo.user!.getIdToken(true);
    globals.id = token!;
    print("token gmail");
    print(googlAuth!.idToken!);
  }

  createAccount(email, password) async {
    UserCredential user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    print(user.user?.getIdToken(true));
    _auth.currentUser?.sendEmailVerification();
  }

  Future<String?> token() async {
    String? val = await _auth.currentUser?.getIdToken();
    return val;
  }

  bool? verifiedEmail() {
    _auth.currentUser?.reload();

    print(_auth.currentUser?.getIdToken(true));
    return _auth.currentUser?.emailVerified;
  }
}
