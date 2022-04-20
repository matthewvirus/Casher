import 'package:casher/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../navigation/bottom_bar.dart';
import '../services/auth_user.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthUser? user = Provider.of<AuthUser?>(context);
    bool isLoggedIn = user != null;

    return isLoggedIn ? Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Casher', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurpleAccent,
      ),
      body: const BottomNavBar(),
    ) : const RegisterPage();
  }
}