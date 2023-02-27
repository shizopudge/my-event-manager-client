import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/constants.dart';
import '../../auth/models/errors/error.dart';
import '../models/event.dart';

class EventsReposiotry {
  final dio = Dio(
    BaseOptions(
      contentType: 'application/json',
      baseUrl: baseUrl,
    ),
  );

  Future<List<Event>> getUserEvents(String uid) async {
    try {
      const storage = FlutterSecureStorage();
      final List<Event> events = [];
      String accessToken = await storage.read(key: 'accessToken') ?? 'null';
      String refreshToken = await storage.read(key: 'refreshToken') ?? 'null';
      final res = await dio.get(
        '/events',
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
        events.add(Event.fromJson(res.data['events'][i]));
      }
      return events;
    } catch (e) {
      rethrow;
    }
  }

  Future<Event> createEvent({
    required String title,
    required String description,
    required String color,
    required String priority,
    required String authorId,
  }) async {
    try {
      const storage = FlutterSecureStorage();
      String accessToken = await storage.read(key: 'accessToken') ?? 'null';
      String refreshToken = await storage.read(key: 'refreshToken') ?? 'null';
      final res = await dio.post(
        '/events',
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            if (status != null) {
              return true;
            } else {
              return false;
            }
          },
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Cookie': 'refreshToken=$refreshToken',
          },
        ),
        data: {
          'title': title,
          'description': description,
          'color': color,
          'priority': priority,
          'authorId': authorId,
        },
      );
      if (res.statusCode == 201) {
        final Event event = Event.fromJson(res.data['createdEvent']);
        return event;
      } else {
        final ErrorModel error = ErrorModel.fromJson(res.data);
        throw Exception(error.message);
      }
    } catch (e) {
      rethrow;
    }
  }
}
