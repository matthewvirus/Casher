import 'package:casher/pages/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUpPage extends StatefulWidget{
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>{
  final _sizeText = const TextStyle(fontSize: 20, color: Colors.black);
  final _sizeTextWhite = const TextStyle(fontSize: 20, color: Colors.white);

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() async{
    await users.add(
      {
        'name': _name,
        'surname': _surname
      }
    ).then((value) => print('User added!'));
  }

  late String _email;
  late String _password;
  late String _name;
  late String _surname;

  void submit() {
    //try {
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
      addUser();
    /*} catch (FirebaseAuthException) {
      debugPrintStack(label: "Sign Up Error");
    }
    finally {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RegisterPage())
      );
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Регистрация'),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
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
                color: Colors.redAccent,
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