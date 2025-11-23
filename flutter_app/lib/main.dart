import 'package:flutter/material.dart';
import 'constants/app_theme.dart';
import 'screens/prediction_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduCareer AI - Unemployment Predictor',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const PredictionPage(),
    );
  }
}
