import 'package:flutter/material.dart';
import 'package:solid_todo/models/edit_todo_model.dart';
import 'package:provider/provider.dart';
import '../assets/colors.dart';

class EditToDoScreen extends StatefulWidget {
  const EditToDoScreen({Key? key}) : super(key: key);

  @override
  State<EditToDoScreen> createState() => _EditToDoScreenState();
}

class _EditToDoScreenState extends State<EditToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {Navigator.pushReplacementNamed(context, '/');},
        ),
        title: const Text(
          "ToDo Name",
          style: TextStyle(fontSize: 21),
        ),
        actions: [
          IconButton(
              onPressed: () {
              },
              icon: const Icon(Icons.check)),
        ],
      ),
      body: Container(
        color: darkBlue,
        child:
            Consumer<EditToDoModel>(builder: (context, editToDoModel, child) {
          return ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return Dismissible(
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
                      //Change Text
                      title: Text(
                        "ListPart:${index}",
                        style: TextStyle(color: lightMarine),
                      ),
                      trailing: Checkbox(
                        value: true,
                        onChanged: (bool? value) {},
                      ),
                    ),
                  ),
                );
              });
        }),
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
              });
        },
      ),
    );
  }
}
