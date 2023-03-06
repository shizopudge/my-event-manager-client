// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Event _$EventFromJson(Map<String, dynamic> json) {
  return _Event.fromJson(json);
}

/// @nodoc
mixin _$Event {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get picture => throw _privateConstructorUsedError;
  int get membersCount => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  bool get isFinished => throw _privateConstructorUsedError;
  String get priority => throw _privateConstructorUsedError;
  String get authorId => throw _privateConstructorUsedError;
  DateTime get eventDate => throw _privateConstructorUsedError;
  User? get author => throw _privateConstructorUsedError;
  List<EventMember>? get members => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventCopyWith<Event> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventCopyWith<$Res> {
  factory $EventCopyWith(Event value, $Res Function(Event) then) =
      _$EventCopyWithImpl<$Res, Event>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String type,
      String? picture,
      int membersCount,
      String? color,
      bool isFinished,
      String priority,
      String authorId,
      DateTime eventDate,
      User? author,
      List<EventMember>? members});

  $UserCopyWith<$Res>? get author;
}

/// @nodoc
class _$EventCopyWithImpl<$Res, $Val extends Event>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? picture = freezed,
    Object? membersCount = null,
    Object? color = freezed,
    Object? isFinished = null,
    Object? priority = null,
    Object? authorId = null,
    Object? eventDate = null,
    Object? author = freezed,
    Object? members = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String?,
      membersCount: null == membersCount
          ? _value.membersCount
          : membersCount // ignore: cast_nullable_to_non_nullable
              as int,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      isFinished: null == isFinished
          ? _value.isFinished
          : isFinished // ignore: cast_nullable_to_non_nullable
              as bool,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      eventDate: null == eventDate
          ? _value.eventDate
          : eventDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as User?,
      members: freezed == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<EventMember>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get author {
    if (_value.author == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.author!, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_EventCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$$_EventCopyWith(_$_Event value, $Res Function(_$_Event) then) =
      __$$_EventCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      String type,
      String? picture,
      int membersCount,
      String? color,
      bool isFinished,
      String priority,
      String authorId,
      DateTime eventDate,
      User? author,
      List<EventMember>? members});

  @override
  $UserCopyWith<$Res>? get author;
}

/// @nodoc
class __$$_EventCopyWithImpl<$Res> extends _$EventCopyWithImpl<$Res, _$_Event>
    implements _$$_EventCopyWith<$Res> {
  __$$_EventCopyWithImpl(_$_Event _value, $Res Function(_$_Event) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? type = null,
    Object? picture = freezed,
    Object? membersCount = null,
    Object? color = freezed,
    Object? isFinished = null,
    Object? priority = null,
    Object? authorId = null,
    Object? eventDate = null,
    Object? author = freezed,
    Object? members = freezed,
  }) {
    return _then(_$_Event(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      picture: freezed == picture
          ? _value.picture
          : picture // ignore: cast_nullable_to_non_nullable
              as String?,
      membersCount: null == membersCount
          ? _value.membersCount
          : membersCount // ignore: cast_nullable_to_non_nullable
              as int,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      isFinished: null == isFinished
          ? _value.isFinished
          : isFinished // ignore: cast_nullable_to_non_nullable
              as bool,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      eventDate: null == eventDate
          ? _value.eventDate
          : eventDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as User?,
      members: freezed == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<EventMember>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Event with DiagnosticableTreeMixin implements _Event {
  const _$_Event(
      {required this.id,
      required this.title,
      required this.description,
      required this.type,
      required this.picture,
      required this.membersCount,
      required this.color,
      required this.isFinished,
      required this.priority,
      required this.authorId,
      required this.eventDate,
      required this.author,
      required final List<EventMember>? members})
      : _members = members;

  factory _$_Event.fromJson(Map<String, dynamic> json) =>
      _$$_EventFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  final String type;
  @override
  final String? picture;
  @override
  final int membersCount;
  @override
  final String? color;
  @override
  final bool isFinished;
  @override
  final String priority;
  @override
  final String authorId;
  @override
  final DateTime eventDate;
  @override
  final User? author;
  final List<EventMember>? _members;
  @override
  List<EventMember>? get members {
    final value = _members;
    if (value == null) return null;
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Event(id: $id, title: $title, description: $description, type: $type, picture: $picture, membersCount: $membersCount, color: $color, isFinished: $isFinished, priority: $priority, authorId: $authorId, eventDate: $eventDate, author: $author, members: $members)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Event'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('picture', picture))
      ..add(DiagnosticsProperty('membersCount', membersCount))
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('isFinished', isFinished))
      ..add(DiagnosticsProperty('priority', priority))
      ..add(DiagnosticsProperty('authorId', authorId))
      ..add(DiagnosticsProperty('eventDate', eventDate))
      ..add(DiagnosticsProperty('author', author))
      ..add(DiagnosticsProperty('members', members));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Event &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.picture, picture) || other.picture == picture) &&
            (identical(other.membersCount, membersCount) ||
                other.membersCount == membersCount) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.isFinished, isFinished) ||
                other.isFinished == isFinished) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.eventDate, eventDate) ||
                other.eventDate == eventDate) &&
            (identical(other.author, author) || other.author == author) &&
            const DeepCollectionEquality().equals(other._members, _members));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      type,
      picture,
      membersCount,
      color,
      isFinished,
      priority,
      authorId,
      eventDate,
      author,
      const DeepCollectionEquality().hash(_members));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventCopyWith<_$_Event> get copyWith =>
      __$$_EventCopyWithImpl<_$_Event>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventToJson(
      this,
    );
  }
}

abstract class _Event implements Event {
  const factory _Event(
      {required final String id,
      required final String title,
      required final String description,
      required final String type,
      required final String? picture,
      required final int membersCount,
      required final String? color,
      required final bool isFinished,
      required final String priority,
      required final String authorId,
      required final DateTime eventDate,
      required final User? author,
      required final List<EventMember>? members}) = _$_Event;

  factory _Event.fromJson(Map<String, dynamic> json) = _$_Event.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  String get type;
  @override
  String? get picture;
  @override
  int get membersCount;
  @override
  String? get color;
  @override
  bool get isFinished;
  @override
  String get priority;
  @override
  String get authorId;
  @override
  DateTime get eventDate;
  @override
  User? get author;
  @override
  List<EventMember>? get members;
  @override
  @JsonKey(ignore: true)
  _$$_EventCopyWith<_$_Event> get copyWith =>
      throw _privateConstructorUsedError;
}

EventMember _$EventMemberFromJson(Map<String, dynamic> json) {
  return _EventMember.fromJson(json);
}

/// @nodoc
mixin _$EventMember {
  bool get isAdmin => throw _privateConstructorUsedError;
  User get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventMemberCopyWith<EventMember> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventMemberCopyWith<$Res> {
  factory $EventMemberCopyWith(
          EventMember value, $Res Function(EventMember) then) =
      _$EventMemberCopyWithImpl<$Res, EventMember>;
  @useResult
  $Res call({bool isAdmin, User user});

  $UserCopyWith<$Res> get user;
}

/// @nodoc
class _$EventMemberCopyWithImpl<$Res, $Val extends EventMember>
    implements $EventMemberCopyWith<$Res> {
  _$EventMemberCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAdmin = null,
    Object? user = null,
  }) {
    return _then(_value.copyWith(
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res> get user {
    return $UserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_EventMemberCopyWith<$Res>
    implements $EventMemberCopyWith<$Res> {
  factory _$$_EventMemberCopyWith(
          _$_EventMember value, $Res Function(_$_EventMember) then) =
      __$$_EventMemberCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isAdmin, User user});

  @override
  $UserCopyWith<$Res> get user;
}

/// @nodoc
class __$$_EventMemberCopyWithImpl<$Res>
    extends _$EventMemberCopyWithImpl<$Res, _$_EventMember>
    implements _$$_EventMemberCopyWith<$Res> {
  __$$_EventMemberCopyWithImpl(
      _$_EventMember _value, $Res Function(_$_EventMember) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAdmin = null,
    Object? user = null,
  }) {
    return _then(_$_EventMember(
      isAdmin: null == isAdmin
          ? _value.isAdmin
          : isAdmin // ignore: cast_nullable_to_non_nullable
              as bool,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EventMember with DiagnosticableTreeMixin implements _EventMember {
  const _$_EventMember({required this.isAdmin, required this.user});

  factory _$_EventMember.fromJson(Map<String, dynamic> json) =>
      _$$_EventMemberFromJson(json);

  @override
  final bool isAdmin;
  @override
  final User user;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'EventMember(isAdmin: $isAdmin, user: $user)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'EventMember'))
      ..add(DiagnosticsProperty('isAdmin', isAdmin))
      ..add(DiagnosticsProperty('user', user));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventMember &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, isAdmin, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventMemberCopyWith<_$_EventMember> get copyWith =>
      __$$_EventMemberCopyWithImpl<_$_EventMember>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventMemberToJson(
      this,
    );
  }
}

abstract class _EventMember implements EventMember {
  const factory _EventMember(
      {required final bool isAdmin, required final User user}) = _$_EventMember;

  factory _EventMember.fromJson(Map<String, dynamic> json) =
      _$_EventMember.fromJson;

  @override
  bool get isAdmin;
  @override
  User get user;
  @override
  @JsonKey(ignore: true)
  _$$_EventMemberCopyWith<_$_EventMember> get copyWith =>
      throw _privateConstructorUsedError;
}
