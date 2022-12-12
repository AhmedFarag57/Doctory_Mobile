import 'package:flutter/material.dart';
import 'package:doctor/screens/auth/sign_in_screen.dart';
import 'package:doctor/utils/dimensions.dart';
import 'package:doctor/utils/strings.dart';
import 'package:doctor/utils/colors.dart';
import 'data.dart';

class OnBoardScreen extends StatefulWidget {
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  int totalPages = OnBoardingItems.loadOnboardItem().length;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColor.secondaryColor,
        body: PageView.builder(
          itemCount: totalPages,
            itemBuilder: (context, index){
            OnBoardingItem oi = OnBoardingItems.loadOnboardItem()[index];
              return Container(
                width: width,
                height: height,
                child:Stack(
                  children: [
                    Image.asset(
                      'assets/images/bg.png',
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Positioned(
                      top: 0,
                      left: - Dimensions.marginSize,
                      right: - Dimensions.marginSize,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular((width / 2) + Dimensions.marginSize),
                          bottomRight: Radius.circular((width / 2) + Dimensions.marginSize),
                        ),
                        child: Image.asset(
                          oi.image,
                          fit: BoxFit.fill,
                          height: height * 0.4,
                          width: width,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: -10,
                      left: -10,
                      child: Container(
                        height: height * 0.4,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radius * 4),
                            topRight: Radius.circular(Dimensions.radius * 4),
                          )
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: Dimensions.marginSize,
                                      right: Dimensions.marginSize),
                                  child: Text(
                                    oi.title,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Dimensions.extraLargeTextSize * 1.5,
                                        fontWeight: FontWeight.bold
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: Dimensions.heightSize * 2,),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: Dimensions.marginSize,
                                      right: Dimensions.marginSize),
                                  child: Text(
                                    oi.subTitle,
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.6),
                                        fontSize: Dimensions.defaultTextSize,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.heightSize * 4),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              child: Align(
                                alignment: Alignment.center,
                                child: index != (totalPages - 1) ? Padding(
                                  padding: const EdgeInsets.only(left: 40.0),
                                  child: Container(
                                    width: 100.0,
                                    height: 12.0,
                                    child: ListView.builder(
                                      itemCount: totalPages,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, i){
                                        return Padding(
                                          padding: const EdgeInsets.only(right: 10.0),
                                          child: Container(
                                            width: index == i ? 20 : 20.0,
                                            decoration: BoxDecoration(
                                                color: index == i ? CustomColor.primaryColor :
                                                CustomColor.secondaryColor,
                                                borderRadius: BorderRadius.all(Radius.circular(5.0))
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                                    : GestureDetector(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      height: 50,
                                      width: 200,
                                      decoration: BoxDecoration(
                                          color: CustomColor.primaryColor,
                                          borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius
                                              * 0.5))
                                      ),
                                      child: Center(
                                        child: Text(
                                          Strings.getStarted.toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: Dimensions.largeTextSize,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)
                                    => SignInScreen()));
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              );
            }),
      ),
    );
  }
}
