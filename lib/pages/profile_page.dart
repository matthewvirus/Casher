import 'package:casher/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/signup_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const _profileTextStyle = TextStyle(fontSize: 20, color: Colors.black);

  late String _name;
  late String _surname;
  late String _email;

  bool _isLoading = false;

  DocumentReference docRef = FirebaseFirestore.instance.collection('users').doc(firebaseUser?.uid.toString());

  Future _getInfo() async{
    setState(() {
      _isLoading = true;
    });
    await docRef.get().then((snapshot) {
      setState(() {
        _name = snapshot['name'];
        _surname = snapshot['surname'];
        _email = snapshot['email'];
      });
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  void _logOut() async {
    await FirebaseAuth.instance.signOut()
        .then((value) {
      Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => const Casher())
      );
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFE7E1F1),
        body: buildItems()
    );
  }

  Widget circularBar() {
    return const Center(
      child: CircularProgressIndicator(color: Colors.black54),
    );
  }

  Widget buildItems() => Center(
    child: _isLoading? circularBar(): Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Имя: $_name', style: _profileTextStyle,),
        const Padding(padding: EdgeInsets.only(top: 5)),
        Text('Фамилия: $_surname', style: _profileTextStyle,),
        const Padding(padding: EdgeInsets.only(top: 5)),
        Text('Почта: $_email', style: _profileTextStyle,),
        const Padding(padding: EdgeInsets.only(top: 5)),
        ElevatedButton.icon(
          icon: const Icon(CupertinoIcons.square_arrow_left),
          label: const Text('Выйти'),
          onPressed: _logOut,
          style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 15),
              primary: Colors.deepPurpleAccent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              minimumSize: const Size(100, 50)
          ),
        ),
      ],
    ),
  );
}