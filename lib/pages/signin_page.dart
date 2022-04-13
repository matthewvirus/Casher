import 'package:casher/main.dart';
import 'package:casher/pages/signup_page.dart';
import 'package:casher/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _sizeText = const TextStyle(fontSize: 20, color: Colors.black);

  late String _email;
  late String _password;

  bool _passwordVisibility = true;

  final formKey = GlobalKey<FormState>();

  void _signIn() async {
    try{
      await AuthService().signInWithEmailAndPassword(_email, _password);
    } on FirebaseException {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Row(
                children: const <Widget>[
                  Padding(padding: EdgeInsets.only(left: 2)),
                  Icon(Icons.error, color: Colors.redAccent,),
                  Padding(padding: EdgeInsets.only(right: 5)),
                  Text('Something went wrong'),
                ],
              )
          )
      );
    }
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
    // ignore: unrelated_type_equality_checks
    else if (_password.isEmpty || _password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Row(
                children: const <Widget>[
                  Padding(padding: EdgeInsets.only(left: 2)),
                  Icon(Icons.error, color: Colors.redAccent,),
                  Padding(padding: EdgeInsets.only(right: 5)),
                  Text('Неверный пароль'),
                ],
              )
          )
      );
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Casher()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: const Color(0xFFE7E1F1),
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
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
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
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2),
                    ),
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
                    prefixIcon: const Icon(Icons.lock),
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
                  label: const Text('Войти'),
                  onPressed: _signIn,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Не зарегистрированы? ',
                    style: TextStyle(fontSize: 15, color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()
                        ),
                      );
                    },
                    child: const Text(
                      'Зарегистрируйтесь!',
                      style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}