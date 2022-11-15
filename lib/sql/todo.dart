import 'dart:convert';



class ToDo {
  int? id;
  String? name;
  List<String?>? tasks;
  List<bool?>? completed;

  ToDo({ required this.id,  required this.name,  required this.tasks, required this.completed});

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
        id: map['id'],
        name: map['name'],
        tasks:jsonDecode(map['categories']),
        completed:jsonDecode(map['completed']));
  }
}
