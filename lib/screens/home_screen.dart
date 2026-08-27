import 'package:facebook_replication/constants.dart';
import 'package:facebook_replication/screens/newsfeed_screen.dart';
import 'package:facebook_replication/screens/notification_screen.dart';
import 'package:facebook_replication/screens/profile_screen.dart';
import 'package:facebook_replication/screens/friends_screen.dart';
import 'package:facebook_replication/screens/settings_screen.dart';
import 'package:facebook_replication/widgets/custom_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  // Activity 2 - Enhancement 2: dynamic AppBar title (changes per selected screen)
  final List<String> _titles = const ['CCITBook', 'Notifications', 'Profile'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        shadowColor: Theme.of(context).shadowColor,
        elevation: 2,
        title: CustomFont(
          text: _titles[_selectedIndex],
          fontSize: ScreenUtil().setSp(25),
          color: Theme.of(context).appBarTheme.foregroundColor ?? APP_PRIMARY,
          fontWeight: FontWeight.bold,
        ), // CustomFont
      ), // AppBar
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const <Widget>[
          NewsfeedScreen(),
          NotificationScreen(),
          ProfileScreen(),
        ], // <Widget>[]
        onPageChanged: (page) {
          setState(() {
            _selectedIndex = page;
          });
        },
      ), // PageView
      // Activity 2 - Enhancement 3: additional BottomNavigationBarItem entries
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false, // selected item
        showUnselectedLabels: false, // unselected item
        type: BottomNavigationBarType.fixed,
        onTap: _onTappedBar,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Friends'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ], // []
        selectedItemColor: APP_PRIMARY,
        currentIndex: _currentBarIndex(),
      ), // BottomNavigationBar
    ); // Scaffold
  }

  // Maps the 3 real pages onto the 5 nav items (Friends & Menu are stubs).
  int _currentBarIndex() {
    switch (_selectedIndex) {
      case 0:
        return 0; // Home
      case 1:
        return 2; // Notifications
      case 2:
        return 4; // Profile
      default:
        return 0;
    }
  }

  void _onTappedBar(int value) {
    switch (value) {
      case 0:
        setState(() => _selectedIndex = 0);
        _pageController.jumpToPage(0);
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const FriendsScreen()));
        break;
      case 2:
        setState(() => _selectedIndex = 1);
        _pageController.jumpToPage(1);
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
        break;
      case 4:
        setState(() => _selectedIndex = 2);
        _pageController.jumpToPage(2);
        break;
    }
  }
}
