import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:casher/pages/landing.dart';
import 'package:casher/services/auth.dart';
import 'package:casher/services/auth_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Casher());
}

class Casher extends StatelessWidget {
  const Casher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return StreamProvider<AuthUser?>.value(
      initialData: null,
      value: AuthService().currentUser,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Casher',
          theme: ThemeData(fontFamily: 'Raleway'),
          home: AnimatedSplashScreen(
            splash: Image.asset("assets/images/splash.jpg"),
            nextScreen: const LandingPage(),
          ),
      ),
    );
  }
}