import 'package:expens/data/onboarding_data.dart';
import 'package:expens/screens/onbording/front_page.dart';
import 'package:expens/screens/onbording/share_onbording_screen.dart';
import 'package:expens/screens/user_data_screen.dart';
import 'package:expens/utils/colors.dart';
import 'package:expens/utils/constant.dart';
import 'package:expens/widgets/custom_button.dart';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnbordingScreen extends StatefulWidget {
  const OnbordingScreen({super.key});

  @override
  State<OnbordingScreen> createState() => _OnbordingScreenState();
}

class _OnbordingScreenState extends State<OnbordingScreen> {
  //page controller
  final PageController _controller = PageController();

  bool showDetailsPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 10,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: KDefaltPadding),
        child: Column(
          children: [
            //onbording Screens
            Expanded(
              child: Stack(
                children: [
                  PageView(
                    controller: _controller,
                    onPageChanged: (index) {
                      setState(() {
                        showDetailsPage = index == 3;
                      });
                    },
                    children: [
                      FrontPage(),
                      ShareOnbordingScreen(
                        title: OnboardingData.onboardingList[0].title,
                        description:
                            OnboardingData.onboardingList[0].description,
                        imageUrl: OnboardingData.onboardingList[0].imageUrl,
                      ),
                      ShareOnbordingScreen(
                        title: OnboardingData.onboardingList[1].title,
                        description:
                            OnboardingData.onboardingList[1].description,
                        imageUrl: OnboardingData.onboardingList[1].imageUrl,
                      ),
                      ShareOnbordingScreen(
                        title: OnboardingData.onboardingList[2].title,
                        description:
                            OnboardingData.onboardingList[2].description,
                        imageUrl: OnboardingData.onboardingList[2].imageUrl,
                      ),
                    ],
                  ),
                  //page dot indicators
                  Container(
                    alignment: const Alignment(0, .6),
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: 4,
                      effect: WormEffect(
                        activeDotColor: kMainColor,
                        dotColor: kLightGrey,
                      ),
                    ),
                  ),
                  //navigation button
                  Positioned(
                    bottom: 60,
                    left: 0,
                    right: 0,
                    child: !showDetailsPage
                        ? GestureDetector(
                            onTap: () {
                              _controller.animateToPage(
                                _controller.page!.toInt() + 1,
                                duration: Duration(milliseconds: 600),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: CustomButton(
                              buttonColor: kMainColor.withOpacity(.9),
                              buttonName: showDetailsPage
                                  ? "Get Started"
                                  : "Next",
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              //navigate to the User Data Page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserDataScreen(),
                                ),
                              );
                            },
                            child: CustomButton(
                              buttonColor: kMainColor.withOpacity(.9),
                              buttonName: showDetailsPage
                                  ? "Get Started"
                                  : "Next",
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
