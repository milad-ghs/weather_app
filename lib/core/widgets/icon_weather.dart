enum WeatherType {
  clearSky,          // 0
  partlyCloudy,      // 1,2,3
  fog,               // 45,48
  drizzle,           // 51,53,55
  freezingDrizzle,   // 56,57
  rain,              // 61,63,65
  freezingRain,      // 66,67
  snowFall,          // 71,73,75
  snowGrains,        // 77
  rainShowers,       // 80,81,82
  snowShowers,       // 85,86
  thunderstorm,      // 95
  thunderstormHail,  // 96,99
  unknown            // برای موارد پیش‌بینی نشده
}

extension WeatherTypeExtension on WeatherType {
  /// برگرداندن کدهای مرتبط با هر نوع
  List<int> get codes {
    switch (this) {
      case WeatherType.clearSky:
        return [0];
      case WeatherType.partlyCloudy:
        return [1,2,3];
      case WeatherType.fog:
        return [45,48];
      case WeatherType.drizzle:
        return [51,53,55];
      case WeatherType.freezingDrizzle:
        return [56,57];
      case WeatherType.rain:
        return [61,63,65];
      case WeatherType.freezingRain:
        return [66,67];
      case WeatherType.snowFall:
        return [71,73,75];
      case WeatherType.snowGrains:
        return [77];
      case WeatherType.rainShowers:
        return [80,81,82];
      case WeatherType.snowShowers:
        return [85,86];
      case WeatherType.thunderstorm:
        return [95];
      case WeatherType.thunderstormHail:
        return [96,99];
      case WeatherType.unknown:
        return [];
    }
  }

  /// برگرداندن WeatherType بر اساس کد عددی
  static WeatherType fromCode(int code) {
    for (var type in WeatherType.values) {
      if (type.codes.contains(code)) {
        return type;
      }
    }
    return WeatherType.unknown;
  }
}
