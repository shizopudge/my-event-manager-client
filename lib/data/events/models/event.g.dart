// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Event _$$_EventFromJson(Map<String, dynamic> json) => _$_Event(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      picture: json['picture'] as String?,
      membersCount: json['membersCount'] as int,
      color: json['color'] as String?,
      isFinished: json['isFinished'] as bool,
      priority: json['priority'] as String,
      authorId: json['authorId'] as String,
      eventDate: DateTime.parse(json['eventDate'] as String),
      author: json['author'] == null
          ? null
          : User.fromJson(json['author'] as Map<String, dynamic>),
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => EventMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_EventToJson(_$_Event instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'type': instance.type,
      'picture': instance.picture,
      'membersCount': instance.membersCount,
      'color': instance.color,
      'isFinished': instance.isFinished,
      'priority': instance.priority,
      'authorId': instance.authorId,
      'eventDate': instance.eventDate.toIso8601String(),
      'author': instance.author,
      'members': instance.members,
    };

_$_EventMember _$$_EventMemberFromJson(Map<String, dynamic> json) =>
    _$_EventMember(
      isAdmin: json['isAdmin'] as bool,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_EventMemberToJson(_$_EventMember instance) =>
    <String, dynamic>{
      'isAdmin': instance.isAdmin,
      'user': instance.user,
    };
