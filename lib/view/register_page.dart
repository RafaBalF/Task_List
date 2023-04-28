// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  String email = '';
  String senha = '';

  void register(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      try {
        await auth.createUserWithEmailAndPassword(
            email: email, password: senha);

        Navigator.of(context).pushNamed('/b');
      } catch (e) {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text('Atenção'),
              content: Text('Cadastro Invalido'),
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Page'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Login',
                ),
                onSaved: (value) => email = value!,
              ),
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Senha',
                ),
                onSaved: (value) => senha = value!,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => register(context),
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
