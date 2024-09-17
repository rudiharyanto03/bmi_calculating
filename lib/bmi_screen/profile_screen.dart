import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProfilePage extends StatelessWidget {
  final String gender;
  final DateTime birthDate;
  final double weight;
  final double height;
  final double? bodyFat;
  final double? muscleMass;
  final int? visceralFat;
  final int? basalMetabolism;

  const ProfilePage({
    super.key,
    required this.gender,
    required this.birthDate,
    required this.weight,
    required this.height,
    this.bodyFat,
    this.muscleMass,
    this.visceralFat,
    this.basalMetabolism,
  });

  double calculateBMI() {
    return weight / ((height / 100) * (height / 100));
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Normal';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obesity';
    }
  }

  @override
  Widget build(BuildContext context) {
    double bmi = calculateBMI();
    String bmiCategory = getBMICategory(bmi);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile Overview',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purpleAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Profile Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('Gender: $gender'),
            Text(
                'Birth Date: ${birthDate.day}/${birthDate.month}/${birthDate.year}'),
            Text('Weight: ${weight.toStringAsFixed(1)} kg'),
            Text('Height: ${height.toStringAsFixed(1)} cm'),
            if (bodyFat != null)
              Text('Body Fat: ${bodyFat!.toStringAsFixed(1)}%'),
            if (muscleMass != null)
              Text('Muscle Mass: ${muscleMass!.toStringAsFixed(1)} kg'),
            if (visceralFat != null) Text('Visceral Fat: $visceralFat'),
            if (basalMetabolism != null)
              Text('Basal Metabolism: $basalMetabolism kcal'),
            const SizedBox(height: 24),
            const Text(
              'BMI Result',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('BMI: ${bmi.toStringAsFixed(2)} ($bmiCategory)',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 24),
            const Text(
              'BMI Graph',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              title: ChartTitle(text: 'BMI Categories'),
              legend: Legend(isVisible: false),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries>[
                ColumnSeries<ChartData, String>(
                  dataSource: <ChartData>[
                    ChartData('Underweight', 18.5, Colors.blue),
                    ChartData('Normal', 24.9, Colors.green),
                    ChartData('Overweight', 29.9, Colors.orange),
                    ChartData('Obesity', 40, Colors.red),
                    ChartData('Your BMI', bmi, Colors.purple),
                  ],
                  pointColorMapper: (ChartData data, _) => data.color,
                  xValueMapper: (ChartData data, _) => data.category,
                  yValueMapper: (ChartData data, _) => data.value,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  final String category;
  final double value;
  final Color color;

  ChartData(this.category, this.value, this.color);
}
