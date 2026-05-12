import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_constants.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> services = [
      {
        "title": "Flutter App Development",
        "icon": Icons.phone_android,
        "desc": "Building high-performance, beautiful mobile applications for Android and iOS.",
      },
      {
        "title": "Firebase Integration",
        "icon": Icons.cloud,
        "desc": "Seamlessly connecting your apps with robust backend services and real-time databases.",
      },
      {
        "title": "State Management",
        "icon": Icons.layers,
        "desc": "Implementing scalable state management solutions using Riverpod, BLoC, or Provider.",
      },
      {
        "title": "API Integration",
        "icon": Icons.api,
        "desc": "Connecting apps with third-party services and custom RESTful APIs.",
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
      color: AppColors.darkBg,
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 50),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: services.map((s) => _serviceCard(s)).toList(),
          ),
        ],
      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const Text(
          "My Services",
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

  Widget _serviceCard(Map<String, dynamic> service) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(service["icon"], color: AppColors.primaryColor, size: 40),
          ),
          const SizedBox(height: 20),
          Text(
            service["title"],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Text(
            service["desc"],
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[400], fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }
}
