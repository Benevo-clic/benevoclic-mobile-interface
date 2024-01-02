class PasswordVerification {
  var password = "";
  var message = "";

  PasswordVerification(String passwordParam) {
    password = passwordParam;
  }

  security() {
    if (password.isEmpty) {
      message = "Veuillez remplir ce champs avec votre nouveau mot de passe";
      return false;
    }

    if (RegExp(
            r"[a-zA-Z0-9!@à)=ç_è(é&,;:?)]{8,}")
        .hasMatch(password)) {
      return true;
    }
    message = "le mot de passe doit avoir au moins 8 caracteres";
    return false;
  }
}