import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solid_todo/sql/todo.dart';

import 'models/edit_todo_model.dart';
import 'models/main_screen_model.dart';
import 'screens/edit_todo_screen.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<EditToDoModel>(
            create: (context) => EditToDoModel()),
        ChangeNotifierProvider<MainScreenModel>(
          create: (context) => MainScreenModel(),

        ),
      ],
      child: const AppMain(),
    ),
  );
}

class AppMain extends StatefulWidget {
  const AppMain({Key? key}) : super(key: key);

  @override
  State<AppMain> createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {

  @override
  void didChangeDependencies() {
    Future.delayed(Duration.zero, () {
      Provider.of<MainScreenModel>(context, listen: false).getDB();
    }).then((value) {

    });
    super.didChangeDependencies();

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/edit_todo_screen': (context) => EditToDoScreen(
            flag: false,
            todo: ToDo(name: '', id: null, tasks: [], completed: [])),
      },
    );
  }
}
