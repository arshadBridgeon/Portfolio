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
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: isMobile ? 24 : 50,
      ),
      color: AppColors.darkCard,
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 50),
          isMobile
              ? Column(
                  children: [
                    _buildAboutText(isMobile),
                    const SizedBox(height: 50),
                    _buildStatsGrid(isMobile),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildAboutText(isMobile)),
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

  Widget _buildAboutText(bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          "Professional Path",
          style: TextStyle(fontSize: isMobile ? 20 : 24, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 20),
        Text(
          "I am a passionate Flutter Developer with over 3 years of experience in building mobile and web applications. My goal is to create seamless user experiences with clean and maintainable code.",
          style: TextStyle(fontSize: isMobile ? 16 : 18, color: Colors.grey[400], height: 1.6),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 20),
        Text(
          "I specialize in Dart, Firebase, and State Management. I love solving complex architectural challenges and building robust mobile applications.",
          style: TextStyle(fontSize: isMobile ? 16 : 18, color: Colors.grey[400], height: 1.6),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
      ],
    );
  }

  Widget _buildStatsGrid(bool isMobile) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      childAspectRatio: isMobile ? 1.1 : 1.5,
      children: [
        _statCard("1+", "Year Experience", isMobile),
        _statCard("4+", "Projects Completed", isMobile),
      ],
    );
  }

  Widget _statCard(String value, String label, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 20),
      decoration: BoxDecoration(
        color: AppColors.darkBg,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: TextStyle(
                fontSize: isMobile ? 22 : 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Flexible(
            child: Text(
              label,
              style: TextStyle(fontSize: isMobile ? 12 : 14, color: Colors.grey),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
