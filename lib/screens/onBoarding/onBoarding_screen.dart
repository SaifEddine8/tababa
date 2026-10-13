import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tababa/constant/constant_colors.dart';
import 'package:tababa/constant/constant_style.dart';
import 'package:tababa/screens/login_screen.dart';
import 'package:tababa/screens/onBoarding/first_screen.dart';
import 'package:tababa/screens/onBoarding/second_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool isLastPage=false; 
  @override
  Widget build(BuildContext context) {
    List<Widget>onBoardingScreens=[
      FirstScreen(),
      SecondScreen()
    ];
    
    PageController pageController=PageController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            PageView(children: onBoardingScreens,
            controller: pageController,
            onPageChanged: (value) =>setState(() {
              isLastPage=value==1;
            }) ,
            ),
            Container(
              alignment: Alignment(0, 0.7),
              child: SmoothPageIndicator(
                effect: WormEffect(
                activeDotColor: ConstantColors.primary,
                dotColor: Colors.grey.shade300
              ),
              controller:pageController,
              count: 2,
                            
              ),
              
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              alignment: Alignment(0, 0.9),
              child: SizedBox(
                
                width: .infinity,
                child: ElevatedButton(
                  onPressed: (){
                    isLastPage?Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()),(route)=>false):pageController.jumpToPage(1);
                  },
                  style: ConstantStyle.buttonStyle,
                  child:Text('G E T  S T A R T E D',
                  style: ConstantStyle.textButtonStyle,
                  ) ),
              ),
            )
          ],
        ),
      )
    );
  }
}