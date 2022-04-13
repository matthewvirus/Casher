import 'package:flutter/material.dart';

class Operation {
  Operation({
    required this.id,
    required this.text,
    required this.value,
    required this.icon
  });

  int id;
  String text;
  double value;
  Icon icon;
}
late List<Operation> operations = <Operation>[];