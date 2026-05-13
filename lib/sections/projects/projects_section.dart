import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_constants.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> projects = [
      {
        "title": "Rental Car Application",
        "description": "A premium car rental platform featuring a sleek UI for browsing, booking, and managing luxury vehicle rentals.",
        "image": "assets/images/rental_car.png",
        "tech": "Flutter, Firebase, Cloud Firestore",
      },
      {
        "title": "Blood Donation App",
        "description": "A life-saving application connecting donors with recipients and blood banks in real-time with a clean, urgent-focused UI.",
        "image": "assets/images/blood_donation.png",
        "tech": "Flutter, Provider, Node.js",
      },
      {
        "title": "Pizza Delivery App",
        "description": "A vibrant and fast-paced food delivery app with intuitive menus, customization options, and live order tracking.",
        "image": "assets/images/pizza_delivery.png",
        "tech": "Flutter, Riverpod, Firebase",
      },
    ];

    final isMobile = MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100),
      color: AppColors.darkBg,
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 50),
          CarouselSlider(
            options: CarouselOptions(
              height: 450,
              aspectRatio: 16 / 9,
              viewportFraction: isMobile ? 0.8 : 0.4,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            items: projects.map((project) {
              return Builder(
                builder: (BuildContext context) {
                  return _projectCard(project, context);
                },
              );
            }).toList(),
          ),
        ],
      ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        const Text(
          "Featured Projects",
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

  Widget _projectCard(Map<String, String> project, BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Image.asset(
                project["image"]!,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project["title"]!,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        project["description"]!,
                        style: TextStyle(color: Colors.grey[400], fontSize: 14),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            project["tech"]!,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.accentColor,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.link),
                            onPressed: () {},
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
