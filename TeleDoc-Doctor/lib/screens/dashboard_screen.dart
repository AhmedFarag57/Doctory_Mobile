import 'package:doctor/screens/dashboard/home_screen.dart';
import 'package:doctor/screens/dashboard/my_account_screen.dart';
import 'package:doctor/screens/dashboard/my_appointment_screen.dart';
import 'package:doctor/screens/dashboard/review_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:doctor/utils/colors.dart';

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
            elevation: 25,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex ,
            onTap: _onTapIndex,
            items: [
              BottomNavigationBarItem(
                // ignore: deprecated_member_use
                  icon: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: currentIndex == 0 ? CustomColor.primaryColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(20)
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
                  label: "Home"
              ),
              BottomNavigationBarItem(
                // ignore: deprecated_member_use
                  icon: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: currentIndex == 1 ? CustomColor.primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/svg/calendar.svg',
                        color: currentIndex == 1 ? Colors.white : Colors.grey,
                      ),
                    ),
                  ),
                  // ignore: deprecated_member_use
                  label: "Calendar"
              ),
              BottomNavigationBarItem(
                // ignore: deprecated_member_use
                  icon: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: currentIndex == 2 ? CustomColor.primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/svg/star.svg',
                        color: currentIndex == 2 ? Colors.white : Colors.grey,
                      ),
                    ),
                  ),
                  // ignore: deprecated_member_use
                  label: "Star"
              ),
              BottomNavigationBarItem(
                // ignore: deprecated_member_use
                  icon: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        color: currentIndex == 3 ? CustomColor.primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/svg/user.svg',
                        color: currentIndex == 3 ? Colors.white : Colors.grey,
                      ),
                    ),
                  ),
                  // ignore: deprecated_member_use
                  label: "Profile"
              ),
            ]),
      ),
      body: goToScreen(currentIndex),
    );
  }

  _onTapIndex(index) {
    setState(() {
      currentIndex = index;
      print('index: $index');
    });
    goToScreen(currentIndex);
  }

  goToScreen(int currentIndex) {
    print('indexx: $currentIndex');
    switch(currentIndex){
      case 0:
        return HomeScreen();
      case 1:
        return MyAppointmentScreen();
      case 2:
        return ReviewScreen();
      case 3:
        return MyAccountScreen();
    }
  }
}
