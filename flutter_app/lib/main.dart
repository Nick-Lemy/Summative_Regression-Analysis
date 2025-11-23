import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unemployment Predictor',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const PredictionPage(),
    );
  }
}

class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  State<PredictionPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  final _formKey = GlobalKey<FormState>();
  
  final _completionMaleController = TextEditingController();
  final _completionFemaleController = TextEditingController();
  final _tertiaryEnrollmentController = TextEditingController();
  final _literacyMaleController = TextEditingController();
  final _literacyFemaleController = TextEditingController();
  final _birthRateController = TextEditingController();
  
  String _result = '';
  bool _isLoading = false;

  // UPDATE THIS URL after deploying to Render
  final String apiUrl = 'http://127.0.0.1:8000/predict';

  Future<void> _predict() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _result = '';
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
        // Check if the response body is empty or not valid JSON
        if (response.body.isEmpty) {
          throw Exception('Empty response from server');
        }

        final data = jsonDecode(response.body);
        setState(() {
          _result = 'Predicted Unemployment Rate: ${data['predicted_unemployment_rate']}%';
        });
      } else {
        setState(() {
          _result = 'Error: ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unemployment Rate Predictor'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter Education Indicators',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              
              _buildTextField(_completionMaleController, 'Completion Rate Upper Secondary Male (0-100)'),
              _buildTextField(_completionFemaleController, 'Completion Rate Upper Secondary Female (0-100)'),
              _buildTextField(_tertiaryEnrollmentController, 'Gross Tertiary Education Enrollment (0-100)'),
              _buildTextField(_literacyMaleController, 'Youth Literacy Rate Male (0-100)'),
              _buildTextField(_literacyFemaleController, 'Youth Literacy Rate Female (0-100)'),
              _buildTextField(_birthRateController, 'Birth Rate (0-60)'),
              
              const SizedBox(height: 20),
              
              ElevatedButton(
                onPressed: _isLoading ? null : _predict,
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Predict'),
              ),
              
              const SizedBox(height: 20),
              
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _result.isEmpty ? 'Prediction will appear here' : _result,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Required';
          if (double.tryParse(value) == null) return 'Enter a valid number';
          return null;
        },
      ),
    );
  }
}
