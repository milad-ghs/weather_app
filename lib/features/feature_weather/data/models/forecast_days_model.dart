import '../../domain/entities/forecast_days_entity.dart';

/// Example: daily_units : {"time":"iso8601","temperature_2m_mean":"°C"}
/// daily : {"time":["2025-11-22","2025-11-23",...],"temperature_2m_mean":[12.3,13.4,...],"weathercode":[1,2,3,...]}

class ForecastDaysModel extends ForecastDaysEntity {
  ForecastDaysModel({
    num? latitude,
    num? longitude,
    num? generationtimeMs,
    num? utcOffsetSeconds,
    String? timezone,
    String? timezoneAbbreviation,
    num? elevation,
    DailyUnits? dailyUnits,
    Daily? daily,
  }) : super(
    latitude: latitude,
    longitude: longitude,
    generationtimeMs: generationtimeMs,
    utcOffsetSeconds: utcOffsetSeconds,
    timezone: timezone,
    timezoneAbbreviation: timezoneAbbreviation,
    elevation: elevation,
    dailyUnits: dailyUnits,
    daily: daily,
  );

  factory ForecastDaysModel.fromJson(dynamic json) {
    return ForecastDaysModel(
      latitude: json['latitude'],
      longitude: json['longitude'],
      generationtimeMs: json['generationtime_ms'],
      utcOffsetSeconds: json['utc_offset_seconds'],
      timezone: json['timezone'],
      timezoneAbbreviation: json['timezone_abbreviation'],
      elevation: json['elevation'],
      dailyUnits:
      json['daily_units'] != null ? DailyUnits.fromJson(json['daily_units']) : null,
      daily: json['daily'] != null ? Daily.fromJson(json['daily']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['generationtime_ms'] = generationtimeMs;
    map['utc_offset_seconds'] = utcOffsetSeconds;
    map['timezone'] = timezone;
    map['timezone_abbreviation'] = timezoneAbbreviation;
    map['elevation'] = elevation;
    if (dailyUnits != null) map['daily_units'] = dailyUnits!.toJson();
    if (daily != null) map['daily'] = daily!.toJson();
    return map;
  }
}

/// Daily contains arrays: time[], temperature_2m_mean[], weathercode[]
class Daily {
  Daily({
    this.time,
    this.temperature2mMean,
    this.weatherCode,
  });

  Daily.fromJson(dynamic json) {
    // time: List<String>
    time = json['time'] != null ? List<String>.from(json['time']) : <String>[];

    // temperature_2m_mean: List<num>
    temperature2mMean = json['temperature_2m_mean'] != null
        ? List<num>.from(json['temperature_2m_mean'])
        : <num>[];

    // weathercode: convert dynamic list safely to List<int>
    weatherCode = json['weathercode'] != null
        ? (json['weathercode'] as List).map((e) {
      if (e is num) return e.toInt();
      if (e is String) return int.tryParse(e) ?? 0;
      return 0;
    }).toList()
        : <int>[];
  }

  List<String>? time;
  List<num>? temperature2mMean;
  List<int>? weatherCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = time;
    map['temperature_2m_mean'] = temperature2mMean;
    map['weathercode'] = weatherCode;
    return map;
  }
}

/// daily_units : {"time":"iso8601","temperature_2m_mean":"°C"}
class DailyUnits {
  DailyUnits({
    this.time,
    this.temperature2mMean,
  });

  DailyUnits.fromJson(dynamic json) {
    time = json['time'];
    temperature2mMean = json['temperature_2m_mean'];
  }

  String? time;
  String? temperature2mMean;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = time;
    map['temperature_2m_mean'] = temperature2mMean;
    return map;
  }
}
