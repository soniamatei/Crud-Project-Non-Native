// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Password extends _Password
    with RealmEntity, RealmObjectBase, RealmObject {
  Password(
    int id,
    String serviceWebsiteName,
    String email,
    String username,
    String password,
    String note,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'serviceWebsiteName', serviceWebsiteName);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'username', username);
    RealmObjectBase.set(this, 'password', password);
    RealmObjectBase.set(this, 'note', note);
  }

  Password._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get serviceWebsiteName =>
      RealmObjectBase.get<String>(this, 'serviceWebsiteName') as String;
  @override
  set serviceWebsiteName(String value) =>
      RealmObjectBase.set(this, 'serviceWebsiteName', value);

  @override
  String get email => RealmObjectBase.get<String>(this, 'email') as String;
  @override
  set email(String value) => RealmObjectBase.set(this, 'email', value);

  @override
  String get username =>
      RealmObjectBase.get<String>(this, 'username') as String;
  @override
  set username(String value) => RealmObjectBase.set(this, 'username', value);

  @override
  String get password =>
      RealmObjectBase.get<String>(this, 'password') as String;
  @override
  set password(String value) => RealmObjectBase.set(this, 'password', value);

  @override
  String get note => RealmObjectBase.get<String>(this, 'note') as String;
  @override
  set note(String value) => RealmObjectBase.set(this, 'note', value);

  @override
  Stream<RealmObjectChanges<Password>> get changes =>
      RealmObjectBase.getChanges<Password>(this);

  @override
  Password freeze() => RealmObjectBase.freezeObject<Password>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Password._);
    return const SchemaObject(ObjectType.realmObject, Password, 'Password', [
      SchemaProperty('id', RealmPropertyType.int, primaryKey: true),
      SchemaProperty('serviceWebsiteName', RealmPropertyType.string),
      SchemaProperty('email', RealmPropertyType.string),
      SchemaProperty('username', RealmPropertyType.string),
      SchemaProperty('password', RealmPropertyType.string),
      SchemaProperty('note', RealmPropertyType.string),
    ]);
  }
}
