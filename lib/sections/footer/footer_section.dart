import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
      color: AppColors.darkBg,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "© ${DateTime.now().year} ${AppConstants.name}. All rights reserved.",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _footerLink("GitHub"),
              const SizedBox(width: 20),
              _footerLink("LinkedIn"),
              const SizedBox(width: 20),
              _footerLink("Twitter"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _footerLink(String text) {
    return InkWell(
      onTap: () {},
      child: Text(
        text,
        style: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w500),
      ),
    );
  }
}
