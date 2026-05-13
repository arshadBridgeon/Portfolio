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
      {"title": "Home", "index": 0},
      {"title": "About", "index": 1},
      {"title": "Skills", "index": 2},
      {"title": "Services", "index": 3},
      {"title": "Projects", "index": 4},
      {"title": "Experience", "index": 5},
      {"title": "Contact", "index": 6},
    ];

    return Drawer(
      backgroundColor: AppColors.darkBg,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 50),
            ...menuItems.map((item) {
              final bool isSelected = _selectedIndex == item["index"];
              return ListTile(
                title: Text(
                  item["title"],
                  style: TextStyle(
                    color: isSelected ? AppColors.primaryColor : Colors.white,
                    fontSize: 18,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _scrollTo(item["index"]);
                },
                trailing: isSelected
                    ? const Icon(Icons.chevron_right, color: AppColors.primaryColor)
                    : null,
              );
            }).toList(),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                "© ${DateTime.now().year} ${AppConstants.name}",
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
