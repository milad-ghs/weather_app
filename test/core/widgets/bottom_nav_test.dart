import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:weather_app_new/core/widgets/bottom_nav.dart';

void main() {
  testWidgets(
    'click IconBottom in bottom nav should moving  to page 0 in pageView',
    (tester) async {
      PageController pageController = PageController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: BottomNav(controller: pageController),
            body: PageView(
              controller: pageController,
              children: [Container(), Container()],
            ),
          ),
        ),
      );

      await tester.tap(
        find.widgetWithIcon(
          IconButton,
          PhosphorIcons.houseLine(PhosphorIconsStyle.regular),
        ),
      );

      await tester.pumpAndSettle();
      expect(pageController.page, 0);
    },
  );
}
