import 'package:flutter_test/flutter_test.dart';
import 'package:namer_app/util/email_verification.dart';

void main() {
  test("Email test, email format not respected", () {
    EmailVerification ev = EmailVerification("fzeefz");
    expect(ev.security(), false);
    expect(ev.message, "Cet email ne possède pas un bon format");
    ev.email = "gefde.fr";
    expect(ev.security(), false);
    expect(ev.message, "Cet email ne possède pas un bon format");
    ev.email = "gefde@fr";
    expect(ev.security(), false);
    expect(ev.message, "Cet email ne possède pas un bon format");
    ev.email = "";
    expect(ev.security(), false);
    expect(ev.message, "Veuillez remplir ce champs avec un email");
  });

  test("Email test, email format is respected", () {
    EmailVerification ev = EmailVerification("admin@hotmail.com");
    expect(ev.security(), true);
    expect(ev.message, "");
  });
}
