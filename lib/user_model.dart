class UserModel {
  final String name;
  final double weight;
  final double height;
  final int age;
  final String goal; // 'Bulk', 'Cut', 'Maintain'

  UserModel({
    required this.name,
    required this.weight,
    required this.height,
    required this.age,
    required this.goal,
  });

  // Simple logic to calculate Daily Protein (2g per kg for muscle building)
  double get proteinTarget => weight * 2.0;

  // Simple Calorie target logic
  double get calorieTarget {
    double base = (10 * weight) + (6.25 * height) - (5 * age) + 5;
    if (goal == 'Bulk') return base + 500;
    if (goal == 'Cut') return base - 500;
    return base;
  }
}
