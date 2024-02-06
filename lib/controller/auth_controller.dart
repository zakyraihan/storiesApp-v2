import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app_api/model/model.dart';

class AuthController {
  static const String _baseUrl = 'https://story-api.dicoding.dev/v1/';

  Future registerProses(String nama, String email, String password) async {
    try {
      String url = '$_baseUrl/register';
      Uri dataUrl = Uri.parse(url);

      Map data = {
        'name': nama,
        'email': email,
        'password': password,
      };

      var body = json.encode(data);

      final response = await http.post(dataUrl,
          headers: {"Content-Type": "application/json"}, body: body);
      if (response.statusCode == 201) {
        log(response.body);
        Register dataRegister = registerFromJson(response.body.toString());
        return dataRegister;
      } else {
        log('Error -> ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error -> $e');
      return null;
    }
  }

  Future loginProses(String email, String password) async {
    try {
      const url = '$_baseUrl/login';
      Uri dataUrl = Uri.parse(url);

      Map data = {
        'email': email,
        "password": password,
      };

      var body = json.encode(data);

      final response = await http.post(dataUrl,
          headers: {"Content-Type": "application/json"}, body: body);

      if (response.statusCode == 200) {
        log(response.body);
        Login loginProses = loginFromJson(response.body.toString());

        String token = loginProses.loginResult.token;
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('token', token);
        preferences.setString('name', loginProses.loginResult.name);

        return token;
      }
    } catch (e) {
      log('Error -> $e');
    }
  }

  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    return token;
  }

  Future<bool> isAuthenticated() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    String? name = preferences.getString('name');
    log('token -> $token');
    return token != null && name != null;
  }

  Future logOut(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('name');

    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
