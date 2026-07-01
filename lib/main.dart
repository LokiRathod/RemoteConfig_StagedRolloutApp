import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:rcsr_app/core/utils/app_colors.dart';
import 'package:rcsr_app/core/utils/app_strings.dart';
import 'package:rcsr_app/features/home/view/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: RemoteConfigApp()));
}

class RemoteConfigApp extends StatelessWidget {
  const RemoteConfigApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.brandBlue),
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
      ),
      home: const HomeScreen(),
    );
  }
}
