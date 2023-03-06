import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/constants.dart';
import '../models/user.dart';

enum UserStatus {
  friends,
  requestSended,
  requestReceived,
  notFriends,
}

class UserRepository {
  final dio = Dio(
    BaseOptions(
      contentType: 'application/json',
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );
  Future<User> getUser(String uid) async {
    try {
      const storage = FlutterSecureStorage();
      String accessToken = await storage.read(key: 'accessToken') ?? 'null';
      String refreshToken = await storage.read(key: 'refreshToken') ?? 'null';
      final res = await dio.get(
        '/users/certain-user',
        data: {
          'id': uid,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Cookie': 'refreshToken=$refreshToken',
          },
        ),
      );
      final User user = User.fromJson(res.data);
      return user;
    } catch (e) {
      rethrow;
    }
  }
}
