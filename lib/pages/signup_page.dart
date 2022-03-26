import 'package:casher/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/auth.dart';

class SignUpPage extends StatefulWidget{
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

var firebaseUser = FirebaseAuth.instance.currentUser;

class _SignUpPageState extends State<SignUpPage>{
  final _sizeText = const TextStyle(fontSize: 20, color: Colors.black);
  final _sizeTextWhite = const TextStyle(fontSize: 20, color: Colors.white);
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> addUser() async{
    await users.doc(firebaseUser?.uid.toString()).set(
      {
        'name': _name,
        'surname': _surname,
        'email': _email,
        'cash': 0,
        'card': 0,
        'uid': firebaseUser?.uid.toString()
      }
    );
  }

  late String _email;
  late String _password;
  late String _name;
  late String _surname;

  void submit() async {
    await AuthService().signUpWithEmailAndPassword(_email, _password);
    if (!_email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Row(
                children: const <Widget>[
                  Padding(padding: EdgeInsets.only(left: 2)),
                  Icon(Icons.error, color: Colors.redAccent,),
                  Padding(padding: EdgeInsets.only(right: 5)),
                  Text('Неправильно введен e-mail!'),
                ],
              )
          )
      );
    }
    else {
      addUser();
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Casher()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Регистрация'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Имя',
                ),
                keyboardType: TextInputType.name,
                style: _sizeText,
                onChanged: (text) {
                  _name = text;
                },
              ),
              width: 400,
            ),
            SizedBox(
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Фамилия',
                ),
                keyboardType: TextInputType.name,
                style: _sizeText,
                onChanged: (text) {
                  _surname = text;
                },
              ),
              width: 400,
            ),
            SizedBox(
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                  helperText: 'Введите адрес электронной почты',
                ),
                //keyboardType: TextInputType.emailAddress,
                style: _sizeText,
                onChanged: (text) {
                  _email = text;
                },
              ),
              width: 400,
            ),
            SizedBox(
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Пароль',
                  helperText: 'Введите пароль',
                ),
                obscureText: true,
                style: _sizeText,
                onChanged: (text) {
                  _password = text;
                },
              ),
              width: 400,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: MaterialButton(
                color: Colors.deepPurpleAccent,
                height: 50,
                minWidth: 150,
                child: Text(
                  'Зарегистрироваться',
                  style: _sizeTextWhite,
                ),
                onPressed: submit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}