// import 'dart:js_interop';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodie/signup.dart';

class Forgot extends StatefulWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  State<Forgot> createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  TextEditingController mail=new TextEditingController();
  String email="";
  final _formkey = GlobalKey<FormState>();
  resetPassword() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.white, content: Text("Password Reset Email has been sent !!",style: TextStyle(
        color: Colors.black,fontSize: 18
      ),)));
    }on FirebaseAuthException catch(e){
      if(e.code=="user-not-found"){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.white,content: Text("No user for that email", style: TextStyle(color: Colors.black,fontSize: 18),)));
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: Text(
                "Password Recovery",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontFamily: 'Poetsen One',
                ),
              ),
            ),
            SizedBox(height: 10.0,),
            Text("Enter Your Email", style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),
            Expanded(child: Form(
              key: _formkey,
              child: Padding(
                padding: EdgeInsets.only(left: 14, right: 14),
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(30),

                      ),
                      child: TextFormField(
                        controller: mail,
                        validator: (value){
                          if(value==null||value.isEmpty){
                            return 'Please Enter Email';
                          }
                          return null;
                        },
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: TextStyle(fontSize: 18, color: Colors.white),
                          prefixIcon: Icon(Icons.person, color: Colors.white ,size:30.0,),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: (){
                        if(_formkey.currentState!.validate()){
                          setState(() {
                            email= mail.text;
                          });
                          resetPassword();
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 2),
                        child: Container(
                          width: 140,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text("Send Email", style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Text("Don't have an account?", style: TextStyle( fontSize: 18, color: Colors.white),),
                        GestureDetector(onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                        },child: Text("Create", style: TextStyle( fontSize: 20, color: Color.fromARGB(
                            225, 165, 110, 6),fontWeight: FontWeight.w500),)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            ),

          ],
        ),
      ),
    );
  }
}
