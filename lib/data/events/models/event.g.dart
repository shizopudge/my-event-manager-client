// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Event _$$_EventFromJson(Map<String, dynamic> json) => _$_Event(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      picture: json['picture'] as String?,
      membersCount: json['membersCount'] as int,
      color: json['color'] as String?,
      isFinished: json['isFinished'] as bool,
      priority: json['priority'] as String,
      authorId: json['authorId'] as String,
    );

Map<String, dynamic> _$$_EventToJson(_$_Event instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'picture': instance.picture,
      'membersCount': instance.membersCount,
      'color': instance.color,
      'isFinished': instance.isFinished,
      'priority': instance.priority,
      'authorId': instance.authorId,
    };
