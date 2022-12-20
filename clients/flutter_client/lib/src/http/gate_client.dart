import 'dart:convert';

import 'package:flutter_client/src/http/dtos/response/access_response_dto.dart';
import 'package:flutter_client/src/http/dtos/response/login_response_dto.dart';
import 'package:flutter_client/src/http/dtos/response/user_nodes_response_dto.dart';
import 'package:flutter_client/src/http/server_properties.dart';
import 'package:flutter_client/src/services/prefs_service.dart';
import 'package:http/http.dart' as http;

class GateClient {
  static final GateClient _instance = GateClient._internal();

  factory GateClient() {
    return _instance;
  }

  GateClient._internal();

  Future<AccessResponseDto?> requestAccess(
      String host, String token, String deviceId) async {
    final url = Uri.https(host, '/gates/activate/$deviceId');
    final res =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    if (res.statusCode != 200) {
      return null;
    }

    final json = jsonDecode(res.body) as Map<String, dynamic>;
    AccessResponseDto? accessResponse;
    try {
      accessResponse = AccessResponseDto.fromJson(json);
      return accessResponse;
    } catch (e) {
      accessResponse = null;
    }

    return accessResponse;
  }

  Future<LoginResponseDto?> login(
      String host, String username, String password) async {
    final url = Uri.https(host, '/auth');
    final res = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
        }));

    final json = jsonDecode(res.body) as Map<String, dynamic>;
    LoginResponseDto? loginResponse;
    try {
      loginResponse = LoginResponseDto.fromJson(json);
    } catch (e) {
      loginResponse = null;
    }

    return loginResponse;
  }

  Future<UserNodesResponseDto?> fetchUserNodes(
      String host, String token) async {
    final url = Uri.https(host, '/nodes-client/user', {'device_only': 'true'});
    final res =
        await http.get(url, headers: {'Authorization': 'Bearer $token'});

    final json = jsonDecode(res.body) as Map<String, dynamic>;
    UserNodesResponseDto? userNodes;
    try {
      userNodes = UserNodesResponseDto.fromJson(json);
    } catch (e) {
      userNodes = null;
    }

    return userNodes;
  }
}
