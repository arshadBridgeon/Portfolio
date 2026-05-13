import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../dialogs/pdf_viewer_dialog.dart';

class CustomNavbar extends ConsumerWidget {
  final Function(int) onNavItemTap;
  final int selectedIndex;

  const CustomNavbar({
    super.key,
    required this.onNavItemTap,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMobile =
        MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.darkBg.withOpacity(0.3),
            border: Border(
              bottom: BorderSide(
                color: AppColors.primaryColor.withOpacity(0.1),
              ),
            ),
          ),
          child: Row(
            children: [
              const Spacer(),
              if (!isMobile) ...[
                _navItem("Home", 0),
                _navItem("About", 1),
                _navItem("Skills", 2),
                _navItem("Services", 3),
                _navItem("Projects", 4),
                _navItem("Experience", 5),
                _navItem("Contact", 6),
                const SizedBox(width: 20),
                _resumeButton(context),
              ] else
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _resumeButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) =>
              const PdfViewerDialog(pdfPath: 'assets/resume.pdf'),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: const Text(
        "Resume",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ).animate().fadeIn(delay: 500.ms).slideX(begin: 0.5);
  }

  Widget _navItem(String title, int index) {
    final isSelected = selectedIndex == index;

    return _AnimatedNavItem(
      title: title,
      isSelected: isSelected,
      onTap: () => onNavItemTap(index),
    );
  }
}

class _AnimatedNavItem extends StatefulWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _AnimatedNavItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_AnimatedNavItem> createState() => _AnimatedNavItemState();
}

class _AnimatedNavItemState extends State<_AnimatedNavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (value) {
        setState(() {
          _isHovered = value;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 16,
                fontWeight: widget.isSelected
                    ? FontWeight.bold
                    : FontWeight.w500,
                color: (widget.isSelected || _isHovered)
                    ? AppColors.primaryColor
                    : Colors.white70,
              ),
              child: Text(widget.title),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 2,
              width: widget.isSelected ? 20 : (_isHovered ? 12 : 0),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(2),
                boxShadow: (widget.isSelected || _isHovered)
                    ? [
                        BoxShadow(
                          color: AppColors.primaryColor.withOpacity(0.5),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ]
                    : [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
