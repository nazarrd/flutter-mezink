import 'dart:math';

import '../constants/app_values.dart';

String randomGrade() {
  // get a random index within the range of the list
  final random = Random();
  final randomIndex = random.nextInt(grades.length);

  // return the random grade
  return grades[randomIndex];
}
