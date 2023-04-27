import 'package:escurt/Constants/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/spacers.dart';

class FirstOnboardingPage extends StatelessWidget {
  static const routeName = '/firstOnboardingScreen';
  const FirstOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            width: 250,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: "test",
                  child: Text(
                    "Create a",
                    style: TextStyle(
                      color: CustomColors.whiteColor.withOpacity(0.9),
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  "Profile",
                  style: TextStyle(
                    color: CustomColors.whiteColor.withOpacity(0.9),
                    fontSize: 40,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                verticalSpacer(15),
                Text(
                  "Express your personality with multimedia dating profile",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CustomColors.whiteColor.withOpacity(0.7),
                    height: 1.5,
                    // fontSize: 50,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          verticalSpacer(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Lottie.asset(
              "assets/animations/fill_profile2.json",
              height: 250,
              animate: true,
              repeat: true,
              reverse: false,
              // fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
