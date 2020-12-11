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

  Future<bool> login(String email, String password) async {
    this.autenticando = true;

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
    this.autenticando = false;
    if(resp.statusCode == 200){
      final loginResponse = loginResponseFromJson( resp.body );
      this.usuario = loginResponse.usuario;
      //TODO: Guardar JWT.

      return true;
    } else {
      return false;
    }

  }
}