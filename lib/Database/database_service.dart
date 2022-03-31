/*
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  DocumentReference docRef = FirebaseFirestore.instance.collection('users').doc(firebaseUser?.uid.toString());
  Future<void> _updateMoney() async {
    await docRef.update (
        {
          "cash": _cash,
          "card": _card,
          "other": _other,
          "food": _food,
          "clothes": _clothes,
          "supplies": _supplies
        }
    );
  }
  Future<void> _getInfo() async {
    await docRef.get().then((snapshot){
      setState(() {
        _cash = snapshot['cash'];
        _card = snapshot['card'];
        _other = snapshot['other'];
        _food = snapshot['food'];
        _clothes = snapshot['clothes'];
        _supplies = snapshot['supplies'];
      });
    });
  }
}*/
