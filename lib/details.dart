import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodie/database.dart';
import 'package:foodie/shared_pref.dart';

class Details extends StatefulWidget {
  String image,name,detail,price;
  Details({required this.detail, required this.image, required this.name, required this.price});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int count = 0;
  //int price = 250;
  String? id;
  int total=0;

  getthesharedpref() async{
    id=await SharedPreferenceHelper().getUserId();
    setState(() {

    });
  }

  ontheload() async{
    await getthesharedpref();
    setState(() {

    });
  }

  @override
  void initState(){
    super.initState();
    ontheload();
    total=int.parse(widget.price);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        margin: EdgeInsets.only(),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                  child: Image.network(
                    widget.image,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Icon(Icons.verified, color: Colors.green),
                    Text(
                      '  Bestseller',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Poetsen One',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      widget.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Poetsen One',
                      ),
                    ),
                    SizedBox(
                      width: 65,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (count > 0) {
                            count--;
                            total=total-int.parse(widget.price);
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.remove,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Text(
                      '$count',
                      style: TextStyle(color: Colors.grey,fontSize: 17),
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    GestureDetector(
                      onTap: () {
                        count++;
                        total=total+int.parse(widget.price);
                        setState(() {

                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      '₹ '+widget.price,
                      style: TextStyle(
                        fontFamily: 'Poetsen One',
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Icon(
                      Icons.discount,
                      color: Colors.green,
                    ),
                    Text(
                      ' 20% OFF USE TRYNEW',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontFamily: 'Poetsen One',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.green,
                    ),
                    Text(
                      ' 4.0(283)',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Poetsen One',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    widget.detail,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontFamily: 'Poetsen One',
                    ),
                    maxLines: null, // Allows the text to wrap
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 12,
                    ),
                    Text('Delivery Time', style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: 'Poetsen One'),),
                    SizedBox(width: 40,),
                    Icon(Icons.alarm, color: Colors.white,size: 22,),
                    Text(' 30min',style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: 'Poetsen One'),)
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 55),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('  Total Price',style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Poetsen One'),),
                          Text('₹'+total.toString(),style: TextStyle(color: Colors.white, fontSize: 22, fontFamily: 'Poetsen One'),)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: GestureDetector(
                          onTap: () async{
                            Map<String,dynamic> addFoodtoCart= {
                              "Name": widget.name,
                              "Quantity": count.toString(),
                              "Total":total.toString(),
                              "Image":widget.image
                            };
                            await DatabaseMethods().addFoodToCart(addFoodtoCart, id!);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Color(0x5A0A2068),
                                content: Text(
                                  "Food Added to Cart",
                                  style: TextStyle(fontSize: 18),
                                )));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width/2,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text('Add to Cart',
                                  style: TextStyle(
                                      fontFamily: 'Poetsen One',
                                    fontSize: 20,
                                    color: Colors.black
                                  ),),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(Icons.shopping_cart,),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 16.0,
              left: 16.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
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
