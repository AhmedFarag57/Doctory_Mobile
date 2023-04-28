import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teledoc/screens/dashboard/emergency_screen.dart';
import 'package:teledoc/screens/dashboard/home_screen.dart';
import 'package:teledoc/screens/notification_screen.dart';
import 'package:teledoc/utils/colors.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: new Material(
        elevation: 10,
        child: new BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 25,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: _onTapIndex,
            items: [
              BottomNavigationBarItem(
                // ignore: deprecated_member_use
                icon: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: currentIndex == 0
                        ? CustomColor.primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/svg/home.svg',
                      color: currentIndex == 0 ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
                // ignore: deprecated_member_use
                label: "Home",
              ),
              /*
              BottomNavigationBarItem(
                // ignore: deprecated_member_use
                icon: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: currentIndex == 2
                          ? CustomColor.primaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/svg/search.svg',
                      color: currentIndex == 2 ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
                // ignore: deprecated_member_use
                label: "Search",
              ),
              */
              BottomNavigationBarItem(
                // ignore: deprecated_member_use
                icon: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: currentIndex == 1
                        ? CustomColor.primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.notifications_none_outlined,
                      color: currentIndex == 1 ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
                // ignore: deprecated_member_use
                label: "Notification",
              ),
              BottomNavigationBarItem(
                // ignore: deprecated_member_use
                icon: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: currentIndex == 2
                        ? CustomColor.primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/svg/siren.svg',
                      color: currentIndex == 2 ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
                // ignore: deprecated_member_use
                label: "Emergency",
              ),
            ]),
      ),
      body: goToScreen(currentIndex),
    );
  }

  _onTapIndex(index) {
    setState(() {
      currentIndex = index;
    });
    goToScreen(currentIndex);
  }

  goToScreen(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return NotificationScreen();
      case 2:
        return EmergencyScreen();
      /*
      case 3:
        return SearchResultScreen(); NearbyScreen();
      */
    }
  }
}
