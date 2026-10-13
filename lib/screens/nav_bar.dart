import 'package:flutter/material.dart';
import 'package:tababa/constant/constant_colors.dart';
import 'package:tababa/screens/add_clinic_screen.dart';
import 'package:tababa/screens/favorite_screen.dart';
import 'package:tababa/screens/home_screen.dart';
import 'package:tababa/screens/profile_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int index=0;
  @override
  Widget build(BuildContext context) {
    Map<String,dynamic>bottomBarItem={
      'Home':Icon(Icons.home),
      'Add':Icon(Icons.add),
      'favorite':Icon(Icons.favorite),
      'profile':Icon(Icons.person)
    };
    List<Widget>screens=[
      HomeScreen(),
      AddClinicScreen(),
      FavoriteScreen(),
      ProfileScreen()
    ];
    return Scaffold(
      body: IndexedStack(
        
        index: index,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: .fixed,
        selectedItemColor: ConstantColors.primary,
        currentIndex: index,
        items:bottomBarItem.entries.map((item)=>BottomNavigationBarItem(
          icon:item.value,
           label: item.key
          )).toList(),
          onTap: (value) => setState(() {
            index=value;
          }),

        ),
    );
  }
}