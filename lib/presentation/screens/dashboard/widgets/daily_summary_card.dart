import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class DailySummaryCard extends StatelessWidget {
  final double consumed;
  final double target;

  const DailySummaryCard({
    super.key,
    required this.consumed,
    required this.target,
  });

  @override
  Widget build(BuildContext context) {
    double remaining = target - consumed;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatColumn(
            "Consumed",
            consumed.toInt().toString(),
            AppColors.primary,
          ),
          Container(width: 1, height: 40, color: Colors.grey[800]),
          _buildStatColumn(
            "Remaining",
            remaining < 0 ? "0" : remaining.toInt().toString(),
            AppColors.accent,
          ),
          Container(width: 1, height: 40, color: Colors.grey[800]),
          _buildStatColumn("Target", target.toInt().toString(), Colors.white),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
