import 'package:flutter/cupertino.dart';
import 'package:namer_app/util/showDialog.dart';

class ErrorFirebase implements Exception {
  static void errorCheck(String code, BuildContext context) {
    if (code == "invalid-email") {
      ShowDialog.show(
          context, "Email incorrect", "L'adresse e-mail est mal formatée.");
    } else if (code == "user-disabled") {
      ShowDialog.show(context, "Compte désactivé",
          "Ce compte a été désactivé par un administrateur.");
    } else if (code == "user-not-found") {
      ShowDialog.show(context, "Utilisateur non trouvé",
          "Aucun utilisateur correspondant à cet identifiant n'a été trouvé.");
    } else if (code == "wrong-password") {
      ShowDialog.show(context, "Mot de passe incorrect",
          "Le mot de passe est invalide pour cet e-mail.");
    } else if (code == "email-already-in-use") {
      ShowDialog.show(context, "Email déjà utilisé",
          "Un compte existe déjà avec l'adresse e-mail fournie.");
    } else if (code == "operation-not-allowed") {
      ShowDialog.show(context, "Opération non autorisée",
          "Cette opération n'est pas autorisée.");
    } else if (code == "weak-password") {
      ShowDialog.show(context, "Mot de passe faible",
          "Le mot de passe n'est pas assez fort.");
    } else if (code == "account-exists-with-different-credential") {
      ShowDialog.show(
          context,
          "Compte existant avec des identifiants différents",
          "Un compte existe déjà avec l'adresse e-mail fournie mais avec des identifiants différents.");
    } else if (code == "network-request-failed") {
      ShowDialog.show(
          context, "Erreur de réseau", "Une erreur de réseau est survenue.");
    } else if (code == "too-many-requests") {
      ShowDialog.show(context, "Trop de tentatives",
          "Trop de tentatives de connexion ont été effectuées. Essayez de nouveau plus tard.");
    } else if (code == "credential-already-in-use") {
      ShowDialog.show(context, "Identifiants déjà utilisés",
          "Ces informations d'identification sont déjà associées à un autre compte utilisateur.");
    } else if (code == "requires-recent-login") {
      ShowDialog.show(context, "Authentification récente requise",
          "Cette opération nécessite une authentification récente. Reconnectez-vous avant de réessayer.");
    } else {
      ShowDialog.show(
          context, "Erreur", "Votre email ou mot de passe est incorrect.");
    }
  }
}
