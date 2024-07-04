

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodie/auth.dart';
import 'package:foodie/homeAdmin.dart';
import 'package:foodie/shared_pref.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

import 'database.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
   String? profile, name, email;
   final ImagePicker _picker=ImagePicker();
   File? selectedImage;
   String? value;
   Future getImage() async{
     var image =await _picker.pickImage(source: ImageSource.gallery);
     selectedImage= File(image!.path);
     setState(() {
        uploadItem();
     });
   }
   uploadItem() async{
     if(selectedImage!=null){
       String addId= randomAlphaNumeric(10);
       Reference firebaseStorageRef = FirebaseStorage.instance.ref().child("blogImages").child(addId);
       final UploadTask task= firebaseStorageRef.putFile(selectedImage!);
       var downloadUrl = await(await task).ref.getDownloadURL();

       await SharedPreferenceHelper().saveUserProfile(downloadUrl);
       setState(() {

       });


     }
   }

   getthesharedpref() async{
     profile = await SharedPreferenceHelper().getUserProfile();
     name = await SharedPreferenceHelper().getUserName();
     email = await SharedPreferenceHelper().getUserEmail();
     setState(() {

     });
   }

   onthisLoad() async{
     await getthesharedpref();
     setState(() {

     });
   }
   @override
   void initState(){
     onthisLoad();
     super.initState();
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF008080),
      body: name==null? CircularProgressIndicator(): Container(
        child: Column(
          children: [
            Stack(
            children:[
        Container(
        padding: EdgeInsets.only(top: 45, left: 20,right: 20),
        height: MediaQuery.of(context).size.height/4.3,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(MediaQuery.of(context).size.width, 105),
          ),
        ),
      ),
      Center(
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/6.5),
          child: Material(
            elevation: 6.0,
            borderRadius: BorderRadius.circular(60),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: selectedImage ==null?GestureDetector(onTap:(){
                getImage();
              } ,child: profile==null? Image.asset('images/user2.jpg',height: 120,width: 120,fit: BoxFit.cover,):Image.network(profile!,height: 120,width: 120,fit: BoxFit.cover,)
              ):Image.file(selectedImage!),

            ),
          ),
        ),
      ),
      Padding(padding: EdgeInsets.only(top: 80),child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name!,style: TextStyle(color: Colors.white,fontFamily: 'Poetsen One',fontSize: 25),),
        ],
      ),),

      ],
    ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 2.0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),

                  ),
                  child: Row(
                    children: [
                      Icon(Icons.person, color: Colors.black,),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name",style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),),
                          Text(name!,style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 2.0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),

                  ),
                  child: Row(
                    children: [
                      Icon(Icons.email, color: Colors.black,),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email",style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),),
                          Text(email!,style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Material(
                borderRadius: BorderRadius.circular(10),
                elevation: 2.0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),

                  ),
                  child: Row(
                    children: [
                      Icon(Icons.description, color: Colors.black,),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text("Terms and Condition",style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: (){
                AuthMethods().DeleteUser();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 2.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.black,),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Delete Account",style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: (){
                AuthMethods().SignOut();
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 2.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),

                    ),
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.black,),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text("LogOut",style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
    ]
    ),
      )
    );

  }
}
