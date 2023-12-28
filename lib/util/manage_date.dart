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

    String formattedDate = '${dateParts[2]}-${dateParts[1]}-${dateParts[0]}';

    return formattedDate + ' ' + dateTimeParts[1];
  }

  static String describeRelativeDateTime(String dateStr) {
    try {
      DateTime inputDate = DateTime.parse(ManageDate.convertDate(dateStr));
      DateTime now = DateTime.now();
      Duration difference = now.difference(inputDate);

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
