import 'dart:io';

import 'package:cat_miaunder/models/password.dart';
import 'package:flutter/cupertino.dart';
import 'package:realm/realm.dart';

class ViewModel extends ChangeNotifier {
  List<Password> list = [];
  late final Realm realm;
  int counterId = 0;

  ViewModel() {
    initViewModel();
  }

  Future<void> initViewModel() async {
    final config = Configuration.local([Password.schema]);
    realm = Realm(config);

    list = await (() async {
      return realm.all<Password>().toList();
    })();

    if (list.isNotEmpty) {
      counterId = list.reduce((value, element) => value.id > element.id ? value : element).id + 1;
    }
    notifyListeners();
  }

  void populate() {
    for (int i = 0; i < 20; i++) {
      addItem(
          serviceWebsiteName: counterId.toString(),
          email: "sdsd@gmail.com",
          username: "sdsd",
          password: "nshh4r4ff",
          note: "");
    }

    notifyListeners();
  }

  void addItem({
    required String serviceWebsiteName,
    required String email,
    required String username,
    required String password,
    required String note,
  }) {
    Password? existingPassword;

    try {
      existingPassword = list.firstWhere((p) =>
            p.serviceWebsiteName == serviceWebsiteName &&
            p.email == email &&
            p.username == username &&
            p.password == password &&
            p.note == note,
      );
    } catch (_) {
      existingPassword = null;
    }

    if (existingPassword != null) {
      throw StateError('Password with the same fields already exists');
    }

    Password newPassword = Password(
      counterId++,
      serviceWebsiteName,
      email,
      username,
      password,
      note,
    );

    realm.write(() {
      realm.add(newPassword);
    });
    list.add(newPassword);

    notifyListeners();
  }

  void updateItem({
    required int id,
    required String serviceWebsiteName,
    required String email,
    required String username,
    required String password,
    required String note,
  }) {

    Password? existingPasswordRealm = realm.find<Password>(id);

    if (existingPasswordRealm != null) {

      realm.write(() {
        existingPasswordRealm.serviceWebsiteName = serviceWebsiteName;
        existingPasswordRealm.email = email;
        existingPasswordRealm.username = username;
        existingPasswordRealm.password = password;
        existingPasswordRealm.note = note;
      });

      notifyListeners();
    }
  }

  void deleteItem(int id) {

    Password? existingPasswordRealm = realm.find<Password>(id);

    if (existingPasswordRealm != null && existingPasswordRealm.isValid) {

      list.removeWhere((password) => password.id == id);

      realm.write(() {
        realm.delete(existingPasswordRealm);
      });

      notifyListeners();
    }
  }

  @override
  void dispose() {
    realm.close();
    super.dispose();
  }
}
