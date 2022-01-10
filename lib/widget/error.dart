import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SnackBar(content: Container(
      child: Text("Something went wrong!"),
    ));
  }

}