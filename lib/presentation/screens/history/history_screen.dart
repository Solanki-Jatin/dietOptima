import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../widgets/history_graph.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PROGRESS LOG",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Protein Trend (7 Days)",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 15),
            const HistoryGraph(),
            const SizedBox(height: 30),
            const Text(
              "Recent Days",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 15),

            _buildHistoryItem("Today", "145g / 150g", true),
            _buildHistoryItem("Yesterday", "155g / 150g", true),
            _buildHistoryItem("28 March", "110g / 150g", false),
            _buildHistoryItem("27 March", "160g / 150g", true),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(String date, String status, bool goalMet) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Row(
            children: [
              Text(
                status,
                style: TextStyle(
                  color: goalMet ? AppColors.primary : AppColors.accent,
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                goalMet ? Icons.check_circle : Icons.error_outline,
                color: goalMet ? AppColors.primary : AppColors.accent,
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
