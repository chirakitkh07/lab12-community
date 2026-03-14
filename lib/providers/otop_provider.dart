import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/otop_product.dart';

class OtopProvider with ChangeNotifier {
  List<OtopProduct> _products = [];
  bool _isLoading = false;

  List<OtopProduct> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();

    _products = await DatabaseHelper.instance.getOtopProducts();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleFavorite(OtopProduct product) async {
    product.isFavorite = !product.isFavorite;
    await DatabaseHelper.instance.updateOtopProduct(product);
    notifyListeners();
  }
}
