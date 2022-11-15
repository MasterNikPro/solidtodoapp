import 'package:flutter/material.dart';
import 'package:solid_todo/models/main_screen_model.dart';
import 'package:solid_todo/sql/dbhelper.dart';
import 'package:provider/provider.dart';
import '../sql/todo.dart';

class EditToDoModel extends ChangeNotifier {
static ToDo _todoLocal = ToDo(
    id: null,
    tasks: [],
    completed: [],
    name: '',
  );

  set todoLocalSet(ToDo todo) {
    _todoLocal = todo;
  }

  get todoLocalGet => _todoLocal;

  void add(String? text) {
    _todoLocal.tasks?.add(text);
    _todoLocal.completed?.add(false);
    notifyListeners();
  }

  void changedChecked(int index) {

    if (_todoLocal.completed![index] != null) {
    if(_todoLocal.completed![index]==false){
      _todoLocal.completed![index]=true;
    }else{
      _todoLocal.completed![index]=false;
    }
    }
   // print(_todoLocal.completed![index]);
   // _todoLocal.completed![index]=!_todoLocal.completed[index];
    notifyListeners();
  }

  void deleteTask(int index) {
    _todoLocal.tasks!.removeAt(index);
    _todoLocal.completed!.removeAt(index);
    notifyListeners();
  }

  void updateToDataBase(BuildContext context)async{
    await DatabaseHelper.updateItem(_todoLocal);
    Provider.of<MainScreenModel>(context,listen: false).updateItem(_todoLocal);
    Navigator.pushReplacementNamed(context, '/');
  }

void saveToDataBase(BuildContext context) async {

    await DatabaseHelper.createItem(todoLocalGet);
      Provider.of<MainScreenModel>( context, listen: false).addNewItem(_todoLocal);
      Navigator.pushReplacementNamed(context, '/');

  }
}
