import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/auth/auth_screen.dart';
import 'package:todo_app/screens/home.dart';
import "package:firebase_core/firebase_core.dart";

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(stream:FirebaseAuth.instance.authStateChanges(),builder: (context ,usersnapshot){
        if(usersnapshot.hasData){
          return Home();
        }
        else
          return authscrren();
      },),
      debugShowCheckedModeBanner:false ,
       theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightGreenAccent,
      ),


    );
  }
}
