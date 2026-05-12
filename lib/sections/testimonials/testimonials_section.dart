import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_constants.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> testimonials = [
      {
        "name": "John Doe",
        "role": "CEO, Tech Corp",
        "feedback": "Exceptional developer! Delivered the project ahead of schedule and the quality was top-notch.",
      },
      {
        "name": "Jane Smith",
        "role": "Product Manager",
        "feedback": "Great communication and problem-solving skills. The app exceeded our expectations.",
      },
      {
        "name": "Mike Johnson",
        "role": "Founder, Startup X",
        "feedback": "A pleasure to work with. Very knowledgeable about Flutter and UI design.",
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
      color: AppColors.darkCard,
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 50),
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: testimonials.map((t) => _testimonialCard(t)).toList(),
          ),
        ],
      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const Text(
          "What Clients Say",
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

  Widget _testimonialCard(Map<String, String> t) {
    return Container(
      width: 320,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: AppColors.darkBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.format_quote, color: AppColors.primaryColor, size: 40),
          const SizedBox(height: 10),
          Text(
            t["feedback"]!,
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey[300], height: 1.5),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t["name"]!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    t["role"]!,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
