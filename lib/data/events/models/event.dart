import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import '../../user/models/user.dart';

part 'event.freezed.dart';
part 'event.g.dart';

@freezed
class Event with _$Event {
  const factory Event({
    required String id,
    required String title,
    required String description,
    required String type,
    required String? picture,
    required int membersCount,
    required String? color,
    required bool isFinished,
    required String priority,
    required String authorId,
    required DateTime eventDate,
    required User? author,
    required List<EventMember>? members,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}

@freezed
class EventMember with _$EventMember {
  const factory EventMember({
    required bool isAdmin,
    required User user,
  }) = _EventMember;

  factory EventMember.fromJson(Map<String, dynamic> json) =>
      _$EventMemberFromJson(json);
}
