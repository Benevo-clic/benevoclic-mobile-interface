import 'package:flutter_test/flutter_test.dart';
import 'package:namer_app/util/adresse_verification.dart';

void main() {
  test("Verification Adress test, Adress is null", () {
    expect(AdressVerification("").security(), false);
  });

  test("Verification Date test, Date is incorrect", () {
    expect(AdressVerification("1").security(), false);
    expect(AdressVerification("2,rue").security(), false);
    expect(AdressVerification("2,rue ,").security(), false);

    expect(AdressVerification("2,rue ,rgvfez,00000").security(), true);
    expect(
        AdressVerification("19,rue carnot,Villeneuve d'ascq,59000").security(),
        true);
    expect(
        AdressVerification("19,rue carnot,Villeneuve d'ascq,5900").security(),
        false);
  });
}