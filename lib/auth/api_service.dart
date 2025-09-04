import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:movies/models/user_model.dart';

class AuthApiService {
  static const String baseUrl = 'https://route-movie-apis.vercel.app';
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String profileEndpoint = '/profile';

  // Login method
  static Future<Map<String, dynamic>?> login({
    required String email,
    required String password,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$loginEndpoint');

      final Map<String, dynamic> requestBody = {
        "email": email.trim(),
        "password": password,
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(requestBody),
      );

      log('Login response status: ${response.statusCode}');
      log('Login response body: ${response.body}');

      if (response.body.isEmpty) {
        throw Exception('Server returned empty response');
      }

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final String? token = responseData['data'] as String?;
        final String? message = responseData['message'] as String?;

        if (token == null || token.isEmpty) {
          throw Exception('No token received');
        }

        return {'token': token, 'message': message, 'success': true};
      } else {
        final errorMessage =
            responseData['message'] ??
            'Login failed. Please check your credentials.';
        throw Exception(errorMessage);
      }
    } on FormatException catch (e) {
      log('JSON parsing error: $e');
      throw Exception('Server response format error. Please try again.');
    } on http.ClientException catch (e) {
      log('Network error: $e');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      log('Error during login: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Register method
  static Future<Map<String, dynamic>?> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required int avatarId,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$registerEndpoint');

      final Map<String, dynamic> requestBody = {
        "name": name,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
        "phone": phone,
        "avaterId": avatarId,
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(requestBody),
      );

      log('Register response status: ${response.statusCode}');
      log('Register response body: ${response.body}');

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'data': responseData['data'],
          'message': responseData['message'],
          'success': true,
        };
      } else {
        final errorMessage = responseData['message'] ?? 'Registration failed';
        throw Exception(errorMessage);
      }
    } on FormatException catch (e) {
      log('JSON parsing error: $e');
      throw Exception('Server response format error. Please try again.');
    } on http.ClientException catch (e) {
      log('Network error: $e');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      log('Error during registration: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Get user profile method
  static Future<UserModel?> getUserProfile(String token) async {
    try {
      final url = Uri.parse('$baseUrl$profileEndpoint');

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      log('User profile response status: ${response.statusCode}');
      log('User profile response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['data'] != null) {
          final user = UserModel.fromJson(responseData['data']);
          log('User profile loaded: ${user.name}');
          return user;
        } else {
          log('Profile response has no data');
          throw Exception('No user data received');
        }
      } else {
        final errorMessage = 'Failed to fetch profile: ${response.statusCode}';
        log(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (error, st) {
      log('Error fetching profile: $error\n$st');
      throw Exception('Failed to load user profile');
    }
  }

  // Complete login flow (login + get profile)
  static Future<UserModel?> completeLogin({
    required String email,
    required String password,
  }) async {
    try {
      // Step 1: Login to get token
      final loginResult = await login(email: email, password: password);

      if (loginResult != null && loginResult['success'] == true) {
        final String token = loginResult['token']!;

        // Step 2: Get user profile with the token
        final UserModel? user = await getUserProfile(token);

        if (user != null) {
          user.token = token; // Store token in user object
          return user;
        }
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }
}
