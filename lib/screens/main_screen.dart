import 'package:flutter/material.dart';
import 'package:solid_todo/assets/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:solid_todo/models/main_screen_model.dart';
import 'package:provider/provider.dart';
import 'package:solid_todo/screens/edit_todo_screen.dart';
import 'package:solid_todo/sql/dbhelper.dart';

import '../sql/todo.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
@override
  void didChangeDependencies() {
  Provider.of<MainScreenModel>(context, listen:true).myData;
    super.didChangeDependencies();
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: darkBlue,
        elevation: 0,
        title: const Text(
          "Solid Todo",
          style: TextStyle(fontSize: 21),
        ),
      ),
      body: MainScreenModel().myData == null || MainScreenModel().myData.isEmpty
          ? Container(
              color: darkBlue,
              child: const Center(
                child: Text(
                  "Add ToDo",
                  style: TextStyle(color: Colors.white, fontSize: 21),
                ),
              ),
            )
          : Container(
              color: darkBlue,
              child: Consumer<MainScreenModel>(
                builder: (context, mainScreenModel, child) {
                  return ListView.builder(
                      itemCount: mainScreenModel.myData.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          //Заменить число на значние
                          key: ValueKey<int>(mainScreenModel.myData.length),
                          onDismissed: (DismissDirection direction) {
                            DatabaseHelper.deleteItem(
                                mainScreenModel.myData[index].id);
                            mainScreenModel.myData.removeAt(index);
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditToDoScreen(
                                      todo: mainScreenModel.myData[index],
                                      flag: true,
                                    ),
                                  ),
                                );
                              },
                              //Change Text
                              title: Text(
                                mainScreenModel.myData[index].name,
                                style: TextStyle(color: lightMarine),
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: lightBlue,
        child: Icon(
          Icons.add,
          color: darkBlue,
        ),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                TextEditingController todoNameController =
                    TextEditingController();
                return AlertDialog(
                  title: const Text('Enter Task'),
                  content: TextField(
                    controller: todoNameController,
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
                        if (todoNameController.text.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditToDoScreen(
                                todo: ToDo(
                                    name: todoNameController.text,
                                    id: MainScreenModel().myData.length,
                                    tasks: [],
                                    completed: []),
                                flag: false,
                              ),
                            ),
                          );
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please Enter Name",
                              toastLength: Toast.LENGTH_SHORT);
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
