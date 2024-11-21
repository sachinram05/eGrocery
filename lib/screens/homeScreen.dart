import 'package:egrocery/screens/ProfileScreen.dart';
import 'package:egrocery/screens/cartScreen.dart';
import 'package:egrocery/screens/productListScreen.dart';
import 'package:egrocery/screens/vegetable/vegetableScreen.dart';
import 'package:egrocery/widgets/addProduct.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[ProductListScreen(),VegetableScreen(),CartScreen(),ProfileScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    final double appBarHeight = AppBar().preferredSize.height;
    return  Scaffold(
        extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: SafeArea(
        child: Drawer(
            child:  ListView(
          padding: const EdgeInsets.all(30),
          children: [
            Container(
                alignment: AlignmentDirectional.centerStart,
                padding: const EdgeInsets.fromLTRB(0, 50, 10, 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.clear, size: 34))),
            ListTile(
              leading: const Icon(
                Icons.add_card,
                color: Colors.black,
              ),
              title: Text(
                'Add Product',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddProduct(isEditMode: false)));
              },
            ),
            Container(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                child:const Divider(
                  // height: 10,
                  thickness: 0.8,
                  indent: 10,
                  endIndent: 60,
                  color: Color.fromARGB(255, 61, 61, 61),
                )),
            ListTile(
              leading: const Icon(
                Icons.view_list_outlined,
                color: Colors.black,
              ),
              title: Text(
                'View Listing',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => const Profile()));
              },
            ),
          ],
        )),
      ),
      body:  Stack(
            clipBehavior: Clip.none,
            children: [
          Positioned(
              top: 0,
              right: 0,
              child:  Image.asset(
                'assets/images/unnamed.png',
                width: 180,
                height: 180,
              )),
               Container(
                padding: EdgeInsets.only(top: appBarHeight),
              child: 
           _widgetOptions.elementAt(_selectedIndex))
            ],
        ),
      // ),
      bottomNavigationBar:  BottomNavigationBar(

        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:_selectedIndex == 0?const Icon(Icons.auto_awesome_mosaic)
                : const Icon( Icons.auto_awesome_mosaic_outlined),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? const Icon(Icons.local_florist)
                : const Icon(Icons.local_florist_outlined),
            label: 'Vegetables',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? const Icon(Icons.shopping_cart)
                :const Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
          ),
           BottomNavigationBarItem(
            icon: _selectedIndex == 3
                ? const Icon(Icons.person_2)
                : const Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255,102, 0, 249),
        onTap: _onItemTapped,
      ),
    );
  }
}
