import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/items/users.dart';
import 'package:my_app/windows/home.dart';
import 'package:my_app/windows/verify.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  //registration form
  final _formKey = GlobalKey<FormState>();

  //auth 
  final firebase_authentication = FirebaseAuth.instance;

  //editing fields
  final firstNameEditingController = new TextEditingController();
  final lastNameEditingController = new TextEditingController();
  final emailAddressEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordNameEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    //first name
    final firstNameField = TextFormField(
      style: TextStyle(color: Colors.white),
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        RegExp passwordFormat = new RegExp(r'^.{3,}$');
        if (value!.isEmpty){
          return ("Please enter your first name");
        }
        if(!passwordFormat.hasMatch(value)){
          return("Names must be at least 3 characters");
        }
        return null;
      },
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color.fromARGB(255, 248, 214, 115), width: 3)),
        prefixIcon: Icon(Icons.account_circle_rounded, color: Color.fromARGB(255, 248, 214, 115)),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "First Name",
        hintStyle: TextStyle(color: Colors.white,),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        )
      )
    );


    //last name
    final lastNameField = TextFormField(
      style: TextStyle(color: Colors.white),
      autofocus: false,
      controller: lastNameEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        RegExp passwordFormat = new RegExp(r'^.{3,}$');
        if (value!.isEmpty){
          return ("Please enter your surname");
        }
        if(!passwordFormat.hasMatch(value)){
          return("Names must be at least 3 characters");
        }
      },
      onSaved: (value) {
        lastNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color.fromARGB(255, 248, 214, 115), width: 3)),
        prefixIcon: Icon(Icons.account_circle_rounded, color: Color.fromARGB(255, 248, 214, 115)),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Surname",
        hintStyle: TextStyle(color: Colors.white,),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        )
      )
    );


    //email address
    final emailAddressField = TextFormField(
      style: TextStyle(color: Colors.white),
      autofocus: false,
      controller: emailAddressEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        //ensure an email has been entered
        if(value!.isEmpty){
          return ("Please enter a valid email address");
        }
        //ensure email is valid
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
          return ("Please enter a valid email address");
        }
        return null;
      },
      onSaved: (value) {
        emailAddressEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color.fromARGB(255, 248, 214, 115), width: 3)),
        prefixIcon: Icon(Icons.mail, color: Color.fromARGB(255, 248, 214, 115)),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email Address",
        hintStyle: TextStyle(color: Colors.white,),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        )
      )
    );


    //password
    final passwordField = TextFormField(
      style: TextStyle(color: Colors.white),
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value){
        RegExp passwordFormat = new RegExp(r'^.{8,}$');
        if (value!.isEmpty){
          return ("Please enter your password");
        }
        if(!passwordFormat.hasMatch(value)){
          return("Invalid - Passwords must be at least 8 characters");
        }
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color.fromARGB(255, 248, 214, 115), width: 3)),
        prefixIcon: Icon(Icons.key_rounded, color: Color.fromARGB(255, 248, 214, 115)),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Password",
        hintStyle: TextStyle(color: Colors.white,),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        )
      )
    );


    //confirm password
    final confirmPasswordField = TextFormField(
      style: TextStyle(color: Colors.white),
      autofocus: false,
      controller: confirmPasswordNameEditingController,
      obscureText: true,
      validator: (value){
        if(confirmPasswordNameEditingController.text != passwordEditingController.text){
          return "Passwords do not match";
        }
        return null;
      },
      onSaved: (value) {
        confirmPasswordNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color.fromARGB(255, 248, 214, 115), width: 3)),
        prefixIcon: Icon(Icons.key_rounded, color: Color.fromARGB(255, 248, 214, 115)),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Confirm Password",
        hintStyle: TextStyle(color: Colors.white,),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        )
      )
    );


    //sign up button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailAddressEditingController.text, passwordEditingController.text);
        },
        child: Text("Sign Up", 
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20,
        color: Color.fromARGB(255, 45, 64, 89),
        fontWeight: FontWeight.bold),
        ),
      ),
    );


    //scaffold
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 45, 64, 89),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        //padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            //when pressing back button it takes back to login page
            Navigator.of(context).pop();
          },
        )
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Color.fromARGB(255, 45, 64, 89),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              //padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                      child: Image.asset("assets/Logo_Name.png", fit: BoxFit.contain)
                      ),
                    SizedBox(height: 40),
                    firstNameField,
                    SizedBox(height: 50),
                    lastNameField, 
                    SizedBox(height: 50),
                    emailAddressField, 
                    SizedBox(height: 50),
                    passwordField, 
                    SizedBox(height: 50),
                    confirmPasswordField, 
                    SizedBox(height: 50),
                    signUpButton, 
                    SizedBox(height: 50),
                    ]
                ),

              ),
            ),
          )
        )
      )
    );
  }

  //press sign up button functionality
  void signUp(String email, String password) async{
    if(_formKey.currentState!.validate()){
      await firebase_authentication.createUserWithEmailAndPassword(email: email, password: password)
      .then((value) => {
        postDataToFirestore()
      }).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }


  //sending data to firestore
  postDataToFirestore() async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = firebase_authentication.currentUser;
    UserGroup userGroup = UserGroup();

    userGroup.email = user!.email;
    userGroup.uid = user.uid;
    userGroup.firstName = firstNameEditingController.text;
    userGroup.lastName = lastNameEditingController.text;

    await firebaseFirestore.collection("users").doc(user.uid).set(userGroup.toMap());
    Fluttertoast.showToast(msg: "Account created!");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => Verify()),
        (route) => false);
  }
}
