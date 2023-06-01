import 'package:flutter/material.dart';

class FavoriteBreedsProvider extends ChangeNotifier {
  List<String> _breeds = [];
  List<String> get breeds => _breeds;

  void toggleFavorite(String breeds) {
    bool isFavorite = _breeds.contains(breeds);
    if (isFavorite) {
      _breeds.remove(breeds);
    } else {
      _breeds.add(breeds);
    }
    notifyListeners();
  }

  bool isFavorite(String breeds) {
    return _breeds.contains(breeds);
  }

  void clearFavorite() {
    _breeds = [];
    notifyListeners();
  }
}
