convertDateTime(String date) {
  final dateTime = DateTime.parse(date);

  return "${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}";
}
