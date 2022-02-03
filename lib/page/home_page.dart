

import 'package:flutter/material.dart';

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
                onPressed: () => {

                },
              style: ElevatedButton.styleFrom(primary: Colors.redAccent),
            )
          ],
        ),
      ),
    );
  }
}
