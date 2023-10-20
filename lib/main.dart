import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/app_colors.dart';
import 'extension/screen_util.dart';
import 'providers/user_provider.dart';
import 'screens/user/user_screen.dart';

void main() {
  runApp(MaterialApp(
    title: 'Mezink Test',
    navigatorKey: navigatorKey,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.secondary,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    ),
    home: MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: const UserScreen(),
    ),
  ));
}
