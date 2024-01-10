import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:namer_app/util/token_service.dart';

class AuthRepository {
  var _auth = FirebaseAuth.instance;

  Stream<User?> get userChanged => _auth.authStateChanges();
  TokenService tokenService = TokenService();

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    _updateTokenAndExpirationDate(userCredential);
  }

  Future<void> _updateTokenAndExpirationDate(
      UserCredential userCredential) async {
    DateTime expiryDate = DateTime.now().add(Duration(hours: 1));

    String token = (await userCredential.user!.getIdToken())!;
    tokenService.saveTokenAndExpirationDate(token, expiryDate);
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      await _updateTokenAndExpirationDate(userCredential);

      return userCredential;
    } else {
      throw Exception("Connexion annulée ou échouée.");
    }
  }

  Future<void> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await _auth.signOut();
      tokenService.clearTokenAndExpirationDate();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteAccount() async {
    await _auth.currentUser?.delete();
  }

  Future<void> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<bool> isEmailVerified() async {
    await _auth.currentUser?.reload();
    return _auth.currentUser?.emailVerified ?? false;
  }

  Future<bool> sendEmailVerification() async {
    try {
      await _auth.currentUser?.reload();
      await _auth.currentUser?.sendEmailVerification();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserCredential> createAccountWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await _updateTokenAndExpirationDate(userCredential);
      await userCredential.user?.sendEmailVerification();
      return userCredential;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> verifiedEmail() async {
    await _auth.currentUser?.reload();
    return _auth.currentUser?.emailVerified ?? false;
  }

  Future<void> changePassword(String newPassword) async {
    User? user = await FirebaseAuth.instance.currentUser;
    user!.updatePassword(newPassword).then((_) {
      print("changed");
    }).catchError((error) {
      print("not changed");
    });
  }
}
