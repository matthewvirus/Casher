import 'package:flutter/material.dart';

class Operation {
  Operation({required this.text, required this.value, required this.icon});

  String text;
  double value;
  Icon icon;
}
late List<Operation> operations = <Operation>[];