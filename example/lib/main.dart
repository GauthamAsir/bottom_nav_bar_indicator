import 'package:bottom_nav_bar/bottom_nav_bar.dart';
import 'package:bottom_nav_bar/navigation_bar_item.dart';
import 'package:bottom_nav_bar_example/dashboard.dart';
import 'package:bottom_nav_bar_example/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const Color primaryDark = Color(0xFFEF1F1F);

  int page = 0;
  PageController _pageController;

  void navigationTapped(int page) {
    _pageController.animateToPage(page,
        duration: Duration(milliseconds: 250), curve: Curves.linear);
  }

  void onPageChanged(int page) {
    page = page;
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(
        onTap: navigationTapped,
        currentIndex: page,
        activeColor: primaryDark,
        inactiveColor: Colors.black,
        indicatorColor: primaryDark,
        changeLabelColorOnSelect: true, // Default is False
        indicatorAnimDuration:
            Duration(milliseconds: 300), // Default is 250 milliseconds
        indicatorHeight: 3, // Default is 2.5
        barHeight: 70, // Default is 60
        items: [
          BottomIndicatorNavigationBarItem(
              iconData: Icons.person,
              assetActiveIcon: 'assets/images/codehelios.jpg',
              assetInActiveIcon: 'assets/images/android.png',
              label: 'Dashboard'),
          BottomIndicatorNavigationBarItem(
              iconData: Icons.person, label: 'Profile'),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: [Dashboard(), Profile()],
      ),
    );
  }
}
