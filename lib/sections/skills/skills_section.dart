import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_constants.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> skills = [
      {"name": "Flutter", "level": 0.95},
      {"name": "Dart", "level": 0.90},
      {"name": "Firebase", "level": 0.85},
      {"name": "REST API", "level": 0.80},
      {"name": "Git & GitHub", "level": 0.85},
      {"name": "Clean Architecture", "level": 0.85},
      {"name": "State Management", "level": 0.90},
      {"name": "SQL/NoSQL", "level": 0.70},
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 50),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: skills.map((skill) => _skillCard(skill)).toList(),
          ),
        ],
      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const Text(
          "Technical Skills",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Container(
          width: 50,
          height: 3,
          color: AppColors.primaryColor,
        ),
      ],
    );
  }

  Widget _skillCard(Map<String, dynamic> skill) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            skill["name"],
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 15),
          LinearProgressIndicator(
            value: skill["level"],
            backgroundColor: Colors.grey[800],
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "${(skill["level"] * 100).toInt()}%",
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
