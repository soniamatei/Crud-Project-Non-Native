import 'package:realm/realm.dart';

part 'password.g.dart';

@RealmModel()
class _Password {
  @PrimaryKey()
  late int id;
  late String serviceWebsiteName;
  late String email;
  late String username;
  late String password;
  late String note;
}