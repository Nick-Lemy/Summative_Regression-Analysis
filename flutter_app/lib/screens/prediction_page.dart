import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/app_colors.dart';
import '../widgets/app_logo.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/gradient_button.dart';
import '../widgets/result_card.dart';

class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  State<PredictionPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  final _completionMaleController = TextEditingController();
  final _completionFemaleController = TextEditingController();
  final _tertiaryEnrollmentController = TextEditingController();
  final _literacyMaleController = TextEditingController();
  final _literacyFemaleController = TextEditingController();
  final _birthRateController = TextEditingController();
  
  String _result = '';
  bool _isLoading = false;
  bool _hasError = false;

  final String apiUrl = 'https://summative-regression-analysis.onrender.com/predict';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _completionMaleController.dispose();
    _completionFemaleController.dispose();
    _tertiaryEnrollmentController.dispose();
    _literacyMaleController.dispose();
    _literacyFemaleController.dispose();
    _birthRateController.dispose();
    super.dispose();
  }

  Future<void> _predict() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _result = '';
      _hasError = false;
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'completion_rate_upper_secondary_male': double.parse(_completionMaleController.text),
          'completion_rate_upper_secondary_female': double.parse(_completionFemaleController.text),
          'gross_tertiary_education_enrollment': double.parse(_tertiaryEnrollmentController.text),
          'youth_literacy_rate_male': double.parse(_literacyMaleController.text),
          'youth_literacy_rate_female': double.parse(_literacyFemaleController.text),
          'birth_rate': double.parse(_birthRateController.text),
        }),
      );

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          throw Exception('Empty response from server');
        }

        final data = jsonDecode(response.body);
        setState(() {
          _result = '${data['predicted_unemployment_rate'].toStringAsFixed(2)}%';
          _hasError = false;
        });
      } else {
        setState(() {
          _result = 'Server error: ${response.statusCode}';
          _hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        _result = 'Connection failed: ${e.toString()}';
        _hasError = true;
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  String? _validatePercentage(String? value) {
    if (value == null || value.isEmpty) return 'This field is required';
    final number = double.tryParse(value);
    if (number == null) return 'Enter a valid number';
    if (number < 0 || number > 100) return 'Must be between 0 and 100';
    return null;
  }

  String? _validateBirthRate(String? value) {
    if (value == null || value.isEmpty) return 'This field is required';
    final number = double.tryParse(value);
    if (number == null) return 'Enter a valid number';
    if (number < 0 || number > 60) return 'Must be between 0 and 60';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.background,
              Colors.blue.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const AppLogo(),
                    const SizedBox(height: 32),
                    
                    _buildInfoCard(),
                    const SizedBox(height: 24),
                    
                    _buildSectionTitle('Secondary Education Completion Rates'),
                    const SizedBox(height: 16),
                    
                    CustomTextField(
                      controller: _completionMaleController,
                      label: 'Male Completion Rate',
                      hint: '0-100%',
                      icon: Icons.male,
                      validator: _validatePercentage,
                    ),
                    const SizedBox(height: 16),
                    
                    CustomTextField(
                      controller: _completionFemaleController,
                      label: 'Female Completion Rate',
                      hint: '0-100%',
                      icon: Icons.female,
                      validator: _validatePercentage,
                    ),
                    const SizedBox(height: 24),
                    
                    _buildSectionTitle('Youth Literacy Rates'),
                    const SizedBox(height: 16),
                    
                    CustomTextField(
                      controller: _literacyMaleController,
                      label: 'Male Youth Literacy',
                      hint: '0-100%',
                      icon: Icons.menu_book,
                      validator: _validatePercentage,
                    ),
                    const SizedBox(height: 16),
                    
                    CustomTextField(
                      controller: _literacyFemaleController,
                      label: 'Female Youth Literacy',
                      hint: '0-100%',
                      icon: Icons.auto_stories,
                      validator: _validatePercentage,
                    ),
                    const SizedBox(height: 24),
                    
                    _buildSectionTitle('Higher Education & Demographics'),
                    const SizedBox(height: 16),
                    
                    CustomTextField(
                      controller: _tertiaryEnrollmentController,
                      label: 'Tertiary Education Enrollment',
                      hint: '0-100%',
                      icon: Icons.school,
                      validator: _validatePercentage,
                    ),
                    const SizedBox(height: 16),
                    
                    CustomTextField(
                      controller: _birthRateController,
                      label: 'Birth Rate (per 1000)',
                      hint: '0-60',
                      icon: Icons.child_care,
                      validator: _validateBirthRate,
                    ),
                    const SizedBox(height: 32),
                    
                    GradientButton(
                      text: 'Predict Unemployment Rate',
                      icon: Icons.analytics_outlined,
                      isLoading: _isLoading,
                      onPressed: _predict,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    ResultCard(
                      result: _result,
                      hasError: _hasError,
                    ),
                    
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            gradient: AppColors.gradient,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.secondary.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: AppColors.primary, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Enter education indicators to predict unemployment rate in African countries',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
