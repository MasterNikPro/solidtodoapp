import 'package:flutter/material.dart';
import 'package:solid_todo/assets/colors.dart';
import 'package:solid_todo/models/main_screen_model.dart';
import 'package:provider/provider.dart';
import 'package:solid_todo/sql/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
   Database? db;
  void getDB()async{
    db= await DatabaseHelper.instance;
  }
  @override
  void initState() {
    getDB();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        elevation: 0,
        title: const Text(
          "Solid Todo",
          style: TextStyle(fontSize: 21),
        ),
      ),
      body: Container(
        color: darkBlue,
        child: Consumer<MainScreenModel>(
          builder: (context, mainScreenModel, child) {
            return ListView.builder(

                itemCount: 3,
                itemBuilder: (context, index) {
                  return Dismissible(
                    //Заменить число на значние
                    key: const ValueKey<int>(3),
                    onDismissed: (DismissDirection direction) {},
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
                        onTap: (){
                          Navigator.pushReplacementNamed(context, '/edit_todo_screen');
                        },
                        //Change Text
                        title: Text("ListPart:$index", style: TextStyle(color: lightMarine),
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
        onPressed: (){showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Enter Task'),
                content: const TextField(
                  decoration: InputDecoration(
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
                    onPressed: () {},
                    child: const Text('OK'),
                  ),
                ],
              );
            });},
      ),
    );

  }
}
