import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';


class BottomNav extends StatelessWidget {
  final PageController controller;

  const BottomNav({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      color: Colors.blue,
      notchMargin: 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(40)
        ),
        height: 63,
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
                size: 30.0,
              )),

            SizedBox(),
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
                size: 30.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
