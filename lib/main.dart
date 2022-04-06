import 'package:casher/services/auth.dart';
import 'package:casher/services/auth_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:casher/navigation/bottom_bar.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDl9ab7BwMfQVb73oxJO3Dscr71H_sLtPQ",
        appId: "1:127398713356:android:c46fab9f3a2cac771fb629",
        messagingSenderId: "127398713356",
        projectId: "casher-58d19"
    ),
  );
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
          home: Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: const Text('Casher', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
              centerTitle: true,
              backgroundColor: Colors.white,
              foregroundColor: Colors.deepPurpleAccent,
            ),
            body: const BottomNavBar(),
          )
      ),
    );
  }
}