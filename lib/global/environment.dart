import 'dart:io';

class Environment {
  static String apiUrl = Platform.isAndroid ? 'http://192.168.0.5:4000/api' : 'http://192.168.0.5:4000/api';
  static String socketUrl = Platform.isAndroid ? 'http://192.168.0.5:4000' : 'http://192.168.0.5:4000';
}