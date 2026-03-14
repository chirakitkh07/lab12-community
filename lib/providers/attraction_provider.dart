import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/attraction.dart';

class AttractionProvider with ChangeNotifier {
  List<Attraction> _attractions = [];
  bool _isLoading = false;

  List<Attraction> get attractions => _attractions;
  bool get isLoading => _isLoading;

  Future<void> loadAttractions() async {
    _isLoading = true;
    notifyListeners();

    _attractions = await DatabaseHelper.instance.getAttractions();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleFavorite(Attraction attraction) async {
    attraction.isFavorite = !attraction.isFavorite;
    await DatabaseHelper.instance.updateAttraction(attraction);
    notifyListeners();
  }
}
