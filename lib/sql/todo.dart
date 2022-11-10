import 'dbhelper.dart';

class ToDo {
  int id;
  String name;
  List<String> tasks;
  List<bool> completed;

  ToDo(
       this.id,
     this.name,
      this.tasks,
      this.completed);

  fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    tasks=map['tasks'];
    completed=map['completed'];
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnTasks: tasks,
      DatabaseHelper.columnCompleted:completed,
    };
  }
}
