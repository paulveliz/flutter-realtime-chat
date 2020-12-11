import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:real_time_chat/global/environment.dart';
import 'package:real_time_chat/models/login_response.dart';
import 'package:real_time_chat/models/usuario.dart';

class AuthService with ChangeNotifier {

  Usuario usuario;
  bool _autenticando = false;

  bool get autenticando => this._autenticando;

  set autenticando(bool valor){
    this._autenticando = valor;
    notifyListeners();
  }

  Future login(String email, String password) async {
    this._autenticando = true;

    final data = {
      'email': email,
      'password': password
    };

    final resp = await http.post('${Environment.apiUrl}/login',
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );
    if(resp.statusCode == 200){
      final loginResponse = loginResponseFromJson( resp.body );
      this.usuario = loginResponse.usuario;
    }

    this._autenticando = false;
  }
}