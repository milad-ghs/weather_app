import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:weather_app_new/features/feature_bookmark/domain/entities/bookmarked_city_entity.dart';

class SecureStorageDataSource {

  final FlutterSecureStorage _storage ;
  SecureStorageDataSource(this._storage);

  static final  String _key = 'bookmarked_cities';

  Future<List<BookmarkedCity>> getCities()async{

    final jsonString = await _storage.read(key: _key);
    if(jsonString == null ){
      return [];
    }else{
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => BookmarkedCity.fromJson(json)).toList();
    }

  }

  Future<void> saveCities(List<BookmarkedCity> cities) async{

    final jsonList = cities.map((city)=> city.toJson()).toList();
    final jsonString = json.encode(jsonList);
    await _storage.write(key: _key, value: jsonString);
  }

}