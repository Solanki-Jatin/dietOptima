import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../core/theme/app_colors.dart';
import '../../../providers/diet_provider.dart';
import 'widgets/daily_summary_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dietProvider = Provider.of<DietProvider>(context);
    final user = dietProvider.user;

    // Logic for targets with fallbacks
    double calorieTarget = user?.calorieTarget ?? 2000;
    double proteinTarget = user?.proteinTarget ?? 150;

    double calPercent = (dietProvider.totalCalories / calorieTarget).clamp(
      0.0,
      1.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "DIETOPTIMA",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2.0),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Enhancement: Personalized Greeting
            Text(
              "Hi, ${user?.name ?? 'Champ'}! 👋",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Here is your progress for today.",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 25),

            DailySummaryCard(
              consumed: dietProvider.totalCalories,
              target: calorieTarget,
            ),
            const SizedBox(height: 40),

            // Central Calories Ring with Enhancement: Shadow & Smooth Animation
            Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: CircularPercentIndicator(
                  radius: 110.0,
                  lineWidth: 18.0,
                  percent: calPercent,
                  animation: true,
                  animateFromLastPercent: true,
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${dietProvider.totalCalories.toInt()}",
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "kcal",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ],
                  ),
                  progressColor: AppColors.primary,
                  backgroundColor: AppColors.surface,
                ),
              ),
            ),

            const SizedBox(height: 50),

            // Macro Bars Section
            _buildMacroRow(
              "Protein",
              dietProvider.totalProtein,
              proteinTarget,
              AppColors.primary,
            ),
            const SizedBox(height: 25),
            _buildMacroRow("Carbs", 0, 250, Colors.blueAccent),
            const SizedBox(height: 25),
            _buildMacroRow("Fats", 0, 70, AppColors.accent),

            const SizedBox(height: 100), // Space for FAB
          ],
        ),
      ),

      // CHANGE 5.3: Navigates to Scanner instead of adding mock data
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, '/scanner'),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add_a_photo, color: Colors.black),
        label: const Text(
          "SCAN MEAL",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }

  Widget _buildMacroRow(
    String title,
    double current,
    double target,
    Color color,
  ) {
    double percent = (current / target).clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              "${current.toInt()}g / ${target.toInt()}g",
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        LinearPercentIndicator(
          lineHeight: 12.0,
          percent: percent,
          animation: true,
          animateFromLastPercent: true,
          backgroundColor: AppColors.surface,
          progressColor: color,
          barRadius: const Radius.circular(10),
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}
