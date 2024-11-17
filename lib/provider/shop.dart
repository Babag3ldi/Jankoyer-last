import 'package:flutter/material.dart';

import '../model/shop_model.dart';
import '../service/news_service.dart';


class ShopProvider extends ChangeNotifier {
  final _service = NewsService();
  bool isLoading = false;
  List<ShopModel> _shop = [];
  List<ShopModel> get shop => _shop;

  Future<void> shopGetAll() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.shopGet();

    _shop = response;
    isLoading = false;
    notifyListeners();
  }
}
