import 'package:flutter/material.dart';

import 'core/widgets/main_wrapper.dart';
import 'locator.dart';

void main() async {
  await setup();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainWrapper(),
    ),
  );
}
