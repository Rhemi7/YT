class DateDifference {
  static String getDifference(DateTime dateToday, DateTime dateCreated) {
    int difference = dateToday.difference(dateCreated).inDays;
    int diffMin = dateToday.difference(dateCreated).inMinutes;
    int diffHours = dateToday.difference(dateCreated).inHours;
    int diffSecs = dateToday.difference(dateCreated).inSeconds;

    String statement = "";
    if (difference >= 7) {
      double result = difference / 7;
      if (result.round() == 1) {
        statement = '${result.round()} wk ago';
      } else if (result.round() > 1) {
        statement = '${result.round()} wks ago';
      }
    } else if (difference >= 1 && difference < 7) {
      if (difference == 1) {
        statement = '$difference day ago';
      } else {
        statement = '$difference days ago';
      }
    } else if (diffMin < 60) {
      if (diffMin < 1) {
        statement = '$diffSecs secs ago';
      } else if (diffMin == 1) {
        statement = '$diffMin min ago';
      } else {
        statement = '$diffMin mins ago';
      }
    } else if (diffMin >= 60) {
      statement = '$diffHours hrs ago';
    }
    return statement;
  }
}
