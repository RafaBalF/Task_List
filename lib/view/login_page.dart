// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  String email = '';
  String senha = '';

  var formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  void login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      try {
        await auth.signInWithEmailAndPassword(email: email, password: senha);

        Navigator.of(context).pushNamed('/b');
      } catch (e) {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text('Atenção'),
              content: Text('Login Invalido'),
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
        title: Text('Login Page'),
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
              onPressed: () => login(context),
              child: Text('Entrar'),
            ),
            SizedBox(
              height: 3,
            ),
            TextButton(
                onPressed: () => Navigator.of(context).pushNamed('/d'),
                child: Text('Registrar-se'))
          ],
        ),
      ),
    );
  }
}
