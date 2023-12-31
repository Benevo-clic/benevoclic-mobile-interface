import 'package:flutter_test/flutter_test.dart';
import 'package:namer_app/util/password_verification.dart';

void main() {
  test("Verification Password test is null", () {
    PasswordVerification verif = PasswordVerification("");
    expect(verif.security(), false);
    expect(verif.message,
        "Veuillez remplir ce champs avec votre nouveau mot de passe");
  });

  test("Verification Password test, have good size of number", () {
    PasswordVerification verif = PasswordVerification("de");
    expect(verif.security(), false);
    expect(verif.message, "le mot de passe doit avoir au moins 8 caracteres");
    verif.password = "aabbccd";
    expect(verif.security(), false);
    expect(verif.message, "le mot de passe doit avoir au moins 8 caracteres");

    verif = PasswordVerification("aabbccdd");
    expect(verif.security(), true);

    verif.password = "aabbccddee";
    expect(verif.security(), true);
  });
}
