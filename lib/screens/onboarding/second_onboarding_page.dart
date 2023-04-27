import 'package:escurt/Constants/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/spacers.dart';

class SecondOnboardingPage extends StatelessWidget {
  static const routeName = '/secondOnboardingScreen';
  const SecondOnboardingPage({super.key});

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
                    "Find Your",
                    style: TextStyle(
                      color: CustomColors.whiteColor.withOpacity(0.9),
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  "Match",
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
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Lottie.asset(
              "assets/animations/discovering_Intents3.json",
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
