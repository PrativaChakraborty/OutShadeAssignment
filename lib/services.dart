import 'package:flutter/services.dart';

import 'models/user_list.dart';

Future<List<User>> getUsers() async {
  var jsonStr = await rootBundle.loadString('assets/mock.json');
  var userList = userListFromJson(jsonStr);
  return userList.first.users;
}
