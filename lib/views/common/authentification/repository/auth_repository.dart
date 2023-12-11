import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:namer_app/util/globals.dart' as globals;

class AuthRepository {
  var _auth = FirebaseAuth.instance;
  Stream<User?> get userChanged => _auth.authStateChanges();

  authAdressPassword(email, password) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    globals.id = (await result.user!.getIdToken())!;
    print("Token : ${globals.id}");
  }

  Future<void> logout() async {
    await GoogleSignIn().signOut();
    _auth.signOut();
  }

  Future<void>? deleteAccount() => _auth.currentUser?.delete();

  Future<String?> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        print("La connexion Google a été annulée par l'utilisateur.");
        return null;
      }

      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userInfo =
          await FirebaseAuth.instance.signInWithCredential(credential);
      String? token = await userInfo.user?.getIdToken(true);

      if (token != null) {
        globals.id = token;
        return token; // Retourne le token si la connexion est réussie
      } else {
        print("Le token est null après la connexion Google.");
        return null;
      }
    } catch (e) {
      throw Exception(
          "Erreur de connexion Google : $e"); // Lance une exception en cas d'erreur
    }
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
