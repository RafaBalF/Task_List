// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TaskCreatePage extends StatelessWidget {
  String name = '';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  final createTask = TextEditingController();

  var formKey = GlobalKey<FormState>();

  void salvar(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      firestore.collection('Tasks').add({'name': name, 'finished': false, 'uid': auth.currentUser!.uid});

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Create Page'),
      ),
      body: Form(
        key: formKey,
        child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.all(15),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              keyboardType: TextInputType.number,
              controller: createTask,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Tarefa',
              ),
              onSaved: (value) => name = value!,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Campo obrigatório.";
                }
                return null;
              },
            ),
          ),
          ElevatedButton(
            child: Text('Salvar'),
            onPressed: () => salvar(context),
          ),
        ]),
      ),
    );
  }
}
