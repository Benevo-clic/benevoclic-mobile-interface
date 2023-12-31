class AdressVerification {
  var adress = "";
  var message = "";

  AdressVerification(String adressParam) {
    adress = adressParam;
  }

  security() {
    if (adress.isEmpty) {
      message = "Veuillez remplir ce champs avec une adresse";
      return false;
    }

    if (RegExp(r"^[0-9]+,[a-zA-Z -']+,[a-zA-Z -']+,[0-9]{5}")
        .hasMatch(adress)) {
      return true;
    }
    message = "Cette adresse n'est pas dans le bon format";
    return false;
  }
}