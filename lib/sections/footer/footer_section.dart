import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_constants.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 30 : 50,
        horizontal: isMobile ? 24 : 50,
      ),
      color: AppColors.darkBg,
      child: Column(
        children: [
          Text(
            "© ${DateTime.now().year} ${AppConstants.name}. All rights reserved.",
            style: const TextStyle(color: Colors.grey, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            runSpacing: 10,
            children: [
              _footerLink("GitHub", "https://github.com/arshadBridgeon"),
              _footerLink("LinkedIn", "https://www.linkedin.com/in/muhammed-arshad-mc-3913b034a/"),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _footerLink(String text, String url) {
    return InkWell(
      onTap: () => _launchURL(url),
      child: Text(
        text,
        style: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w500),
      ),
    );
  }
}
