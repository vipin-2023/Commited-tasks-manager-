import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tasks/Controller/todo_db_functions.dart';

import 'package:tasks/Models/ToDoModels/To_Do_Models.dart';
import 'package:tasks/Views/Splash/Page_Splash_Screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(TodoModelAdapter().typeId)) {
    Hive.registerAdapter(TodoModelAdapter());
  }
  TodoDB().reFreshUi();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Doit',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PageSplashScreen());
  }
}
