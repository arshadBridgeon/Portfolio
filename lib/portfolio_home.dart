import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'widgets/navbar/custom_navbar.dart';
import 'sections/hero/hero_section.dart';
import 'sections/about/about_section.dart';
import 'sections/skills/skills_section.dart';
import 'sections/projects/projects_section.dart';
import 'sections/experience/experience_section.dart';
import 'sections/contact/contact_section.dart';
import 'sections/footer/footer_section.dart';

import 'sections/services/services_section.dart';
import 'core/constants/app_constants.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final ItemScrollController _itemScrollController = ItemScrollController();
  final ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();

  final List<Widget> _sections = [
    const HeroSection(),
    const AboutSection(),
    const SkillsSection(),
    const ServicesSection(),
    const ProjectsSection(),
    const ExperienceSection(),
    const ContactSection(),
    const FooterSection(),
  ];

  void _scrollTo(int index) {
    _itemScrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _itemPositionsListener.itemPositions.addListener(() {
      final positions = _itemPositionsListener.itemPositions.value;
      if (positions.isNotEmpty) {
        // Find the item that is most prominent on screen
        final index = positions
            .where((p) => p.itemTrailingEdge > 0)
            .reduce((min, p) => p.itemLeadingEdge < min.itemLeadingEdge ? p : min)
            .index;
        
        if (_selectedIndex != index) {
          setState(() {
            _selectedIndex = index;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: _buildEndDrawer(),
      body: Stack(
        children: [
          ScrollablePositionedList.builder(
            itemCount: _sections.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => _sections[index],
            itemScrollController: _itemScrollController,
            itemPositionsListener: _itemPositionsListener,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomNavbar(
              onNavItemTap: _scrollTo,
              selectedIndex: _selectedIndex,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEndDrawer() {
    final List<Map<String, dynamic>> menuItems = [
      {"title": "Home", "index": 0, "icon": Icons.home_rounded},
      {"title": "About", "index": 1, "icon": Icons.person_rounded},
      {"title": "Skills", "index": 2, "icon": Icons.psychology_rounded},
      {"title": "Services", "index": 3, "icon": Icons.design_services_rounded},
      {"title": "Projects", "index": 4, "icon": Icons.work_rounded},
      {"title": "Experience", "index": 5, "icon": Icons.history_rounded},
      {"title": "Contact", "index": 6, "icon": Icons.email_rounded},
    ];

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.darkBg.withOpacity(0.95),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          ),
          border: Border.all(
            color: AppColors.primaryColor.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Header/Logo in Drawer
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 4,
                          width: 40,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Navigation",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded, color: Colors.white70),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.2, end: 0),
              const SizedBox(height: 40),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    final bool isSelected = _selectedIndex == item["index"];
                    
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          _scrollTo(item["index"]);
                        },
                        borderRadius: BorderRadius.circular(15),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? AppColors.primaryColor.withOpacity(0.1) 
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: isSelected 
                                  ? AppColors.primaryColor.withOpacity(0.3) 
                                  : Colors.transparent,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                item["icon"],
                                color: isSelected 
                                    ? AppColors.primaryColor 
                                    : Colors.white.withOpacity(0.7),
                                size: 22,
                              ),
                              const SizedBox(width: 16),
                              Text(
                                item["title"],
                                style: TextStyle(
                                  color: isSelected ? AppColors.primaryColor : Colors.white,
                                  fontSize: 18,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              if (isSelected)
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: AppColors.primaryColor,
                                  size: 14,
                                ).animate().fadeIn().scale(),
                            ],
                          ),
                        ),
                      ).animate()
                        .fadeIn(delay: (index * 50).ms, duration: 400.ms)
                        .slideX(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Divider(color: Colors.white.withOpacity(0.1)),
                    const SizedBox(height: 16),
                    Text(
                      "© ${DateTime.now().year} ${AppConstants.name}",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.4), 
                        fontSize: 10,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 600.ms),
            ],
          ),
        ),
      ),
    );
  }
}
