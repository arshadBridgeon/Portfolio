import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_constants.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> experiences = [
      {
        "company": "Total-X",
        "role": "Flutter Developer",
        "duration": "1+ Year | Present",
        "desc": "Developing high-performance, cross-platform mobile applications using Flutter and Firebase. Focusing on clean architecture and delivering seamless user experiences.",
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint ? 60 : 100,
        horizontal: MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint ? 24 : 50,
      ),
      color: AppColors.darkCard,
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 50),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: experiences.length,
              itemBuilder: (context, index) {
                return _timelineTile(experiences[index], index == experiences.length - 1);
              },
            ),
          ),
        ],
      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const Text(
          "Professional Experience",
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

  Widget _timelineTile(Map<String, String> exp, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors.primaryColor.withOpacity(0.3),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exp["role"]!,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${exp["company"]} | ${exp["duration"]}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    exp["desc"]!,
                    style: TextStyle(fontSize: 16, color: Colors.grey[400], height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
