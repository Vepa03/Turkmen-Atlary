import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteProvider with ChangeNotifier {
  Set<Map<String, String>> _favorites = {};

  Set<Map<String, String>> get favorites => _favorites;

  bool isFavorite(String name) {
    return _favorites.any((fav) => fav['name'] == name);
  }

  void toggleFavorite(String name, String gender) async {
    final exists = _favorites.any((fav) => fav['name'] == name);

    if (exists) {
      _favorites.removeWhere((fav) => fav['name'] == name);
    } else {
      _favorites.add({'name': name, 'gender': gender});
    }
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      'favorites',
      _favorites.map((e) => jsonEncode(e)).toList(),
    );
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('favorites');
    if (data != null) {
      _favorites = data.map((e) => Map<String, String>.from(jsonDecode(e))).toSet();
      notifyListeners();
    }
  }
}
