class BmiData {
  final double bmi;
  final String category;
  final String gender;
  final String date;
  final double weight;
  final double height;

  BmiData({
    required this.bmi,
    required this.category,
    required this.gender,
    required this.date,
    required this.weight,
    required this.height,
  });
}

class BmiHistory {
  static List<BmiData> history = [];
}
