import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'home.dart';

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {

  final auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState(){
    user = auth.currentUser!;
    user.sendEmailVerification();
    Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
     });
    super.initState();
  }


  @override
  void dispose(){
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/Logo_Name.png", fit: BoxFit.cover, height: 58,),
        backgroundColor: Color.fromARGB(255, 45, 64, 89),
      ),
     body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            SizedBox(height:15),
            Text("Verify Email Address", style: TextStyle(
              fontSize: 30, 
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 45, 64, 89))),
            SizedBox(height: 25),
           Center(
            child: Text("Follow the link in the email sent to verify your account",
            style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 45, 64, 89),)),
            )
            ])),

            ));
  }

  Future<void> checkEmailVerified() async{
      user = auth.currentUser!;
      await user.reload();
      if(user.emailVerified){
        timer.cancel();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
      }

  }
}