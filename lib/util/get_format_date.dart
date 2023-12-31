String formatDate(DateTime? date) {
  if (date != null) {
    return "${date.day.toString()}/${date.month.toString()}/${date.year.toString()}";
  } else {
    return "";
  }
}