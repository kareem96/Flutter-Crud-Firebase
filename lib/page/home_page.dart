

import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase/page/add_user.dart';

import 'list_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Flutter Firebase CRUD'),
            ElevatedButton(
                child: const Text('Add', style: TextStyle(fontSize: 20.0),),
                onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => AddPage()))
                },
              style: ElevatedButton.styleFrom(primary: Colors.redAccent),
            )
          ],
        ),
      ),
      body: ListPage(),
    );
  }
}
