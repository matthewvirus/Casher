import 'package:casher/main.dart';
import 'package:casher/pages/signup_page.dart';
import 'package:casher/services/auth.dart';
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

  void _signIn() async {
    await AuthService().signInWithEmailAndPassword(_email, _password);
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
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Casher()));
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
                color: Colors.deepPurpleAccent,
                height: 50,
                minWidth: 150,
                child: Text(
                  'Войти',
                  style: _sizeTextWhite,
                ),
                onPressed: _signIn,
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
    );
  }
}