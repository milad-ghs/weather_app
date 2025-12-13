import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppBackground {
  static AssetImage getBackGroundImage() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk').format(now);
    if (6 > int.parse(formattedDate)) {
      return AssetImage('assets/images/nightpic.jpg');
    } else if (18 > int.parse(formattedDate)) {
      return AssetImage('assets/images/pic_bg.jpg');
    } else {
      return AssetImage('assets/images/nightpic.jpg');
    }
  }

  static Image setIconForMain(description) {
    if (description == "clear sky") {
      return const Image(image: AssetImage('assets/images/icons8-sun-96.png'));
    } else if (description == "few clouds") {
      return Image(
        image: AssetImage('assets/images/icons8-partly-cloudy-day-80.png'),
      );
    } else if (description.contains("clouds")) {
      return Image(image: AssetImage('assets/images/icons8-clouds-80.png'));
    } else if (description.contains("thunderstorm")) {
      return Image(image: AssetImage('assets/images/icons8-storm-80.png'));
    } else if (description.contains("drizzle")) {
      return Image(image: AssetImage('assets/images/icons8-rain-cloud-80.png'));
    } else if (description.contains("rain")) {
      return Image(image: AssetImage('assets/images/icons8-heavy-rain-80.png'));
    } else if (description.contains("snow")) {
      return Image(image: AssetImage('assets/images/icons8-snow-80.png'));
    } else {
      return Image(
        image: AssetImage('assets/images/icons8-windy-weather-80.png'),
      );
    }
  }

  static Image setIconByWeatherCode(int code) {
    if (code == 0) {
      return const Image(
        image: AssetImage('assets/images/icons8-sun-96.png'),
      ); // Clear sky
    } else if (code == 1 || code == 2) {
      return const Image(
        image: AssetImage('assets/images/icons8-partly-cloudy-day-80.png'),
      ); // Mainly clear / partly cloudy
    } else if (code == 3) {
      return const Image(
        image: AssetImage('assets/images/icons8-clouds-80.png'),
      ); // Overcast
    } else if (code == 45 || code == 48) {
      return const Image(
        image: AssetImage('assets/images/icons8-fog-80.png'),
      ); // Fog
    } else if (code == 51 || code == 53 || code == 55) {
      return const Image(
        image: AssetImage('assets/images/icons8-rain-cloud-80.png'),
      ); // Drizzle
    } else if (code == 61 || code == 63 || code == 65) {
      return const Image(
        image: AssetImage('assets/images/icons8-heavy-rain-80.png'),
      ); // Rain
    } else if (code == 71 || code == 73 || code == 75) {
      return const Image(
        image: AssetImage('assets/images/icons8-snow-80.png'),
      ); // Snow fall
    } else if (code == 77) {
      return const Image(
        image: AssetImage('assets/images/icons8-snow-80.png'),
      ); // Snow grains
    } else if (code == 80 || code == 81 || code == 82) {
      return const Image(
        image: AssetImage('assets/images/icons8-heavy-rain-80.png'),
      ); // Rain showers
    } else if (code == 95 || code == 96 || code == 99) {
      return const Image(
        image: AssetImage('assets/images/icons8-storm-80.png'),
      ); // Thunderstorm
    }

    return const Image(
      image: AssetImage('assets/images/icons8-windy-weather-80.png'),
    ); // Default
  }
}
