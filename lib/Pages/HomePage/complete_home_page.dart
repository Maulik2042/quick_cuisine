
// This page is crated for bottom navigation bar with full home Page

import 'package:flutter/material.dart';
import 'package:quick_cuisine/Pages/Cart/cart_history.dart';
import 'package:quick_cuisine/Pages/Cart/cart_page.dart';
import 'package:quick_cuisine/Pages/HomePage/homepage.dart';
import 'package:quick_cuisine/Utils/Colors.dart';

class CompleteHomePage extends StatefulWidget {
  const CompleteHomePage({super.key});

  @override
  State<CompleteHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<CompleteHomePage> {
  int _selectedIndex = 0;
  List pages = [
    HomePage(),
    Container(child: Center(child: Text('archive Page'),),),
    CartHistory(),
    Container(child: Center(child: Text('Profile page'),),)
  ];

  void onTapNav(int index){
  setState(() {
    _selectedIndex = index;
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        selectedFontSize: 0.0, // for assertion failed error
        unselectedFontSize: 0.0,
        onTap: onTapNav,
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined,),
        label:'Home'
        ),
        BottomNavigationBarItem(icon: Icon(Icons.archive,),
            label:'history'
        ),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart,),
            label:'cart'
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person,),
            label:'profile'
        )
      ],

      ),
    );
  }


}
