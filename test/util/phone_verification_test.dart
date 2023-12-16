import 'package:flutter_test/flutter_test.dart';
import 'package:namer_app/util/phone_number_verification.dart';

void main() {
  test("Verification Phone number test is null", () {
    expect(PhoneVerification("").security(), false);
  });

  test("Verification Phone number test, have good size of number", () {
    expect(PhoneVerification("0115589562").security(), true);
    expect(PhoneVerification("01155895625").security(), false);
    expect(PhoneVerification("011558956").security(), false);
  });

  test("Verification Phone number test, correspond of numbers only", () {
    expect(PhoneVerification("0115589562").security(), true);
    expect(PhoneVerification("01155895a5").security(), false);
    expect(PhoneVerification("01155895=^").security(), false);
    expect(PhoneVerification("9115589545").security(), false);
  });
}
