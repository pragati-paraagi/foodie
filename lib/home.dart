import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodie/database.dart';
import 'package:foodie/details.dart';
import 'package:foodie/widget_support.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _selectedCategory = '';
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _showMore = false;
  Stream? fooditemStream;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  ontheload() async {
    fooditemStream = await DatabaseMethods().getFoodItem("Pizza");
    print("Stream loaded: $fooditemStream");
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  Widget allItems() {
    return StreamBuilder(
      stream: fooditemStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          return Text('No items found');
        } else {
          return SizedBox(
            height: 600, // Adjust the height as needed
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: snapshot.data.docs.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                print("Document data: ${ds.data()}");
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Details(detail: ds["Detail"],name: ds["Name"],price: ds["Price"],image: ds["Image"],)));
                  },
                  child: buildVeganRollItem(ds["Image"], ds["Name"], ds["Detail"], '₹' + ds["Price"]),
                );
              },
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 70),
              Row(
                children: [
                  SizedBox(width: 20),
                  Text("Hello Pragati !!", style: Widget_support.boldTextFieldStyle()),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.shopping_cart, color: Colors.black, size: 28),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              SizedBox(height: 20),
              Text("Delicious Food", style: Widget_support.headTextFieldStyle()),
              Text("Ready to satisfy your cravings!!", style: Widget_support.lightTextFieldStyle()),
              SizedBox(height: 20),
              Container(
                height: 180,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryItem('images/n.png', 'Chinese','Chinese'),
                    _buildCategoryItem('images/pizza.png', 'Pizza','Pizza'),
                    _buildCategoryItem('images/burger.png', 'Burger','Burger'),
                    _buildCategoryItem('images/momo.png', 'Momos','Momos'),
                    _buildCategoryItem('images/biryani.png', 'Biryani','Biryani'),
                    _buildCategoryItem('images/roll.png', 'Rolls','Rolls'),
                    _buildCategoryItem('images/dosa.png', 'Dosa','Dosa'),
                    _buildCategoryItem('images/b.png', 'Beverages','Beverages'),
                    _buildCategoryItem('images/salad.png', 'Salad','Salad'),
                    _buildCategoryItem('images/cake.png', 'Cake','Cake'),
                    _buildCategoryItem('images/ice.png', 'Ice-cream','Ice-cream'),
                  ],
                ),
              ),
              Container(
                height: 130,
                width: double.infinity,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    _buildAdvertisementItem('images/add1.png'),
                    _buildAdvertisementItem('images/add2.png'),
                    _buildAdvertisementItem('images/add3.png'),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? Colors.white : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              SizedBox(height: 15),
              Text("Don't Miss Out on Today's Deals!", style: Widget_support.boldTextFieldStyle()),
              SizedBox(height: 15),
              _buildFoodItem('images/momos.png', "Wow! Momo", '4.5', '25-30 MINS', '₹ 300 FOR TWO', 'Tibetan, Healthy Food, Chinese, Asian'),
              SizedBox(height: 25),
              _showMore
                  ? Column(
                children: [
                  _buildFoodItem('images/bbq.png', "Barbeque Nation", '4.1', '40-45 MINS', '₹ 600 FOR TWO', 'North-Indian, Barbecue'),
                  SizedBox(height: 25),
                  _buildFoodItem('images/kfc.png', "KFC", '4.3', '30-35 MINS', '₹ 400 FOR TWO', 'Burgers, Fast Food, Rolls'),
                  SizedBox(height: 25),
                  _buildFoodItem('images/lunch.png', "LunchBox- Meals and Thalis", '4.4', '35-40 MINS', '₹ 200 FOR TWO', 'Biryani, North-Indian, Punjabi, Healthy Food'),
                  SizedBox(height: 25),
                  _buildFoodItem('images/lunch2.png', "Akash Family's Delight", '4.3', '30-35 MINS', '₹ 400 FOR TWO', 'North-Indian, South-Indian, Chinese, Thalis'),
                  SizedBox(height: 25),
                  _buildFoodItem('images/chhole.png', "Bhole Chature", '4.0', '25-30 MINS', '₹ 150 FOR TWO', 'North-Indian, Punjabi'),
                  SizedBox(height: 25),
                  _buildFoodItem('images/waffle.png', "The Belgian Waffle", '4.6', '20-25 MINS', '₹ 200 FOR TWO', 'Waffle, Ice-cream, Desserts'),
                  SizedBox(height: 25),
                  _buildFoodItem('images/bowl.png', "The Good Bowl", '4.5', '35-40 MINS', '₹ 400 FOR TWO', 'Biryani, Pastas, Punjabi'),
                ],
              )
                  : SizedBox.shrink(),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showMore = !_showMore;
                  });
                },
                child: Text(_showMore ? 'Show Less' : 'Show More', style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
              ),
              Divider(
                color: Colors.grey,
                thickness: 1.0,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(height: 20),
              Container(height: 270, child: allItems()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(String imagePath, String title, String category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          GestureDetector(

            onTap: () async {
              fooditemStream = await DatabaseMethods().getFoodItem(category);
              setState(() {
                _selectedCategory = title;

              });
            },
            child: Container(
              width: 130,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: _selectedCategory == title ? Colors.red : Colors.white,
              fontSize: 14,
              fontFamily: 'Poetsen One',
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildAdvertisementItem(String imagePath) {
    return InkWell(
      onTap: () {
        // Define your action here when the advertisement is tapped
        print('Advertisement tapped!');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildFoodItem(String imagePath, String title, String rating, String time, String price, String description) {
    return InkWell(
      onTap: () {
        // Define your action here when the food item is tapped
        print('$title tapped!');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0x5A3E5295),
        ),
        child: Column(
          children: [
            Image.asset(imagePath, height: 250, width: 380, fit: BoxFit.cover),
            Text(title, style: Widget_support.semiboldTextFieldStyle()),
            Row(
              children: [
                SizedBox(width: 15),
                Icon(Icons.star, color: Color.fromARGB(255, 42, 95, 42)),
                Text(' $rating  .  $time  .  $price', style: Widget_support.light2TextFieldStyle()),
              ],
            ),
            Text(description, style: Widget_support.light3TextFieldStyle()),
          ],
        ),
      ),
    );
  }

  Widget buildVeganRollItem(String imagePath, String title, String subtitle, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(15),
        color: Color(0x5A3E5295),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              imagePath.startsWith('http')
                  ? Image.network(imagePath, height: 150, width: 190)
                  : Image.asset(imagePath, height: 150, width: 190),
              SizedBox(
                height: 10,
              ),
              Text(title, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              Text(subtitle, style: TextStyle(color: Colors.grey)),
              Text(price, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
