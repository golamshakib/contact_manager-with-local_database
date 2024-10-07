
import 'package:flutter/material.dart';

enum Gender {
  Male, Female
}

showMsg(BuildContext context, String msg) {
  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(msg)));
}