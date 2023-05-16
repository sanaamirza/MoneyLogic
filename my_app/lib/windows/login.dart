import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/windows/home.dart';
import 'package:my_app/windows/register.dart';
//import 'package:flutter/rendering.dart';

class Login extends StatefulWidget {
  //const Login ({Key? key}) : super(key: key);
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
  //Login> createState() => LoginState();
}


class LoginState extends State<Login> {

//email and password 
final login_key = GlobalKey<FormState>();

//text editing controller
final TextEditingController emailController = new TextEditingController();
final TextEditingController passwordController = new TextEditingController();


//firebase
final firebase_authentication = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    //email
    final emailField = TextFormField(
      style: TextStyle(color: Colors.white),
      autofocus: false,
      controller: emailController,
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
        emailController.text = value!;
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
      controller: passwordController,
      obscureText: true,
      validator: (value){
        RegExp passwordFormat = new RegExp(r'^.{8,}$');
        if (value!.isEmpty){
          return ("Please enter your password");
        }
        if(!passwordFormat.hasMatch(value)){
          return("Passwords must be at least 8 characters");
        }
      },
      onSaved: (value) {
        passwordController.text = value!;
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
        hintText: "Password",
        hintStyle: TextStyle(color: Colors.white, ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
        //inputBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      )
    );

    //sign in button
    final signInButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signIn(emailController.text, passwordController.text);
          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
        },
        child: Text("Sign In", 
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20,
        color: Color.fromARGB(255, 45, 64, 89),
        fontWeight: FontWeight.bold),
        ),
      ),
    );


    return Scaffold(
      backgroundColor: Color.fromARGB(255, 45, 64, 89),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Color.fromARGB(255, 45, 64, 89),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                key: login_key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 200,
                      child: Image.asset("assets/Logo_Name.png", fit: BoxFit.contain)
                      ),
                    SizedBox(height: 10),
                    emailField,
                    SizedBox(height: 50),
                    passwordField, 
                    SizedBox(height: 50),
                    signInButton,
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Click here to ", style: TextStyle(color: Colors.white, fontSize: 15),),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Register()));
                          },
                          child: Text("Sign Up", 
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white))
                          )
                      ],
                    )
                    ]
                ),

              ),
            ),
          )
        )
      )
    );
  }

    //signing in
    void signIn(String email, String password) async {
      if(login_key.currentState!.validate()) {
        await firebase_authentication.signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
            Fluttertoast.showToast(msg: "Welcome"),
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()))
          }).catchError((error){
            Fluttertoast.showToast(msg: error!.message);
          });
      }
    }
  }

