import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:solid_todo/sql/todo.dart';

import '../sql/dbhelper.dart';

class MainScreenModel with ChangeNotifier {
   static  List<ToDo> _myData = [];

  get myData => _myData;

void refreshScreen(){
  notifyListeners();
}
  void getDB() async {
     final data = await DatabaseHelper.getItems();


        for (int i = 0; i < data.length; i++) {

          _myData.add(ToDo(id: data[i]['id'], name: data[i]['name'], tasks: (jsonDecode(data[i]['tasks']) as List).map((item) => item as String).toList() , completed: (jsonDecode(data[i]['completed'])as List).map((item) => item as bool).toList()));

        }

    notifyListeners();
  }

  void updateItem(ToDo todo){
    _myData[todo.id!]=todo;
  }
  void addNewItem(ToDo todo) {
    _myData.add(todo);
    notifyListeners();
  }
}
