class EmailVerification {
  var email = "";
  var message = "";

  EmailVerification(String emailParam) {
    email = emailParam;
  }

  security() {
    if (email.isEmpty) {
      message = "Veuillez remplir ce champs avec un email";
      return false;
    }

    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return true;
    }
    message = "Cet email ne possède pas un bon format";
    return false;
  }
}
