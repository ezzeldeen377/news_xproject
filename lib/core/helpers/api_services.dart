import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:news_xproject/core/constants/api_constants.dart';
@singleton
class ApiService {
  static final ApiService _instance = ApiService._internal();
  final String _baseUrl =ApiConstants.baseUrl;
  final http.Client _client = http.Client();
  
  ApiService._internal();
  
  factory ApiService() {
    return _instance;
  }
  
  String get _apiKey => dotenv.env['API_KEY'] ?? '';
  
  
  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParams}) async {
    final Map<String, dynamic> params = {
      'apiKey': _apiKey,
    };
    
    if (queryParams != null) {
      params.addAll(queryParams);
    }
    
    final Uri url = Uri.parse('$_baseUrl$endpoint').replace(queryParameters: params);
    
    try {
      final response = await _client.get(url);
      
      return _processResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
  
  
  Future<dynamic> post(String endpoint, {
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParams,
  }) async {
    final Map<String, dynamic> params = {
      'apiKey': _apiKey,
    };
    
    if (queryParams != null) {
      params.addAll(queryParams);
    }
    
    final Uri url = Uri.parse('$_baseUrl$endpoint').replace(queryParameters: params);
    
    try {
      final response = await _client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(body),
      );
      
      return _processResponse(response);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
  
  
  dynamic _processResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Request failed with status: ${response.statusCode}, ${response.body}');
    }
  }
  
  void dispose() {
    _client.close();
  }
}