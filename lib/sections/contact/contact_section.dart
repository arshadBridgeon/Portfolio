import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < AppConstants.mobileBreakpoint;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 60 : 100,
        horizontal: isMobile ? 24 : 50,
      ),
      color: AppColors.darkBg,
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 50),
          isMobile
              ? Column(
                  children: [
                    _buildContactInfo(isMobile),
                    const SizedBox(height: 50),
                    _buildContactForm(),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildContactInfo(isMobile)),
                    const SizedBox(width: 50),
                    Expanded(child: _buildContactForm()),
                  ],
                ),
        ],
      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const Text(
          "Get In Touch",
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

  Widget _buildContactInfo(bool isMobile) {
    return Column(
      crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          "Let's work together!",
          style: TextStyle(fontSize: isMobile ? 18 : 24, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 15),
        Text(
          "I'm always open to new opportunities and interesting projects. Feel free to reach out to me via email or through the contact form.",
          style: TextStyle(fontSize: isMobile ? 14 : 16, color: Colors.grey[400], height: 1.5),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ),
        const SizedBox(height: 30),
        _contactItem(
          Icons.email,
          "muhammedmcarshad@gmail.com",
          () => _launchURL("mailto:muhammedmcarshad@gmail.com"),
          isMobile,
        ),
        _contactItem(
          Icons.phone,
          "+91 8089018330",
          () => _launchURL("tel:+918089018330"),
          isMobile,
        ),
        _contactItem(
          Icons.location_on,
          "Kerala, Malappuram",
          null,
          isMobile,
        ),
      ],
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _contactItem(IconData icon, String text, VoidCallback? onTap, bool isMobile) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.primaryColor, size: 20),
              ),
              const SizedBox(width: 15),
              Flexible(
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactForm() {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          _textField("Name", "Enter your name"),
          const SizedBox(height: 20),
          _textField("Email", "Enter your email"),
          const SizedBox(height: 20),
          _textField("Message", "Enter your message", maxLines: 5),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Send Message"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textField(String label, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: AppColors.darkBg,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }
}
