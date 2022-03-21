import 'package:casher/pages/landing.dart';
import 'package:casher/pages/signin_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LandingPage()
    );
  }
}