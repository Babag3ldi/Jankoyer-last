import 'package:flutter/material.dart';

import '../model/interviews_model.dart';
import '../service/news_service.dart';

class InterviewsProvider extends ChangeNotifier {
  final _service = NewsService();
  bool isLoading = false;
  List<InterviewsModelConversation> _interviews = [];
  List<InterviewsModelConversation> get interviews => _interviews;

  Future<void> interviewsGetAll() async {
    isLoading = true;
    notifyListeners();

    final response = await _service.interviewsGet();

    _interviews = response;
    isLoading = false;
    notifyListeners();
  }
}
