import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodie/database.dart';
import 'package:foodie/shared_pref.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Wallet extends StatefulWidget {
  const Wallet({Key? key}) : super(key: key);

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  late Razorpay _razorpay;
  TextEditingController amtControl = new TextEditingController();
  int _amount = 0; // Class variable to store the amount

  void openCheckout(int amount) async {
    amount = amount * 100; // converting to paise
    _amount = amount; // Store the original amount
    var options = {
      'key': 'rzp_test_lZ7DMH7bU0JLh1',
      'amount': amount,
      'name': 'FOODIE',
      'prefill': {'contact': '9219586501', 'email': 'pragatiagrahari42@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error : $e');
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(msg: 'Amount Added Successfully: ${response.paymentId!}', toastLength: Toast.LENGTH_SHORT);
    int add = int.parse(wallet!) + (_amount ~/ 100); // Use _amount here, converting back from paise to rupees
    await DatabaseMethods().UpdateUserwallet(id!, add.toString());
    setState(() {
      wallet = add.toString(); // Update the wallet amount in the state
    });
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: 'Payment Failed: ${response.message!}', toastLength: Toast.LENGTH_SHORT);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: 'External Wallet: ${response.walletName!}', toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    ontheload();
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  String? wallet, id;
  getthesharedpref() async {
    wallet = await SharedPreferenceHelper().getUserWallet();
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: wallet == null ? CircularProgressIndicator() : Container(
        margin: EdgeInsets.only(top: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2.0,
              child: Container(
                color: Color(0xFF008080),
                padding: EdgeInsets.only(top: 17, bottom: 17),
                child: Center(
                  child: Text(
                    "Wallet",
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Poetsen One',
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Row(
                children: [
                  Image.asset(
                    "images/0d524c72632e3e2991ff487171934626.jpg",
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 40.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Wallet",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "₹" + wallet!,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "Add Money",
                style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: 'Poetsen One'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => openCheckout(100),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Text(
                      "₹ 100",
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => openCheckout(500),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Text(
                      "₹ 500",
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => openCheckout(1000),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Text(
                      "₹ 1000",
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => openCheckout(2000),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Text(
                      "₹ 2000",
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 27),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: amtControl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter amount',
                  hintStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.symmetric(vertical: 12),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xFF008080),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    int amount = int.tryParse(amtControl.text) ?? 0;
                    if (amount > 0) {
                      openCheckout(amount);
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Please enter a valid amount', toastLength: Toast.LENGTH_SHORT);
                    }
                  },
                  child: Text(
                    "Add Money",
                    style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: 'Poetsen One'),
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
