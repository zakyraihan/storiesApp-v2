import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:story_app_api/model/model.dart';

class ApiService {
  final String token;

  ApiService(this.token);

  static const String _baseUrl = "https://story-api.dicoding.dev/v1/";

  Future<StoriesResult> fetchAllData(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/stories'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        log(response.body);
        return StoriesResult.fromJson(json.decode(response.body.toString()));
      } else {
        throw Exception('Failed To Fetch Restaurant Data');
      }
    } catch (e) {
      log('Error -> $e');
      throw Exception('Failed To Fetch Restaurant Data');
    }
  }

  Future addStory() async {}
}
