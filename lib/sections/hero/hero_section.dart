import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:resume_builder/widgets/dialogs/pdf_viewer_dialog.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_constants.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < AppConstants.mobileBreakpoint;

    return Container(
      constraints: BoxConstraints(minHeight: size.height),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.darkBg,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50).copyWith(top: 120, bottom: 50),
          child: isMobile
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildProfileImage(isMobile),
                    const SizedBox(height: 50),
                    ..._buildContent(context, isMobile),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _buildContent(context, isMobile),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: _buildProfileImage(isMobile),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  List<Widget> _buildContent(BuildContext context, bool isMobile) {
    return [
      Text(
        "Hello, I'm",
        style: TextStyle(
          fontSize: isMobile ? 24 : 32,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryColor,
        ),
      ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.2),
      const SizedBox(height: 10),
      Text(
        AppConstants.name,
        style: TextStyle(
          fontSize: isMobile ? 36 : 56,
          fontWeight: FontWeight.bold,
        ),
      ).animate().fadeIn(delay: 200.ms, duration: 500.ms).slideX(begin: -0.2),
      const SizedBox(height: 10),
      SizedBox(
        height: isMobile ? 40 : 60,
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'Flutter Developer',
              textStyle: TextStyle(
                fontSize: isMobile ? 24 : 36,
                fontWeight: FontWeight.w600,
                color: AppColors.accentColor,
              ),
              speed: const Duration(milliseconds: 100),
            ),
          ],
          totalRepeatCount: 1,
          displayFullTextOnTap: true,
          stopPauseOnTap: true,
        ),
      ),
      const SizedBox(height: 20),
      Text(
        AppConstants.intro,
        style: TextStyle(fontSize: isMobile ? 16 : 20, color: Colors.grey),
      ).animate().fadeIn(delay: 400.ms, duration: 500.ms),
      const SizedBox(height: 40),
      Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
            child: const Text("Hire Me"),
          ),
          OutlinedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const PdfViewerDialog(
                  pdfPath: 'assets/resume.pdf',
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              side: const BorderSide(color: AppColors.primaryColor),
            ),
            child: const Text("Download CV"),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              side: const BorderSide(color: AppColors.primaryColor),
            ),
            child: const Text("View Projects"),
          ),
        ],
      ).animate().fadeIn(delay: 600.ms, duration: 500.ms).scale(),
      const SizedBox(height: 40),
      Row(
        children: [
          _socialIcon(FontAwesomeIcons.github),
          _socialIcon(FontAwesomeIcons.linkedin),
          _socialIcon(FontAwesomeIcons.twitter),
        ],
      ).animate().fadeIn(delay: 800.ms, duration: 500.ms),
    ];
  }

  Widget _socialIcon(dynamic icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: IconButton(
        icon: FaIcon(icon, size: 28),
        onPressed: () {},
        color: Colors.grey,
      ),
    );
  }

  Widget _buildProfileImage(bool isMobile) {
    final double size = isMobile ? 250 : 300;
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primaryColor, width: 3),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.15),
              blurRadius: 40,
              spreadRadius: 5,
            ),
          ],
        ),
        child: ClipOval(
          child: Image.network(
            "assets/images/me.png",
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.person, size: 100, color: Colors.grey);
            },
          ),
        ),
      ).animate().fadeIn(delay: 400.ms, duration: 800.ms).scale(begin: const Offset(0.8, 0.8)),
    );
  }
}
