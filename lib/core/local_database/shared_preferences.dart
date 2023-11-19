import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:star_wars/feature/home/domain/entities/people_model.dart';

class StarWarsLocalDatabase {
  Future<SharedPreferences> _getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future<bool> setPeopleData(List<PeopleModel> data) async {
    final prefs = await _getSharedPreferences();
    final encodedData = data.map((person) => person.toJson()).toList();
    return prefs.setStringList(
        'peopleData', encodedData.map((e) => json.encode(e)).toList());
  }

  Future<List<PeopleModel>> getPeopleData() async {
    final prefs = await _getSharedPreferences();
    final encodedData = prefs.getStringList('peopleData');
    if (encodedData != null) {
      return encodedData
          .map((e) => PeopleModel.fromJson(json.decode(e)))
          .toList();
    } else {
      return [];
    }
  }
}
