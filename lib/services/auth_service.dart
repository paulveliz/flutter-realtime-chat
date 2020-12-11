import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:real_time_chat/global/environment.dart';
import 'package:real_time_chat/models/login_response.dart';
import 'package:real_time_chat/models/usuario.dart';

class AuthService with ChangeNotifier {

  Usuario usuario;
  bool _autenticando = false;
  final _storage = new FlutterSecureStorage();


  // Getters del token de forma estatica
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token; // ?? null.
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

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
      await this._guardarToken(loginResponse.token);

      return true;
    } else {
      return false;
    }

  }
  Future register(String nombre, String email, String password) async {
    this.autenticando = true;
    final data = {
      'nombre': nombre,
      'email': email,
      'password': password
    };

    final response = await http.post('${Environment.apiUrl}/login/new',
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    this.autenticando = false;

    if(response.statusCode == 200){
      final registerResponse = loginResponseFromJson( response.body );
      this.usuario = registerResponse.usuario;
      await this._guardarToken(registerResponse.token);
      return true;
    }else{
      final respBody = jsonDecode(response.body);
      return respBody['msg'];
    }
  }


  Future _guardarToken( String token ) async {
    await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}