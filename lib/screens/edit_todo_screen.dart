import 'package:flutter/material.dart';
import 'package:solid_todo/models/edit_todo_model.dart';
import 'package:provider/provider.dart';
import 'package:solid_todo/models/main_screen_model.dart';
import '../assets/colors.dart';
import '../sql/todo.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditToDoScreen extends StatefulWidget {
  EditToDoScreen({Key? key, required this.todo, required this.flag})
      : super(key: key);
  final ToDo todo;
  final bool flag;

  @override
  State<EditToDoScreen> createState() => _EditToDoScreenState();
}

class _EditToDoScreenState extends State<EditToDoScreen> {
  @override
  void initState() {
    // TODO: implement initState
    EditToDoModel().todoLocalSet = widget.todo;
    super.initState();

    /*
    Future.delayed(Duration.zero, () {
      Provider.of<EditToDoModel>(context).todoLocalSet = widget.todo;
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
        title: Text(
          widget.todo.name!,
          style: const TextStyle(fontSize: 21),
        ),
        actions: [
          IconButton(
              onPressed: () {
                if (widget.flag == true) {
                  EditToDoModel().updateToDataBase(context);
                } else {
                  EditToDoModel().saveToDataBase(context);
                }
              },
              icon: const Icon(Icons.check)),
        ],
      ),
      body: Consumer<EditToDoModel>(builder: (context, editToDoModel, child) {
        return Container(
          color: darkBlue,
          child: ListView.builder(
              itemCount: editToDoModel.todoLocalGet.tasks.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey<int>(editToDoModel.todoLocalGet.tasks.length),
                  onDismissed: (DismissDirection direction) {
                    Provider.of<EditToDoModel>(context, listen: false)
                        .deleteTask(index);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 10, right: 5, left: 5, bottom: 0),
                    //padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: lightMarine,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: ListTile(
                      //Change Text
                      title: Text(
                        editToDoModel.todoLocalGet.tasks[index].toString(),
                        style: TextStyle(color: lightMarine),
                      ),
                      trailing: Checkbox(
                        focusColor: Colors.white,
                        value: editToDoModel.todoLocalGet.completed![index],
                        onChanged: (bool? value) {
                          editToDoModel.changedChecked(index);
                          //Provider.of<EditToDoModel>(context, listen: false).changedChecked(index);
                        },
                      ),
                    ),
                  ),
                );
              }),
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: lightBlue,
        child: Icon(
          Icons.add,
          color: darkBlue,
        ),
        onPressed: () {
          TextEditingController addTask = TextEditingController();
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Enter Task'),
                  content: TextField(
                    controller: addTask,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ToDo Name',
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (addTask.text.isNotEmpty) {
                          Provider.of<EditToDoModel>(context, listen: false)
                              .add(addTask.text);
                          addTask.text = '';

                          Navigator.pop(context, 'Cancel');
                        } else {
                          Fluttertoast.showToast(
                            msg: "Please Add Task",
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        }
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              });
        },
      ),
    );
  }
}
