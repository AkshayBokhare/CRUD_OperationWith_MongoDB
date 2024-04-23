import 'package:flutter/material.dart';
import 'package:http_methods_poc/dbHelper/mongodb.dart';
import 'package:http_methods_poc/operations/display.dart';
import 'package:http_methods_poc/operations/insert.dart';

import 'operations/update.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Update(),
    );
  }
}


