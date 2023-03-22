import 'dart:convert';
import 'dart:io';

import 'package:ad_coverter/src/user.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main(List<String> arguments) async{
  File file = File('lib/src/adtest.txt');
  String futureContent = await file.readAsString(encoding: utf8);
  var splittedString = futureContent.split(',');
  String tmp = '';
  List<String> tmpList = [];
  List<User> userList = [];

  splittedString.removeAt(splittedString.length - 1);
  print(splittedString.length);

  for(var i = 0; i < splittedString.length - 2; i++) {
    if(splittedString[i] == '') splittedString[i] = 'placeholder';
    for(var j = 0; j < 3; j++) {
      tmp += splittedString[i + j];
      tmp += ' ';
    }
    User user = User(
        name: splittedString[i],
        status: splittedString[i + 1],
        jobTitle: splittedString[i + 2]);
    userList.add(user);
    tmpList.add(tmp);
    tmp = '';
    i += 2;
  }
  // tmpList.forEach((element) {print('_____________'); print(element);});

  userList.forEach((element) {
    element.name = element.name?.trimLeft();
    print(element.name);
    print(element.status);
    print(element.jobTitle);
    print('__________________');
  });

  print(userList.length.toString());
  sqfliteFfiInit();
  var databaseFactory = databaseFactoryFfi;
  var db = await databaseFactory.openDatabase('C:/distr/proj/SSK_MANAGER/lib/src/asseets/database/sqfile.db');
  if(db.isOpen) {
    await db.execute('''
  CREATE TABLE User (
      id INTEGER PRIMARY KEY,
      name TEXT,
      status TEXT,
      jobTitle TEXT
  )
  ''');

    for (var i = 0; i < userList.length; i++) {
      await db.insert(
          'User',
          <String, Object?>{'name': userList[i].name, 'status' : userList[i].status, 'jobTitle': userList[i].jobTitle});
    }

    // print(await db.query('User'));

    db.close();

    print('rdy');
  }
}
