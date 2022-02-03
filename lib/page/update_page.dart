


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdatePage extends StatefulWidget {
  final String id;
  const UpdatePage({Key? key, required this.id}) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final _formKey = GlobalKey<FormState>();

  CollectionReference students = FirebaseFirestore.instance.collection('students');

  Future<void> update(id, name, gender, email, address){
    return students
        .doc(id)
        .update({'name': name, 'gender':gender, 'email':email, 'address':address})
        .then((value) => print('user updated'))
        .catchError((error) => print('failed to update user $error'));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update'),),
      body: Form(
        key: _formKey,
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance.collection('students').doc(widget.id).get(),
          builder: (_, snapshot){
            if(snapshot.hasError){
              print('something wrong');
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }
            var data = snapshot.data?.data();
            var name = data?['name'];
            var gender = data?['gender'];
            var email = data?['email'];
            var address = data?['address'];
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      initialValue: name,
                      autofocus: false,
                      onChanged: (value) => name = value,
                      decoration: const InputDecoration(
                        labelText: 'Name: ',
                        labelStyle: TextStyle(fontSize: 20),
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15)
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      initialValue: gender,
                      autofocus: false,
                      onChanged: (value) => gender = value,
                      decoration: const InputDecoration(
                          labelText: 'Gender: ',
                          labelStyle: TextStyle(fontSize: 20),
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15)
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter gender';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      initialValue: email,
                      autofocus: false,
                      onChanged: (value) => email = value,
                      decoration: const InputDecoration(
                          labelText: 'Email: ',
                          labelStyle: TextStyle(fontSize: 20),
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15)
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      initialValue: address,
                      autofocus: false,
                      onChanged: (value) => address = value,
                      decoration: const InputDecoration(
                          labelText: 'Address: ',
                          labelStyle: TextStyle(fontSize: 20),
                          border: OutlineInputBorder(),
                          errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15)
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return 'Please enter address';
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        child: const Text('Update', style: TextStyle(fontSize: 18),),
                        onPressed: (){
                          if(_formKey.currentState?.validate() != null){
                            update(widget.id, name, gender, email, address);
                            Navigator.pop(context);
                          }
                        },
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
