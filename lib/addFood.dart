

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/database.dart';
import 'package:foodie/widget_support.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddFood extends StatefulWidget {
  const AddFood({Key? key}) : super(key: key);

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final List<String> items = [
    'Chinese',
    'Pizza',
    'Burger',
    'Momos',
    'Biryani',
    'Rolls',
    'Dosa',
    'Beverages',
    'Salad',
    'Cake',
    'Ice-cream'
  ];

  String? value;
  TextEditingController useritem = new TextEditingController();
  TextEditingController itemPrice = new TextEditingController();
  TextEditingController itemDetail = new TextEditingController();
  final ImagePicker _picker=ImagePicker();
  File? selectedImage;
  
  Future getImage() async{
    var image =await _picker.pickImage(source: ImageSource.gallery);
    selectedImage= File(image!.path);
    setState(() {
      
    });
  }
  uploadItem() async{
    if(selectedImage!=null && useritem.text!="" && itemPrice.text!="" && itemDetail.text!=""){
      String addId= randomAlphaNumeric(10);
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child("blogImages").child(addId);
      final UploadTask task= firebaseStorageRef.putFile(selectedImage!);
      var downloadUrl = await(await task).ref.getDownloadURL();

      Map<String, dynamic> addItem = {
        "Image" : downloadUrl,
        "Name" : useritem.text,
        "Price" : itemPrice.text,
        "Detail" : itemDetail.text
      };
      await DatabaseMethods().addFoodItem(addItem, value!).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Color(0x5A0A2068),
            content: Text(
              "Food Item has been added Successfully.",
              style: TextStyle(fontSize: 18),
            )));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.black,
            )),
        centerTitle: true,
        title: Text(
          "Add Item",
          style: TextStyle(fontSize: 18, fontFamily: 'Poetsen One'),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin:
              EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upload the Item Picture",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Poetsen One",
                    fontSize: 24,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 20,
              ),
              selectedImage==null ? GestureDetector(
                onTap: (){
                  getImage();
                },
                child: Center(
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ):Center(
                child: Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        selectedImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text("Item Name",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'Poetsen One')),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: useritem,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Item Name...",
                      hintStyle: TextStyle(color: Colors.black)),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Item Price",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: 'Poetsen One'),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: itemPrice,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Item Price...",
                      hintStyle: TextStyle(color: Colors.black)),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Text("Item Detail",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'Poetsen One')),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  maxLines: 6,
                  controller: itemDetail,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Item Detail...",
                      hintStyle: TextStyle(color: Colors.black)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Select Category",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontFamily: 'Poetsen One')),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            )))
                        .toList(),
                    onChanged: (value) => setState(() {
                      this.value = value;
                    }),
                    dropdownColor: Colors.white,
                    hint: Text(
                      "Select Category",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          ),
                    ),
                    iconSize: 36,
                    icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                    value: value,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: (){
                   uploadItem();
                },
                child: Center(
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 150,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
