import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase/page/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot){
        if(snapshot.hasError){
          print('something error');
        }
        if(snapshot.connectionState == ConnectionState.done){
          return MaterialApp(
            title: 'Flutter Firebase CRUD',
            theme: ThemeData(
              primarySwatch: Colors.indigo
            ),
            debugShowCheckedModeBanner: false,
            home: HomePage(),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

