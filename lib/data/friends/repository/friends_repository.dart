import 'package:client/data/user/repository/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/constants.dart';
import '../../user/models/user.dart';

class FriendsRepository {
  final dio = Dio(
    BaseOptions(
      contentType: 'application/json',
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  Future<List<User>> getFriends(String uid) async {
    try {
      const storage = FlutterSecureStorage();
      final List<User> friends = [];
      String accessToken = await storage.read(key: 'accessToken') ?? 'null';
      String refreshToken = await storage.read(key: 'refreshToken') ?? 'null';
      final res = await dio.get(
        '/friends',
        data: {
          'userId': uid,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Cookie': 'refreshToken=$refreshToken',
          },
        ),
      );
      final int count = res.data['count'];
      for (int i = 0; i < count; i++) {
        final String friendId = res.data['friends'][i]['friendId'];
        final User friend = await UserRepository().getUser(friendId);
        friends.add(friend);
      }
      return friends;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>> getFriendSuggestions(String uid) async {
    try {
      const storage = FlutterSecureStorage();
      final List<String> friendIds = [];
      String accessToken = await storage.read(key: 'accessToken') ?? 'null';
      String refreshToken = await storage.read(key: 'refreshToken') ?? 'null';
      final res = await dio.get(
        '/friendRequests/suggestions',
        data: {
          'userId': uid,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Cookie': 'refreshToken=$refreshToken',
          },
        ),
      );
      final int count = res.data['count'];
      for (int i = 0; i < count; i++) {
        final String friendId = res.data['friendSuggestions'][i]['sender'];
        friendIds.add(friendId);
      }
      return friendIds;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>> getFriendRequests(String uid) async {
    try {
      const storage = FlutterSecureStorage();
      final List<String> friendIds = [];
      String accessToken = await storage.read(key: 'accessToken') ?? 'null';
      String refreshToken = await storage.read(key: 'refreshToken') ?? 'null';
      final res = await dio.get(
        '/friendRequests/requests',
        data: {
          'userId': uid,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Cookie': 'refreshToken=$refreshToken',
          },
        ),
      );
      final int count = res.data['count'];
      for (int i = 0; i < count; i++) {
        final String friendId = res.data['friendRequests'][i]['receiver'];
        friendIds.add(friendId);
      }
      return friendIds;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteFromFriends(String uid, String friendId) async {
    try {
      const storage = FlutterSecureStorage();
      String accessToken = await storage.read(key: 'accessToken') ?? 'null';
      String refreshToken = await storage.read(key: 'refreshToken') ?? 'null';
      final res = await dio.delete(
        '/friends',
        data: {
          'userId': uid,
          'friendId': friendId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Cookie': 'refreshToken=$refreshToken',
          },
        ),
      );
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
}
