import 'package:fitcalc/model/bmi_data.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                'History BMI',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: BmiHistory.history.length,
                itemBuilder: (context, index) {
                  final data = BmiHistory.history[index];
                  return Card(
                    margin: const EdgeInsets.only(
                      top: 15.0,
                      left: 8.0,
                      right: 8.0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date: ${data.date}'),
                          const SizedBox(height: 5),
                          Text(
                            'BMI: ${data.bmi.toStringAsFixed(1)} (${data.category})',
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
