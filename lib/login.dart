import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/forgot.dart';
import 'package:foodie/home.dart';
import 'package:foodie/signup.dart';
import 'package:foodie/widget_support.dart';

import 'bottomnav.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "";
  String password = "";

  final _formkey = GlobalKey<FormState>();

  TextEditingController userEmail = new TextEditingController();
  TextEditingController userPassword = new TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNav()));
    } on FirebaseAuthException catch (e) {
      print("Caught an exception: ${e.code}");
      String errorMessage = '';
      if (e.code == 'user-not-found') {
        errorMessage = "No User Found for that Email";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Wrong Password Provided by User";
      } else {
        errorMessage = "Please enter correct email and password.";
      }
      print("Error message to show: $errorMessage");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Color(0x5A0A2068),content: Text(errorMessage, style: TextStyle(fontSize: 18,color: Colors.white))));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                color: Colors.black,
              ),
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
                height: MediaQuery.of(context).size.height / 1.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0x5A3E5255), Color(0x5A0A2068)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Text(""),
              ),
              Container(
                margin: EdgeInsets.only(left: 25.0, right: 25, top: 12),
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                        'images/logo.png',
                        width: MediaQuery.of(context).size.width / 1.5,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 1.0,
                    ),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(20), // Apply borderRadius here
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2,
                        decoration: BoxDecoration(
                          color: Color(0x5A0A2068),
                          borderRadius: BorderRadius.circular(20), // Apply borderRadius here as well
                        ),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 30.0,
                              ),
                              Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 25,
                                  fontFamily: 'Poetsen One',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: userEmail,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Email';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Poetsen One',
                                      color: Colors.black45,
                                    ),
                                    prefixIcon: Icon(Icons.email, color: Colors.black45,),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  controller: userPassword,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Password';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Poetsen One',
                                      color: Colors.black45,
                                    ),
                                    prefixIcon: Icon(Icons.password, color: Colors.black45,),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,),
                              GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Forgot()));
                                },
                                child: Container(
                                  alignment: Alignment.topRight,
                                  child: Text("Forgot Password?  ", style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  )),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30, right: 30),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formkey.currentState!.validate()) {
                                      setState(() {
                                        email = userEmail.text;
                                        password = userPassword.text;
                                      });
                                      userLogin();
                                    }
                                  }, child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Center(child: Text("LOGIN", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),)),
                                ),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Color(0x5A0A2068)
                                  ),),
                              ),

                              // Add more widgets as needed
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 60,),
                    InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                        },
                        child: Text("Don't have an account? Sign Up", style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Poetsen One'),))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
