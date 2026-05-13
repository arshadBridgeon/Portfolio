import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_constants.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint;
    
    final List<Map<String, dynamic>> skills = [
      {"name": "Flutter", "level": 0.95, "icon": Icons.flutter_dash},
      {"name": "Dart", "level": 0.90, "icon": Icons.code},
      {"name": "Firebase", "level": 0.85, "icon": Icons.cloud},
      {"name": "Git & GitHub", "level": 0.85, "icon": FontAwesomeIcons.github},
      {"name": "State Management", "level": 0.90, "icon": Icons.layers},
      {"name": "Clean Architecture", "level": 0.85, "icon": Icons.architecture},
      {"name": "REST API", "level": 0.80, "icon": Icons.api},
      {"name": "SQL/NoSQL", "level": 0.70, "icon": Icons.storage},
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: isMobile ? 24 : 50,
      ),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 50),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: skills.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 2 : 4,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: isMobile ? 1.1 : 1.3,
            ),
            itemBuilder: (context, index) {
              return _skillCard(skills[index], index);
            },
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

  Widget _skillCard(Map<String, dynamic> skill, int index) {
    final bool isFontAwesome = skill["icon"] is IconData == false;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.darkCard.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.1)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isFontAwesome
              ? FaIcon(
                  skill["icon"],
                  color: AppColors.primaryColor,
                  size: 28,
                )
              : Icon(
                  skill["icon"],
                  color: AppColors.primaryColor,
                  size: 30,
                ),
          const SizedBox(height: 10),
          Flexible(
            child: Text(
              skill["name"],
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "${(skill["level"] * 100).toInt()}%",
            style: TextStyle(
              color: AppColors.primaryColor.withOpacity(0.7),
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ).animate(delay: (index * 100).ms).fadeIn(duration: 500.ms).scale(
          begin: const Offset(0.8, 0.8),
          curve: Curves.easeOutBack,
        );
  }
}
