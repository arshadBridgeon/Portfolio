import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_constants.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < AppConstants.mobileBreakpoint;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
      color: AppColors.darkCard,
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 50),
          isMobile
              ? Column(
                  children: [
                    _buildAboutText(),
                    const SizedBox(height: 50),
                    _buildStatsGrid(isMobile),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildAboutText()),
                    const SizedBox(width: 50),
                    Expanded(child: _buildStatsGrid(isMobile)),
                  ],
                ),
        ],
      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, curve: Curves.easeOutQuad),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const Text(
          "About Me",
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

  Widget _buildAboutText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Professional Path",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 20),
        Text(
          "I am a passionate Flutter Developer with over 3 years of experience in building mobile and web applications. My goal is to create seamless user experiences with clean and maintainable code.",
          style: TextStyle(fontSize: 18, color: Colors.grey[400], height: 1.6),
        ),
        const SizedBox(height: 20),
        Text(
          "I specialize in Dart, Firebase, and State Management. I love solving complex architectural challenges and building robust mobile applications.",
          style: TextStyle(fontSize: 18, color: Colors.grey[400], height: 1.6),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(bool isMobile) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childAspectRatio: 1.5,
      children: [
        _statCard("3+", "Years Experience"),
        _statCard("50+", "Projects Completed"),
        _statCard("20+", "Happy Clients"),
        _statCard("10+", "Certifications"),
      ],
    );
  }

  Widget _statCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.darkBg,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
