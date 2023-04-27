import 'package:escurt/Constants/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/spacers.dart';

class ThirdOnboardingPage extends StatelessWidget {
  static const routeName = '/thirdOnboardingScreen';
  const ThirdOnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            // width: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Start ",
                        style: TextStyle(
                          color: CustomColors.whiteColor.withOpacity(0.9),
                          fontSize: 40,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: "Dating",
                        style: TextStyle(
                          color: CustomColors.whiteColor.withOpacity(0.9),
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpacer(25),
                const SizedBox(
                  width: 250,
                  child: Text(
                    "Express your personality with multimedia dating profile",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      height: 1.5,
                      // fontSize: 50,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Lottie.asset(
              "assets/animations/couple_dinner.json",
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
