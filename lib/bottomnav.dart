 import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:foodie/admin_login.dart';
 import 'home.dart';
 import 'profile.dart';
 import 'wallet.dart';
 import 'order.dart';
class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentTabIndex=0;

  late List<Widget> pages;
  late Widget currentPage;
  late Home homePage;
  late Profile profile;
  late Order order;
  late Wallet wallet;
  @override
  void initState(){
    homePage = Home();
    order=Order();
    wallet = Wallet();
    profile = Profile();

    pages=[homePage, order, wallet, profile];
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
         height: 55,
          backgroundColor: Color(0x5A0A2068),
          color: Colors.black,
          animationDuration: Duration(milliseconds: 500),
          onTap: (int index){
           setState(() {
             currentTabIndex = index;
           });
          },
          items: [Icon(Icons.home, color: Colors.white,),Icon(Icons.shopping_bag, color: Colors.white,),Icon(Icons.wallet, color: Colors.white,),Icon(Icons.person, color: Colors.white,)]),
      body: pages[currentTabIndex],
    );
  }
}
