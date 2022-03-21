import 'package:casher/pages/landing.dart';
import 'package:casher/pages/signup_page.dart';
import 'package:casher/pages/wallet_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _sizeText = const TextStyle(fontSize: 20, color: Colors.black);
  final _sizeTextWhite = const TextStyle(fontSize: 20, color: Colors.white);

  late String _email;
  late String _password;

  final formKey = GlobalKey<FormState>();

  void submit() {
    try {
      FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
      //isLoggedIn = true;
    } on FirebaseAuthException {
      debugPrintStack(label: "Sign In error");
    } finally {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const WalletPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/casher_logo.jpg", width: 350, height: 100,),
            SizedBox(
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                  helperText: 'Введите адрес электронной почты',
                ),
                keyboardType: TextInputType.emailAddress,
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
                  'Войти',
                  style: _sizeTextWhite,
                ),
                onPressed: submit,
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
                          builder: (context) => SignUpPage()
                      ),
                    );
                  },
                  child: const Text(
                    'Зарегистрируйтесь!',
                    style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}