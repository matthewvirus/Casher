import 'package:casher/main.dart';
import 'package:casher/pages/signup_page.dart';
import 'package:casher/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _sizeText = const TextStyle(fontSize: 20, color: Colors.black);

  late String _email = '';
  late String _password = '';

  String pattern = r'\w+@\w+\.\w+';
  bool _passwordVisibility = true;

  void _signIn() async {
    RegExp regexp = RegExp(pattern);
    await AuthService().signInWithEmailAndPassword(_email, _password);
    if (_email.isEmpty || _password.isEmpty) {
      showErrorSnackBar('Поля не должны быть пустыми!');
    }
    else if (!regexp.hasMatch(_email)) {
      showErrorSnackBar('Неправильно введен e-mail!');
    }
    else if (_password.isEmpty || _password.length < 6) {
      showErrorSnackBar('Неправильно введен пароль!');
    } else {
      if (errorMessage.isEmpty) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const Casher()));
        errorMessage = '';
      }
      else {
        showErrorSnackBar(errorMessage);
        errorMessage = '';
      }
    }
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showErrorSnackBar(String text) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: SizedBox(
          height: 35,
          child: Row(
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(left: 2)),
              const Icon(Icons.error, color: Colors.redAccent,),
              const Padding(padding: EdgeInsets.only(right: 5)),
              Expanded(
                  child: Text(
                      text,
                      maxLines: 4,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.justify
                  )
              ),
            ],
          ),
        )
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        backgroundColor: const Color(0xFFE7E1F1),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset("assets/images/casher.png", width: 350, height: 100),
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
                      prefixIcon: Icon(CupertinoIcons.mail_solid),
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
                                ? CupertinoIcons.eye_fill
                                : CupertinoIcons.eye_slash_fill
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisibility = !_passwordVisibility;
                          });
                        },
                      ),
                      prefixIcon: const Icon(CupertinoIcons.lock_fill),
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
                    icon: const Icon(CupertinoIcons.square_arrow_right),
                    label: const Text('Войти'),
                    onPressed: _signIn,
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 15),
                      primary: Colors.deepPurpleAccent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      minimumSize: const Size(400, 50)
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
      ),
    );
  }
}