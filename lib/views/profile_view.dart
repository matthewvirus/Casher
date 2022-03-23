import 'package:casher/pages/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  final String _name = '';
  final String _surname = '';
  final String _email = '';

  void _logOut() async {
    await FirebaseAuth.instance.signOut()
      .then((value) {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegisterPage())
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 10)),
            Text('Имя $_name'),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Text('Фамилия $_surname'),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Text('E-mail $_email'),
            const Padding(padding: EdgeInsets.only(top: 10)),
            MaterialButton(
                onPressed: _logOut,
                color: Colors.redAccent,
                child: const Text('Выйти'),
            ),
          ],
        ),
      ),
    );
  }
}