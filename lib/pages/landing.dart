import 'package:casher/pages/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:casher/views/profile_view.dart';

bool isLoggedIn = false;

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoggedIn ? const ProfileView() : const RegisterPage();
  }
}