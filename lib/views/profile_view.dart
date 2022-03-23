import 'package:casher/pages/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/landing.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

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
      body: Column(
        children: <Widget>[
          const Padding(padding: EdgeInsets.only(left: 10),),
          MaterialButton(
              onPressed: _logOut,
              color: Colors.redAccent,
              child: const Text('Выйти'),
          ),
        ],
      ),
    );
  }
}