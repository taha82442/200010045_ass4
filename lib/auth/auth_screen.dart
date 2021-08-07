import 'package:flutter/material.dart';
import 'package:todo_app/auth/authform.dart';

class authscrren extends StatefulWidget {
  const authscrren({Key? key}) : super(key: key);

  @override
  _authscrrenState createState() => _authscrrenState();
}

class _authscrrenState extends State<authscrren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Authentication"),
      ),
      body: authform(),
    );
  }
}
