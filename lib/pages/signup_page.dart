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

  late String _email;
  late String _password;
  late String _name;
  late String _surname;

  bool _passwordVisibility = true;
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
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Casher())
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E1F1),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        title: const Text('Регистрация'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/casher.png", width: 350, height: 100,),
            SizedBox(
              child: TextFormField(
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2),
                  ),
                  prefixIcon: Icon(Icons.account_circle),
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
            const Padding(padding: EdgeInsets.only(top: 16)),
            SizedBox(
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.supervised_user_circle),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2),
                  ),
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
            const Padding(padding: EdgeInsets.only(top: 16)),
            SizedBox(
              child: TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2),
                  ),
                  hintText: 'Email',
                ),
                //keyboardType: TextInputType.emailAddress,
                style: _sizeText,
                onChanged: (text) {
                  _email = text;
                },
              ),
              width: 400,
            ),
            const Padding(padding: EdgeInsets.only(top: 16)),
            SizedBox(
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _passwordVisibility
                            ? Icons.visibility
                            : Icons.visibility_off
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisibility = !_passwordVisibility;
                      });
                    },
                  ),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2),
                  ),
                  hintText: 'Пароль',
                ),
                obscureText: _passwordVisibility,
                style: _sizeText,
                onChanged: (text) {
                  _password = text;
                },
              ),
              width: 400,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.login),
                label: const Text('Зарегистрироваться'),
                onPressed: submit,
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 15),
                  primary: Colors.deepPurpleAccent,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  minimumSize: const Size(100, 50)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}