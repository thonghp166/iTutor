import 'package:flutter/material.dart';
import 'package:itutor/src/repository/user_repository.dart';
import 'package:itutor/src/screens/dashboard_screen.dart';
import 'package:itutor/src/screens/calendar_screen.dart';
import 'package:itutor/src/screens/create_class_screen.dart';
import 'package:itutor/src/screens/messages_screen.dart';
import 'package:itutor/src/screens/profile_screen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  PageController pageController = PageController(
    initialPage: 4,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: pageChanged,
      children: <Widget>[
        DashboardScreen(),
        MessageScreen(),
        CreateClassScreen(),
        CalendarScreen(),
        ProfileScreen(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex:
            _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Tìm'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text('Tin nhắn'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.create), title: Text('Đăng lớp')),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), title: Text('Lịch học')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile'))
        ],
      ),
    );
  }
}
