import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../providers/diet_provider.dart';
import '../../../services/api_service.dart'; // Ensure this import exists

class ResultPreviewScreen extends StatefulWidget {
  final String imagePath;

  const ResultPreviewScreen({super.key, required this.imagePath});

  @override
  State<ResultPreviewScreen> createState() => _ResultPreviewScreenState();
}

class _ResultPreviewScreenState extends State<ResultPreviewScreen> {
  bool _isLoading = true;
  String _foodName = "Analyzing...";
  double _calories = 0;
  double _protein = 0;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchAiResults();
  }

  // This function connects to your Flask Backend
  Future<void> _fetchAiResults() async {
    try {
      final result = await ApiService.analyzeImage(widget.imagePath);

      if (result != null) {
        setState(() {
          _foodName = result['item'] ?? "Unknown Food";
          _calories = (result['calories'] ?? 0).toDouble();
          _protein = (result['protein'] ?? 0).toDouble();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = "Server error. Check your Flask terminal.";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Connection failed. Is Flask running?";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Detection")),
      body: Column(
        children: [
          // Image Preview
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: FileImage(File(widget.imagePath)),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Result Card
          Container(
            padding: const EdgeInsets.all(30),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  )
                : _errorMessage != null
                ? _buildErrorUI()
                : _buildSuccessUI(context),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorUI() {
    return Column(
      children: [
        const Icon(Icons.error_outline, color: Colors.red, size: 40),
        const SizedBox(height: 10),
        Text(_errorMessage!, textAlign: TextAlign.center),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Go Back"),
        ),
      ],
    );
  }

  Widget _buildSuccessUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("AI Detected:", style: TextStyle(color: Colors.grey)),
        Text(
          _foodName,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Protein: ${_protein.toInt()}g",
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              "Calories: ${_calories.toInt()} kcal",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: () {
              Provider.of<DietProvider>(
                context,
                listen: false,
              ).addMeal(_foodName, _calories, _protein);
              Navigator.popUntil(context, ModalRoute.withName('/dashboard'));
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text(
              "Confirm & Add to Log",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
