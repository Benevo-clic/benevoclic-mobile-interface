abstract class ParamUser {
  String email;
  String bio;
  String phone;
  String address;
  String city;
  String postalCode;
  String country;
  String imageProfile;

  bool verified;

  ParamUser(
      {required this.bio,
      required this.phone,
      required this.address,
      required this.city,
      required this.postalCode,
      required this.country,
      required this.imageProfile,
      required this.email,
      required this.verified});
}

class UserParam extends ParamUser {
  String firstName;
  String lastName;
  String birthDayDate;
  List<String> myAssociations;
  List<String> myAssociationsWaiting;

  UserParam(
      {required super.bio,
      required super.phone,
      required super.address,
      required super.city,
      required super.postalCode,
      required super.country,
      required super.imageProfile,
      required super.email,
      required super.verified,
      required this.firstName,
      required this.lastName,
      required this.birthDayDate,
      required this.myAssociations,
      required this.myAssociationsWaiting});

  Map<String, Object> map() {
    Map<String, Object> result = {};
    result.addAll({
      "firstName": firstName,
      "lastName": lastName,
      "bio": bio,
      "email": email,
      "phone": phone,
      "address": address,
      "city": city,
      "postalCode": postalCode,
      "country": country,
      "birthDayDate": birthDayDate,
      "imageProfile": imageProfile,
      "myAssociations": [],
      "myAssociationsWaiting": [],
      "verified": verified
    });
    return result;
  }
}

class AssoParam extends ParamUser {
  String name;

  String siret;

  List<String> ads;

  List<String> volunteersWaiting;

  AssoParam({
    required this.name,
    required super.bio,
    required super.phone,
    required super.address,
    required super.city,
    required super.postalCode,
    required super.country,
    required super.imageProfile,
    required super.email,
    required super.verified,
    required this.siret,
    required this.ads,
    required this.volunteersWaiting,
  });

  Map<String, Object> map() {
    Map<String, Object> result = {};
    result.addAll({
      "name": name,
      "email": email,
      "bio": bio,
      "phone": phone,
      "address": address,
      "city": city,
      "postalCode": postalCode,
      "country": country,
      "imageProfile": imageProfile,
      "siret": "85235345700017",
      "ads": [],
      "volunteers": [],
      "volunteersWaiting": [],
      "verified": verified
    });
    return result;
  }
}

class Ads {
  String associationId;
  String nameAssociation;
  String datePublication;
  String dateEvent;
  String nameEvent;
  String description;
  String location;
  String image;
  String type;
  int nbHours;
  int nbPlaces;
  List<String> tags;
  List<String> volunteers;
  List<String> volunteersWaiting;
  int nbPlacesTaken;
  bool full;

  Ads({
    required this.associationId,
    required this.nameAssociation,
    required this.datePublication,
    required this.dateEvent,
    required this.nameEvent,
    required this.description,
    required this.location,
    required this.image,
    required this.type,
    required this.nbHours,
    required this.tags,
    required this.nbPlaces,
    required this.volunteers,
    required this.volunteersWaiting,
    required this.nbPlacesTaken,
    required this.full,
  });

  Map<String, Object> map() {
    Map<String, Object> result = {};
    result.addAll({
      "associationId": associationId,
      "nameAssociation": nameAssociation,
      "datePublication": datePublication,
      "dateEvent": dateEvent,
      "nameEvent": description,
      "description": nameEvent,
      "location": location,
      "image": image,
      "type": type,
      "nbHours": nbHours,
      "tags": [],
      "nbPlaces": nbPlaces,
      "volunteers": [],
      "volunteersWaiting": [],
      "nbPlacesTaken": nbPlacesTaken,
      "full": full
    });
    return result;
  }
}
