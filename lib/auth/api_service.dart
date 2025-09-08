import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:movies/models/movie_model.dart';
import 'package:movies/models/user_model.dart';
import 'package:movies/utilis.dart';

class AuthApiService {
  static const String baseUrl = 'https://route-movie-apis.vercel.app';
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String profileEndpoint = '/profile';
  static const String resetPasswordEndpoint = '/auth/reset-password';

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
      Utilis.showErrorMessage(e.toString());

      throw Exception('An unexpected error : $e');
    }
  }

  // Reset Password method
  static Future<Map<String, dynamic>> resetPassword({
    required String oldPassword,
    required String newPassword,
    required String token,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$resetPasswordEndpoint');

      final Map<String, dynamic> requestBody = {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      };

      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(requestBody),
      );

      log('Reset password response status: ${response.statusCode}');
      log('Reset password response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body.isNotEmpty) {
          final responseData = json.decode(response.body);
          return {
            'message': responseData['message'] ?? 'Password reset successfully',
            'success': true,
          };
        } else {
          return {'message': 'Password reset successfully', 'success': true};
        }
      } else {
        final errorMessage = _handleResetPasswordError(response);
        throw Exception(errorMessage);
      }
    } on FormatException catch (e) {
      log('JSON parsing error: $e');
      throw Exception('Server response format error. Please try again.');
    } on http.ClientException catch (e) {
      log('Network error: $e');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      log('Error during password reset: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  static String _handleResetPasswordError(http.Response response) {
    if (response.body.isNotEmpty) {
      try {
        final responseData = json.decode(response.body);
        return responseData['message'] ?? 'Failed to reset password';
      } catch (e) {
        log('Error parsing error response: $e');
      }
    }

    switch (response.statusCode) {
      case 400:
        return 'Invalid request data. Please check your input.';
      case 401:
        return 'Unauthorized. Your current password is incorrect.';
      case 403:
        return 'Forbidden. Invalid or expired token.';
      case 404:
        return 'Reset password endpoint not found.';
      default:
        return 'Failed to reset password. Please try again.';
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
      final loginResult = await login(email: email, password: password);

      if (loginResult != null && loginResult['success'] == true) {
        final String token = loginResult['token']!;

        final UserModel? user = await getUserProfile(token);

        if (user != null) {
          user.token = token;
          return user;
        }
      }

      return null;
    } catch (e) {
      rethrow;
    }
  }

  // update user profile method
  static Future<Map<String, dynamic>> updateProfile({
    required UserModel updatedUser,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$profileEndpoint');

      final String? token = updatedUser.token;
      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      final Map<String, dynamic> requestBody = updatedUser.toJson();

      log('Update profile request: ${jsonEncode(requestBody)}');

      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(requestBody),
      );

      log('Update profile response status: ${response.statusCode}');
      log('Update profile response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return {
          'message': responseData['message'] ?? 'Profile updated successfully',
          'success': true,
        };
      } else {
        final errorMessage = _handleUpdateProfileError(response);
        throw Exception(errorMessage);
      }
    } on FormatException catch (e) {
      log('JSON parsing error: $e');
      throw Exception('Server response format error. Please try again.');
    } on http.ClientException catch (e) {
      log('Network error: $e');
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      log('Error during profile update: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  static String _handleUpdateProfileError(http.Response response) {
    if (response.body.isNotEmpty) {
      try {
        final responseData = json.decode(response.body);
        return responseData['message'] ?? 'Failed to update profile';
      } catch (e) {
        log('Error parsing error response: $e');
      }
    }

    switch (response.statusCode) {
      case 400:
        return 'Invalid request data. Please check your input.';
      case 401:
        return 'Unauthorized. Please login again.';
      case 403:
        return 'Forbidden. Invalid or expired token.';
      case 404:
        return 'Profile endpoint not found.';
      case 409:
        return 'Email already exists. Please use a different email.';
      default:
        return 'Failed to update profile. Please try again.';
    }
  }
}

class MovieService {
  static const String baseUrl = "https://yts.mx/api/v2/";

  static Future<List<MovieModel>> fetchMovies({int page = 1}) async {
    try {
      final url = Uri.parse(
        "${baseUrl}list_movies.json?limit=15&page=$page&sort_by=rating",
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data == null ||
            data["data"] == null ||
            data["data"]["movies"] == null) {
          return [];
        }

        final movies = data["data"]["movies"] as List<dynamic>;
        return movies
            .map((movieJson) => MovieModel.fromJson(movieJson))
            .toList();
      } else {
        throw HttpException(
          "Failed to fetch movies: Status ${response.statusCode}",
          uri: url,
        );
      }
    } on SocketException {
      throw Exception("No Internet connection. Please check your network.");
    } on FormatException {
      throw Exception("Invalid response format from server.");
    } catch (e) {
      throw Exception("Unexpected error while fetching movies: $e");
    }
  }

  static Future<List<MovieModel>> fetchMovieSuggestions(int movieId) async {
    try {
      final url = Uri.parse(
        "${baseUrl}movie_suggestions.json?movie_id=$movieId",
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data == null ||
            data["data"] == null ||
            data["data"]["movies"] == null) {
          return [];
        }

        final movies = data["data"]["movies"] as List<dynamic>;
        return movies
            .map((movieJson) => MovieModel.fromJson(movieJson))
            .toList();
      } else {
        throw Exception("Failed to fetch suggestions");
      }
    } catch (e) {
      throw Exception("Error fetching suggestions: $e");
    }
  }
}
