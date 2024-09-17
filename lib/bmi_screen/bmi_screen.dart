import 'package:bmi_calculator/bmi_screen/profile_screen.dart';
import 'package:flutter/material.dart';

class BMICalculatorScreen extends StatefulWidget {
  final String gender;
  final DateTime birthDate;

  const BMICalculatorScreen(
      {super.key, required this.gender, required this.birthDate});

  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _bodyFatController = TextEditingController();
  final TextEditingController _muscleMassController = TextEditingController();
  final TextEditingController _visceralFatController = TextEditingController();
  final TextEditingController _basalMetabolismController =
      TextEditingController();

  String? _validateDecimal(String value, int maxDigits) {
    final regex = RegExp(r'^\d{1,' + maxDigits.toString() + r'}(\.\d{0,1})?$');
    if (!regex.hasMatch(value) && maxDigits == 2) {
      return 'Invalid input maks 2 digits';
    }
    if (!regex.hasMatch(value) && maxDigits == 3) {
      return 'Invalid input maks 3 digit';
    }
    return null;
  }

  String? _validateVisceralFat(String value) {
    final visceralFat = int.tryParse(value);
    if (visceralFat == null || visceralFat < 1 || visceralFat > 12) {
      return 'Must be between 1 and 12';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            gender: widget.gender,
            birthDate: widget.birthDate,
            weight: double.parse(_weightController.text),
            height: double.parse(_heightController.text),
            bodyFat: _bodyFatController.text.isNotEmpty
                ? double.parse(_bodyFatController.text)
                : null,
            muscleMass: _muscleMassController.text.isNotEmpty
                ? double.parse(_muscleMassController.text)
                : null,
            visceralFat: _visceralFatController.text.isNotEmpty
                ? int.parse(_visceralFatController.text)
                : null,
            basalMetabolism: _basalMetabolismController.text.isNotEmpty
                ? int.parse(_basalMetabolismController.text)
                : null,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Berat Badan',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purpleAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _weightController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Berat Badan (Kg)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your weight';
                  }
                  return _validateDecimal(value, 3);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _heightController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Tinggi Badan (Cm)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your height';
                  }
                  return _validateDecimal(value, 3);
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bodyFatController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Body Fat (%)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return _validateDecimal(value, 2);
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _muscleMassController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Muscle Mass (Kg)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return _validateDecimal(value, 2);
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _visceralFatController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Visceral Fat (1-12)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return _validateVisceralFat(value);
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _basalMetabolismController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Basal Metabolism (Kcal)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final regex = RegExp(r'^\d{1,4}$');
                    if (!regex.hasMatch(value)) {
                      return 'Must be a valid number with max 4 digits';
                    }
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
