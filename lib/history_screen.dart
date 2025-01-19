import 'package:fitcalc/model/bmi_data.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  void refreshList() {
    setState(() {});
  }

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
            ),
            DeleteHistoryButton(onHistoryCleared: refreshList),
          ],
        ),
      ),
    );
  }
}

class DeleteHistoryButton extends StatefulWidget {
  final VoidCallback onHistoryCleared;

  const DeleteHistoryButton({super.key, required this.onHistoryCleared});

  @override
  State<DeleteHistoryButton> createState() => _DeleteHistoryButtonState();
}

class _DeleteHistoryButtonState extends State<DeleteHistoryButton> {
  void _clearHistory() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear History'),
          content: const Text('Are you sure to delete all history?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                BmiHistory.history.clear();
                widget
                    .onHistoryCleared(); // Panggil callback untuk refresh list
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Delete'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, right: 8.0),
      child: IconButton(
        onPressed: _clearHistory,
        icon: const Icon(Icons.delete_outline),
        color: Colors.red,
      ),
    );
  }
}
