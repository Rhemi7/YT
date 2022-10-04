class NumberFormatter {
  static String? formatter(String number) {
    double value = double.parse(number);

    if (value < 1000000) {
      // less than a million
      return value.toStringAsFixed(2);
    } else if (value >= 1000000 && value < (1000000 * 100 * 10)) {
      // less than 100 million
      double result = value / 1000000;
      return "${result.toStringAsFixed(2)}Mn";
    } else if (value >= (1000000 * 10 * 100) &&
        value < (1000000 * 10 * 100 * 100 * 10)) {
      // less than 100 billion
      double result = value / (1000000 * 100 * 10);
      return "${result.toStringAsFixed(2)}Bn";
    }
  }
}
