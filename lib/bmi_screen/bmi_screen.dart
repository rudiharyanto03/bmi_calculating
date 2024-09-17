import 'package:bmi_calculator/bmi_screen/profile_screen.dart';
import 'package:flutter/material.dart';

class BMICalculatorScreen extends StatefulWidget {
  final String gender;
  final DateTime birthDate;

  BMICalculatorScreen({required this.gender, required this.birthDate});

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

  // Fungsi validasi angka desimal dengan jumlah digit maksimal
  String? _validateDecimal(String value, int maxDigits) {
    final regex = RegExp(r'^\d{1,' + maxDigits.toString() + r'}(\.\d{0,1})?$');
    if (!regex.hasMatch(value)) {
      return 'Invalid input';
    }
    return null;
  }

  // Fungsi validasi nilai lemak viseral (1-12)
  String? _validateVisceralFat(String value) {
    final visceralFat = int.tryParse(value);
    if (visceralFat == null || visceralFat < 1 || visceralFat > 12) {
      return 'Must be between 1 and 12';
    }
    return null;
  }

  // Fungsi untuk mengarahkan pengguna ke halaman profil setelah validasi
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
        title: Text('Tambah Berat Badan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Berat Badan (Kg)
              TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Berat Badan (Kg)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your weight';
                  }
                  // Validasi maksimal 3 digit dan desimal
                  return _validateDecimal(value, 3);
                },
              ),
              SizedBox(height: 16),

// Tinggi Badan (Cm)
              TextFormField(
                controller: _heightController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Tinggi Badan (Cm)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your height';
                  }
                  // Validasi maksimal 3 digit dan desimal
                  return _validateDecimal(value, 3);
                },
              ),
              SizedBox(height: 16),

// Body Fat (%)
              TextFormField(
                controller: _bodyFatController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Body Fat (%)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    // Validasi maksimal 2 digit dan desimal
                    return _validateDecimal(value, 2);
                  }
                  return null; // Field ini opsional
                },
              ),
              SizedBox(height: 16),

// Muscle Mass (Kg)
              TextFormField(
                controller: _muscleMassController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Muscle Mass (Kg)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    // Validasi maksimal 2 digit dan desimal
                    return _validateDecimal(value, 2);
                  }
                  return null; // Field ini opsional
                },
              ),
              SizedBox(height: 16),

// Visceral Fat
              TextFormField(
                controller: _visceralFatController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Visceral Fat (1-12)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    return _validateVisceralFat(value);
                  }
                  return null; // Field ini opsional
                },
              ),
              SizedBox(height: 16),

// Basal Metabolism (Kcal)
              TextFormField(
                controller: _basalMetabolismController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Basal Metabolism (Kcal)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    // Validasi maksimal 4 digit
                    final regex = RegExp(r'^\d{1,4}$');
                    if (!regex.hasMatch(value)) {
                      return 'Must be a valid number with max 4 digits';
                    }
                  }
                  return null; // Field ini opsional
                },
              ),

              SizedBox(height: 16),

              // Tombol submit
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
