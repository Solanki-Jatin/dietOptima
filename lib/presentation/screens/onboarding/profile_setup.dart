import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/calculations.dart';
import '../../../models/user_model.dart';
import '../../../providers/diet_provider.dart';
import '../../widgets/custom_input.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  String _selectedGoal = 'Maintain';

  void _saveProfile() {
    // 1. Create the User Model
    final newUser = UserModel(
      name: _nameController.text,
      age: int.parse(_ageController.text),
      weight: double.parse(_weightController.text),
      height: double.parse(_heightController.text),
      goal: _selectedGoal,
    );

    // 2. Save to Provider (The Brain)
    Provider.of<DietProvider>(context, listen: false).setUser(newUser);

    // 3. Move to Dashboard (We will build this next!)
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const Text(
                "Let's Get Started",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const Text(
                "Enter your details to calculate your targets.",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 40),
              CustomInput(
                label: "Name",
                controller: _nameController,
                type: TextInputType.text,
                icon: Icons.person,
              ),
              const SizedBox(height: 20),
              CustomInput(
                label: "Age",
                controller: _ageController,
                icon: Icons.calendar_today,
              ),
              const SizedBox(height: 20),
              CustomInput(
                label: "Weight (kg)",
                controller: _weightController,
                icon: Icons.monitor_weight,
              ),
              const SizedBox(height: 20),
              CustomInput(
                label: "Height (cm)",
                controller: _heightController,
                icon: Icons.height,
              ),
              const SizedBox(height: 30),
              const Text(
                "What is your goal?",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                dropdownColor: AppColors.surface,
                value: _selectedGoal,
                items: ['Bulk', 'Cut', 'Maintain']
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (val) => setState(() => _selectedGoal = val!),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Calculate My Goals",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
