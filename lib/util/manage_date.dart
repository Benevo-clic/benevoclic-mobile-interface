class ManageDate {
  static String convertDate(String dateStr) {
    // Sépare la chaîne de date et d'heure en deux parties
    var dateTimeParts = dateStr.split(' ');
    if (dateTimeParts.length != 2) {
      return "Format de date et d'heure invalide";
    }

    // Sépare la partie de date
    var dateParts = dateTimeParts[0].split('/');
    if (dateParts.length != 3) {
      return "Format de date invalide";
    }

    // Réassemble la date au format 'yyyy-MM-dd'
    String formattedDate = '${dateParts[2]}-${dateParts[1]}-${dateParts[0]}';

    // Ajoute la partie de l'heure
    return formattedDate + ' ' + dateTimeParts[1];
  }

  static String describeRelativeDateTime(String dateStr) {
    try {
      DateTime inputDate = DateTime.parse(ManageDate.convertDate(dateStr));
      DateTime now = DateTime.now();
      Duration difference = now.difference(inputDate);

      // Calculer les différences en termes de jours, heures, minutes
      int days = difference.inDays;
      int hours = difference.inHours % 24;
      int minutes = difference.inMinutes % 60;

      if (days > 1) {
        return "il y a $days jours";
      } else if (days == 1) {
        return "il y a un jour";
      } else if (hours > 1) {
        return "il y a $hours heures";
      } else if (hours == 1) {
        return "il y a 1 heure";
      } else if (minutes > 1) {
        return "il y a $minutes minutes";
      } else {
        return "il y a 1 minute";
      }
    } catch (e) {
      return "Format de date invalide";
    }
  }
}
