import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:story_app_api/api/api_service.dart';
import 'package:story_app_api/controller/auth_controller.dart';
import 'package:story_app_api/model/model.dart';
import 'package:story_app_api/utils/result_state.dart';

class StoriesProvider extends ChangeNotifier {
  final ApiService apiService;
  String query = '';

  StoriesProvider({required this.apiService}) {
    fetchAllData();
  }

  late StoriesResult _storiesResult;
  late ResultState _state;
  String _message = '';

  StoriesResult get result => _storiesResult;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> fetchAllData() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      
      String? userToken = await AuthController().getToken();

      // memvalidasi token
      if (userToken == null) {
        _state = ResultState.error;
        notifyListeners();
        return _message = 'Token not available';
      }

      // Menggunakan token untuk fetch data
      final stories = await apiService.fetchAllData(userToken);

      if (stories.listStory.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'empty data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _storiesResult = stories;
      }
    } catch (e) {
      log('$e');
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Terjadi Kesalahan';
    }
  }
}
