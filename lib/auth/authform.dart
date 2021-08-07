//import 'dart:html';
import "package:firebase_core/firebase_core.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class authform extends StatefulWidget {
  const authform({Key? key}) : super(key: key);

  @override
  _authformState createState() => _authformState();
}

class _authformState extends State<authform> {
  final fkey = GlobalKey<FormState>();
  var email = '';
  var password = '';
  var uname = " ";
  bool isLogin = false;


  startauth(){

final validity=fkey.currentState!.validate();
FocusScope.of(context).unfocus();
if(validity){
  fkey.currentState!.save();
  submitform(email, password, uname);
}
  }
 submitform(String email, String password , String Username)async{
    final auth=FirebaseAuth.instance;
    UserCredential authResult;
     try{
       if(isLogin){
         authResult=await auth.signInWithEmailAndPassword(email: email, password: password);
       }
       else{
         authResult = await auth.createUserWithEmailAndPassword(email: email, password: password);
         String uid =authResult.user!.uid;

         await FirebaseFirestore.instance.collection('users').doc(uid).set({
           "username":uname,
           'email': email,
         });

       }
    }
    catch(err){
       print(err);
    }


 }



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Container(
            child: Form(
              key: fkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return "Incorrect Email Address";
                      }
                      return null;
                    },
                    onSaved: (value) => email = value!,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10),
                          borderSide: new BorderSide(),
                        ),
                        labelText: "Enter Email",
                        labelStyle: GoogleFonts.roboto()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Incorrect Password";
                      }
                      return null;
                    },
                    onSaved: (value) => password = value!,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10),
                          borderSide: new BorderSide(),
                        ),
                        labelText: "Enter Password",
                        labelStyle: GoogleFonts.roboto()),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (!isLogin)
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('uname'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Incorrect Username";
                        }
                        return null;
                      },
                      onSaved: (value) => uname = value!,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10),
                            borderSide: new BorderSide(),
                          ),
                          labelText: "Enter Username",
                          labelStyle: GoogleFonts.roboto()),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 70,
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: RaisedButton(
                        child: isLogin
                            ? Text(
                                "Login",
                                style: GoogleFonts.roboto(),
                              )
                            : Text("Sign up", style: GoogleFonts.roboto()),
                        color: Theme.of(context).primaryColor,
                        onPressed: startauth,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: isLogin
                          ? Text("Not A member ?")
                          : Text("Already a Member ?"),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


