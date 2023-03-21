import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

void main(List<String> arguments) async{
  var users;

  File file = File('lib/src/active_users.txt');
  var futureContent = await file.readAsString(encoding: utf8);
  print(futureContent.toString());
  // List<String> splittedString;
  //
  // print(futureContent);
  // print('_________________________________________');
  //
  // splittedString = futureContent.split(',');
  // for (var element in splittedString) {print('$element -> ${element.length}');}
}
