import 'package:flutter_test/flutter_test.dart';
import 'package:namer_app/util/get_format_date.dart';

void main() {
  test("Verification Date test, Date is null", () {
    expect(formatDate(null), "");
  });

  test("Verification Date test, Date is correct", () {
    expect(formatDate(DateTime(2015, 02, 1)), "1/2/2015");
    
  });
}
