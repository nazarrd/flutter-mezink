import 'dart:math';

String randomEngagement() {
  final random = Random();

  // generate a random number between 0 and 100 for the integer part (engagement rate)
  // 0 to 100 (inclusive)
  int engagementRate = random.nextInt(101);

  // generate a random number between 0 and 9 for the decimal part
  int decimal = random.nextInt(10);

  // format the engagement rate with one decimal place and "%"
  return '$engagementRate.$decimal %';
}
