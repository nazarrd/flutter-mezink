import 'dart:math';

String randomFollower() {
  final random = Random();

  // generate a random number between 1 and 999 inclusive for the whole number part
  int wholeNumber = random.nextInt(999) + 1;

  // generate a random number between 0 and 9 for the decimal part
  int decimal = random.nextInt(10);

  // format the followers count with one decimal place and "k"
  return '$wholeNumber.$decimal k';
}
