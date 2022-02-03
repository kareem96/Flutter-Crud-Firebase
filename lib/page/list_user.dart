


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase/page/update_page.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final Stream<QuerySnapshot> studentStream = FirebaseFirestore.instance.collection('students').snapshots();

  CollectionReference students = FirebaseFirestore.instance.collection('students');
  Future<void>deleteUser(id) {
    return students
        .doc(id)
        .delete()
        .then((value) => print('deleted user'))
        .catchError((error) => print('Failed to delete user: $error'));
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: studentStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasError){
          print('Something error');
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        final List storedocs = [];
        snapshot.data?.docs.map((DocumentSnapshot document) {
          Map a = document.data() as Map<String, dynamic>;
          storedocs.add(a);
          a['id'] = document.id;
        }).toList();
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Table(
              border: TableBorder.all(),
              columnWidths: const <int, TableColumnWidth>{
                1: FixedColumnWidth(140)
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Container(
                        color: Colors.indigo,
                        child: const Center(
                          child: Text('name', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        color: Colors.indigo,
                        child: const Center(
                          child: Text('email', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Container(
                        color: Colors.indigo,
                        child: const Center(
                          child: Text('action', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                  ]
                ),
                for(var i = 0; i < storedocs.length; i++) ...[
                  TableRow(
                    children: [
                      TableCell(
                        child: Center(
                            child: Text(storedocs[i]['name'], style: TextStyle(fontSize: 18),)
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(storedocs[i]['email'], style: TextStyle(fontSize: 18),),
                        ),
                      ),
                      TableCell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePage(id: storedocs[i]['id'])));
                            }, icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () => deleteUser(storedocs[i]['id']),
                                icon: const Icon(Icons.delete, color: Colors.red,)
                            ),
                          ],
                        ),
                      ),
                    ]
                  )
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}
