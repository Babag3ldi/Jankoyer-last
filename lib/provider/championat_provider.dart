import 'package:flutter/material.dart';

import '../model/championat_model.dart';
import '../service/news_service.dart';

class ChampionatProvider extends ChangeNotifier {
  final _service = NewsService();
  bool isLoading3 = false;
  List<ChampionatModel> _championat = [];
  List<ChampionatModel> get championat => _championat;

  Future<void> championatGetAll() async {
    isLoading3 = true;
    notifyListeners();

    final response = await _service.championatGet();

    _championat = response;
    isLoading3 = false;
    notifyListeners(

    );
  }
}
