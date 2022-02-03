


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  ///value
  var name = '';
  var gender = '';
  var email = '';
  var address = '';

  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    genderController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.dispose();
  }

  clearText(){
    nameController.clear();
    genderController.clear();
    emailController.clear();
    addressController.clear();
  }
  Widget notif(BuildContext context){
    return const ScaffoldMessenger(
        child: SnackBar(
          content: Text('Successfully add'),
          duration: Duration(seconds: 2),));
  }

  CollectionReference students = FirebaseFirestore.instance.collection('students');

  Future<void> adduser(){
    return students
        .add({'name':name, 'gender': gender, 'email': email, 'address':address,})
        .then((value) => print('Successfully add'))
        .catchError((error) => print('Failed to add user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add user'),),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: nameController,
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
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: genderController,
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
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: emailController,
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
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: addressController,
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
                      child: const Text('Added', style: TextStyle(fontSize: 18),),
                      onPressed: (){
                        if(_formKey.currentState?.validate() != null){
                          setState(() {
                            name = nameController.text;
                            gender = genderController.text;
                            email = emailController.text;
                            address = addressController.text;
                            adduser();
                            clearText();
                            notif(context);
                          });
                        }
                      },
                  ),
                  ElevatedButton(
                      child: const Text('Reset', style: TextStyle(fontSize: 18),),
                      onPressed: (){
                        clearText();
                      },
                    style: ElevatedButton.styleFrom(primary: Colors.redAccent),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
