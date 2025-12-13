import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class GlassBottomNav extends StatelessWidget {
  final PageController controller;

  const GlassBottomNav({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 15,
      right: 15,
      bottom: 15, // چسباندن به پایین صفحه
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30), // افکت بلور
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.2),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.015),
                  spreadRadius: 5,
                  blurRadius: 15,
                ),
              ],
              borderRadius: BorderRadius.circular(25),
              color: Colors.transparent,  // شفاف بودن پس‌زمینه
              border: Border.all(
                color: Colors.white.withOpacity(0.2), // مرز شفاف با رنگ سفید
                width: 1.2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    controller.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: Icon(
                    PhosphorIcons.houseLine(PhosphorIconsStyle.regular),
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    controller.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: Icon(
                    PhosphorIcons.bookmarkSimple(PhosphorIconsStyle.regular),
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
