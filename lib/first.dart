import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/admin_login.dart';
import 'package:foodie/onboard.dart';

class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'images/first2.jpg',
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 160,
            left: 180,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(16.0),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Onboard()));
                    },
                    child: Container(

                      decoration: BoxDecoration(

                        border: Border.all(color: Colors.black, width: 3),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black// Circular border
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'images/user.jpg',
                          width: 150, // Adjust the width and height as needed
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text('USER', style: TextStyle(color: Colors.white,fontFamily: 'Poetsen One',fontSize: 22,fontWeight: FontWeight.bold)),

    ]
              ),
          ),
          ),

          Positioned(
            top: 160,
            //left: 10,
            right: 190,
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminLogin()));
              },
              child: Container(
                padding: EdgeInsets.all(15.0),

                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(

                        decoration: BoxDecoration(

                            border: Border.all(color: Colors.black, width: 3),
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black// Circular border
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'images/admin.jpg',
                            width: 150, // Adjust the width and height as needed
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text('ADMIN', style: TextStyle(color: Colors.white,fontFamily: 'Poetsen One',fontSize: 22,fontWeight: FontWeight.bold)),

                    ]
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
