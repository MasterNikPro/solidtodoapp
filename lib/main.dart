import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/edit_todo_model.dart';
import 'models/main_screen_model.dart';
import 'screens/edit_todo_screen.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MainScreenModel>(
          create: (_) => MainScreenModel(),
        ),
        ChangeNotifierProvider<EditToDoModel>(create: (_) => EditToDoModel()),
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
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/edit_todo_screen': (context) => const EditToDoScreen(),
      },
    );
  }
}
