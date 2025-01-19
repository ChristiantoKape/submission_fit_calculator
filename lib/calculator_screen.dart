import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String weight = '';
  String height = '';
  String? gender;
  double? bmiResult;
  String bmiCategory = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.start, // Mengatur posisi ke kiri
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  'Hitung BMI',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Write your weight here...',
                        labelText: 'Weight(kg)',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (String value) {
                        setState(() {
                          weight = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Write your height here...',
                        labelText: 'Height(cm)',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      onChanged: (String value) {
                        setState(() {
                          height = value;
                        });
                      },
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: DropdownButton<String>(
                  isExpanded: true,
                  alignment: Alignment.centerLeft,
                  items: const <DropdownMenuItem<String>>[
                    DropdownMenuItem<String>(
                      value: 'Male',
                      child: Text('Male'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Female',
                      child: Text('Female'),
                    )
                  ],
                  value: gender,
                  hint: const Text('Select Gender'),
                  onChanged: (String? value) {
                    setState(() {
                      gender = value;
                    });
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 25.0),
                child: ElevatedButton(
                  onPressed: calculateBMI,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('Calculate BMI'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void calculateBMI() {
    if (weight.isNotEmpty && height.isNotEmpty) {
      double weightValue = double.parse(weight);
      double heightValue = double.parse(height) / 100;

      setState(() {
        bmiResult = weightValue / (heightValue * heightValue);
        double roundedBmi = (bmiResult! * 10).ceil() / 10;

        if (roundedBmi < 18.5) {
          bmiCategory = 'Underweight';
        } else if (roundedBmi >= 18.5 && roundedBmi < 25) {
          bmiCategory = 'Normal';
        } else if (roundedBmi >= 25 && roundedBmi < 30) {
          bmiCategory = 'Overweight';
        } else {
          bmiCategory = 'Obese';
        }
      });

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Your BMI: ${bmiResult!.toStringAsFixed(1)}'),
                const SizedBox(height: 8),
                Text('Category: $bmiCategory'),
                const SizedBox(height: 8),
                Text('Gender: ${gender ?? "Not specified"}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              )
            ],
          );
        },
      );
    }
  }
}
