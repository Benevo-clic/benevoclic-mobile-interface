class PhoneVerification {
  var phone = "";
  var message = "";

  PhoneVerification(String phoneParam) {
    phone = phoneParam;
  }

  security() {
    if (phone.isEmpty) {
      message = "Veuillez remplir ce champs avec votre numéro de téléphone";
      return false;
    }

    if (RegExp(
            r"^0[1-9][0-9]{8}$")
        .hasMatch(phone)) {
      return true;
    }
    message = "Ce numéro de téléphone n'est pas valide";
    return false;
  }
}