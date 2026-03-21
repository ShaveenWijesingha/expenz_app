import 'package:expens/screens/add_new_screen.dart';
import 'package:expens/screens/budget_screen.dart';
import 'package:expens/screens/home_screen.dart';
import 'package:expens/screens/profile_screen.dart';
import 'package:expens/screens/transaction_screen.dart';
import 'package:expens/utils/colors.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //current page index
  int _currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    //screens list
    final List<Widget> pages = [
      HomeScreen(),
      transactionScreen(),
      addNewScreen(),
      budgetScreen(),
      profileScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: kWhite,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,

        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),

        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 28), // normal
            activeIcon: Icon(Icons.home, size: 32), // selected size
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded, size: 28), // normal
            activeIcon: Icon(Icons.list_rounded, size: 32), // selected size

            label: "Transactions",
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: kMainColor,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(10),
              child: Icon(Icons.add, color: kWhite, size: 35),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket, size: 28), // normal
            activeIcon: Icon(Icons.rocket, size: 32), // selected size

            label: "Budget",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 28), // normal
            activeIcon: Icon(Icons.person, size: 32), // selected size

            label: "Profile",
          ),
        ],
      ),
      body: pages[_currentPageIndex],
    );
  }
}
