class DietCalculations {
  /// Calculates Basal Metabolic Rate (BMR) using Mifflin-St Jeor Equation
  static double calculateBMR({
    required double weight,
    required double height,
    required int age,
    required bool isMale,
  }) {
    if (isMale) {
      return (10 * weight) + (6.25 * height) - (5 * age) + 5;
    } else {
      return (10 * weight) + (6.25 * height) - (5 * age) - 161;
    }
  }

  /// Calculates Daily Calorie Target based on Goal
  static double calculateDailyCalories({
    required double bmr,
    required String goal, // 'Bulk', 'Cut', 'Maintain'
  }) {
    switch (goal) {
      case 'Bulk':
        return bmr + 500; // Caloric Surplus
      case 'Cut':
        return bmr - 500; // Caloric Deficit
      default:
        return bmr; // Maintenance
    }
  }

  /// Calculates Daily Protein Target for Indian-Vegetarian Muscle Building
  /// Standard: 1.8g to 2.2g per kg of bodyweight
  static double calculateProteinTarget(double weight) {
    return weight * 2.0;
  }

  /// Calculates Carbs and Fats (Optional but good for a "Major" project)
  static double calculateCarbTarget(double totalCalories) =>
      (totalCalories * 0.5) / 4;
  static double calculateFatTarget(double totalCalories) =>
      (totalCalories * 0.25) / 9;
}
