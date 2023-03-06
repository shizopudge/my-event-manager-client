import 'package:client/data/user/repository/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/constants.dart';
import '../../auth/models/errors/error.dart';
import '../../user/models/user.dart';
import '../models/event.dart';

class EventsReposiotry {
  final dio = Dio(
    BaseOptions(
      contentType: 'application/json',
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  Future<Event> getCertainEvent(String eventId) async {
    try {
      final List<EventMember> eventMembers = [];
      const storage = FlutterSecureStorage();
      String accessToken = await storage.read(key: 'accessToken') ?? 'null';
      String refreshToken = await storage.read(key: 'refreshToken') ?? 'null';
      final res = await dio.get(
        '/events/certain-event',
        data: {
          'eventId': eventId,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Cookie': 'refreshToken=$refreshToken',
          },
        ),
      );
      final Event event = Event.fromJson(res.data);
      for (int i = 0; i < event.membersCount; i++) {
        final String uid = res.data['eventMembers'][i]['userId'];
        final bool isAdmin = res.data['eventMembers'][i]['isAdmin'];
        final User user = await UserRepository().getUser(uid);
        eventMembers.add(
          EventMember(isAdmin: isAdmin, user: user),
        );
      }
      return event.copyWith(members: eventMembers);
    } catch (e) {
      rethrow;
    }
  }

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

  Future<List<Event>> getFinishedUserEvents(String uid) async {
    try {
      const storage = FlutterSecureStorage();
      final List<Event> events = [];
      String accessToken = await storage.read(key: 'accessToken') ?? 'null';
      String refreshToken = await storage.read(key: 'refreshToken') ?? 'null';
      final res = await dio.get(
        '/events/finished',
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

  Future<List<Event>> getUnfinishedUserEvents(String uid) async {
    try {
      const storage = FlutterSecureStorage();
      final List<Event> events = [];
      String accessToken = await storage.read(key: 'accessToken') ?? 'null';
      String refreshToken = await storage.read(key: 'refreshToken') ?? 'null';
      final res = await dio.get(
        '/events/unfinished',
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
    required String type,
    required DateTime eventDate,
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
          'type': type,
          'color': color,
          'priority': priority,
          'authorId': authorId,
          'eventDate': eventDate.toString(),
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

  Future<bool> finishEvent({
    required String eventId,
  }) async {
    try {
      const storage = FlutterSecureStorage();
      String accessToken = await storage.read(key: 'accessToken') ?? 'null';
      String refreshToken = await storage.read(key: 'refreshToken') ?? 'null';
      final res = await dio.put(
        '/events/finish',
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
          "eventId": eventId,
        },
      );
      if (res.statusCode == 200) {
        return true;
      } else {
        final ErrorModel error = ErrorModel.fromJson(res.data);
        throw Exception(error.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteEvent({
    required String eventId,
    required String userId,
  }) async {
    try {
      const storage = FlutterSecureStorage();
      String accessToken = await storage.read(key: 'accessToken') ?? 'null';
      String refreshToken = await storage.read(key: 'refreshToken') ?? 'null';
      final res = await dio.delete(
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
          "eventId": eventId,
          "userId": userId,
        },
      );
      if (res.statusCode == 200) {
        return true;
      } else {
        final ErrorModel error = ErrorModel.fromJson(res.data);
        throw Exception(error.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addMember({
    required String userId,
    required String eventId,
    required String adminId,
  }) async {
    try {
      const storage = FlutterSecureStorage();
      String accessToken = await storage.read(key: 'accessToken') ?? 'null';
      String refreshToken = await storage.read(key: 'refreshToken') ?? 'null';
      final res = await dio.post(
        '/events/member',
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
          "userId": userId,
          "eventId": eventId,
          "adminId": adminId,
        },
      );
      if (res.statusCode == 201) {
        return true;
      } else {
        final ErrorModel error = ErrorModel.fromJson(res.data);
        throw Exception(error.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteMember({
    required String userId,
    required String eventId,
    required String adminId,
  }) async {
    try {
      const storage = FlutterSecureStorage();
      String accessToken = await storage.read(key: 'accessToken') ?? 'null';
      String refreshToken = await storage.read(key: 'refreshToken') ?? 'null';
      final res = await dio.delete(
        '/events/member',
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
          "userId": userId,
          "eventId": eventId,
          "adminId": adminId,
        },
      );
      if (res.statusCode == 200) {
        return true;
      } else {
        final ErrorModel error = ErrorModel.fromJson(res.data);
        throw Exception(error.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isUserAuthor(
      {required String uid, required String eventId}) async {
    try {
      const storage = FlutterSecureStorage();
      String accessToken = await storage.read(key: 'accessToken') ?? 'null';
      String refreshToken = await storage.read(key: 'refreshToken') ?? 'null';
      final res = await dio.get(
        '/events/author-check',
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
        data: {"userId": uid, "eventId": eventId},
      );
      if (res.statusCode == 200) {
        final bool isAuthor = res.data['isAuthor'];
        return isAuthor;
      } else {
        final ErrorModel error = ErrorModel.fromJson(res.data);
        throw Exception(error.message);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isAdmin({required String uid, required String eventId}) async {
    try {
      const storage = FlutterSecureStorage();
      String accessToken = await storage.read(key: 'accessToken') ?? 'null';
      String refreshToken = await storage.read(key: 'refreshToken') ?? 'null';
      final res = await dio.get(
        '/events/user-role',
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
        data: {"userId": uid, "eventId": eventId},
      );
      if (res.statusCode == 200) {
        final bool isAdmin = res.data['isAdmin'];
        return isAdmin;
      } else {
        final ErrorModel error = ErrorModel.fromJson(res.data);
        throw Exception(error.message);
      }
    } catch (e) {
      rethrow;
    }
  }
}
