import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/items/users.dart';
import 'package:my_app/windows/chartView.dart';
import 'package:my_app/windows/login.dart';
import 'package:my_app/windows/newsPage.dart';
import 'package:my_app/windows/salaryCalc.dart';
import 'package:my_app/windows/savingsView.dart';
import 'package:my_app/windows/subscriptionsView.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  User? user = FirebaseAuth.instance.currentUser;
  UserGroup signedInUser = UserGroup();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection("users").doc(user!.uid).get().then((value){
      this.signedInUser = UserGroup.fromMap(value.data());
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    //log out button
    final logOutButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Color.fromARGB(255, 45, 64, 89),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          logOut(context);
        },
        child: Text("Log Out", 
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold),
        ),
      ),
    );

    //expenses button
    final chartViewButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      //color: Color.fromARGB(255, 255, 213, 96),
      color: Color.fromARGB(255, 45, 64, 89),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        //minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ChartView()));
        },
        child: Container(
            width: 400,
            height: 130,
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bar_chart, color: Colors.black, size: 30),
              SizedBox(width: 10),
              Text(
                "Expenses",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ]
              ),
            
        ),
      ),
    );

    
    //news button
    final newsPageButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Color.fromARGB(255, 45, 64, 89),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        //minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => NewsPage()));
        },
        child: SizedBox(
          width: 70, 
          height: 70,
          child: Center(
          child: Text("News Page", 
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold),
        ),
      ),
    )));

    //salary calculator button
    final salaryCalcButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Color.fromARGB(255, 45, 64, 89),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SalaryCalc()));
        },
        child: SizedBox(
          width: 110, 
          height: 90,
          child: Center(
          child: Text("Salary Calculator", 
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold),
        ),
      ),
    )));
    
    //savings button
    final savingsButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      //color: Color.fromARGB(255, 255, 213, 96),
      color: Color.fromARGB(255, 45, 64, 89),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        //minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Savings()));
        },
        child: Container(
            width: 400,
            height: 130,
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.attach_money, color: Colors.black, size: 30),
              SizedBox(width: 10),
              Text(
                "Savings",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  ),
                ),
              ]
              ),
            
        ),
      ),
    );

    //subscriptions button
    final subscriptionsButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Color.fromARGB(255, 45, 64, 89),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        //minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Subscriptions()));
        },
        child: SizedBox(
          width: 110, 
          height: 90,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.checklist, color: Colors.white, size: 30),
              SizedBox(width: 5),
              Text(
                "Subscriptions",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ]
      ),
    ),
      ),
    );

    
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/Logo_Name.png", fit: BoxFit.cover, height: 58,),
        backgroundColor: Color.fromARGB(255, 45, 64, 89),
        ),
      body: Center(
        child: Padding(padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, 
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(" Welcome Back ${signedInUser.firstName} ${signedInUser.lastName}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              
              
              
              Stack(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    padding: EdgeInsets.only(top:400),
                    child: subscriptionsButton,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top:30),
                    child: chartViewButton,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top:400),
                    child: salaryCalcButton
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top:200),
                    child: savingsButton
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(top: 600),
                    child: logOutButton,
                  )
                
                  
                ],
              )

              //SizedBox(height: 100,),
             // chartViewButton,
              //SizedBox(height: 100,),
              //newsPageButton,
              //SizedBox(height: 200,),
             // logOutButton
            ],)),)

    );
  }

  Future<void> logOut(BuildContext context) async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }
}