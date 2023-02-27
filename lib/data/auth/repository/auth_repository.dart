import 'package:client/data/auth/models/errors/error.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/constants.dart';
import '../../user/models/user.dart';

class AuthRepository {
  final dio = Dio(
    BaseOptions(
      contentType: 'application/json',
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );
  Future<User> login({required String email, required String password}) async {
    try {
      const storage = FlutterSecureStorage();
      final res = await dio.post(
        '/auth/login',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            if (status != null) {
              return true;
            } else {
              return false;
            }
          },
        ),
        data: {
          'email': email,
          'password': password,
        },
      );
      if (res.statusCode == 201) {
        final String accessToken = res.data['accessToken'];
        final String refreshToken = res.data['refreshToken'];
        await storage.write(key: 'accessToken', value: accessToken);
        await storage.write(key: 'refreshToken', value: refreshToken);
        final User user = User.fromJson(res.data['user']);
        return user;
      } else {
        final ErrorModel error = ErrorModel.fromJson(res.data);
        throw Exception(error.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<User> registration(
      {required String username,
      required String email,
      required String password}) async {
    try {
      const storage = FlutterSecureStorage();
      final res = await dio.post(
        '/auth/register',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            if (status != null) {
              return true;
            } else {
              return false;
            }
          },
        ),
        data: {
          'username': username,
          'email': email,
          'password': password,
        },
      );
      if (res.statusCode == 201) {
        final String accessToken = res.data['accessToken'];
        final String refreshToken = res.data['refreshToken'];
        await storage.write(key: 'accessToken', value: accessToken);
        await storage.write(key: 'refreshToken', value: refreshToken);
        final User user = User.fromJson(res.data['user']);
        return user;
      } else {
        final ErrorModel error = ErrorModel.fromJson(res.data);
        throw Exception(error.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<User> refresh() async {
    try {
      const FlutterSecureStorage storage = FlutterSecureStorage();
      final String? sendRefreshToken = await storage.read(key: 'refreshToken');
      final res = await dio.post(
        '/auth/refresh',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            if (status != null) {
              return true;
            } else {
              return false;
            }
          },
        ),
        data: {
          'refreshToken': sendRefreshToken,
        },
      );
      if (res.statusCode == 201) {
        final String accessToken = res.data['accessToken'];
        final String refreshToken = res.data['refreshToken'];
        await storage.write(key: 'accessToken', value: accessToken);
        await storage.write(key: 'refreshToken', value: refreshToken);
        final User user = User.fromJson(res.data['user']);
        return user;
      } else {
        final ErrorModel error = ErrorModel.fromJson(res.data);
        throw Exception(error.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      const FlutterSecureStorage storage = FlutterSecureStorage();
      final String? sendRefreshToken = await storage.read(key: 'refreshToken');
      final res = await dio.post(
        '/auth/logout',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            if (status != null) {
              return true;
            } else {
              return false;
            }
          },
        ),
        data: {
          'refreshToken': sendRefreshToken,
        },
      );
      if (res.statusCode == 201) {
        await storage.delete(key: 'accessToken');
        await storage.delete(key: 'refreshToken');
      } else {
        final ErrorModel error = ErrorModel.fromJson(res.data);
        throw Exception(error.message);
      }
    } catch (e) {
      rethrow;
    }
  }
}
