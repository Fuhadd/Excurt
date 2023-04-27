import 'package:escurt/Constants/custom_colors.dart';
import 'package:escurt/utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../register/signup_email_screen.dart';
import '../signin/signin_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/welcomeScreen';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration:
            const BoxDecoration(gradient: CustomColors.pinkPurpleGradient),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  verticalSpacer(30),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Let's get ",
                          style: TextStyle(
                            color: CustomColors.whiteColor.withOpacity(0.9),
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: "Started",
                          style: TextStyle(
                            color: CustomColors.whiteColor.withOpacity(0.9),
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpacer(15),
                  SizedBox(
                    width: 250,
                    child: Text(
                      "Join now and start swiping your way to a new romance",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CustomColors.whiteColor.withOpacity(0.7),
                        height: 1.5,
                        // fontSize: 50,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Lottie.asset(
                    "assets/animations/firery_passion.json",
                    height: 200,
                    animate: true,
                    repeat: true,
                    reverse: false,
                    // fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Column(
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Center(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            decoration: BoxDecoration(
                              color: CustomColors.mainPinkColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextButton(
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignupEmailScreen()));
                                },
                                child: const Text("Create Account",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700))),
                          ),
                        ),
                      ),
                    ),
                    verticalSpacer(30),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Center(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            decoration: BoxDecoration(
                              color: CustomColors.whiteColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextButton(
                                onPressed: () async {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SigninScreen()));
                                },
                                child: const Text("SIGN IN",
                                    style: TextStyle(
                                        color: CustomColors.mainPurpleColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700))),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedPageIndicator extends StatefulWidget {
  final int pageCount;
  final double dotSize;
  final double indicatorRadius;
  final Color activeColor;
  final Color inactiveColor;

  const AnimatedPageIndicator({
    Key? key,
    required this.pageCount,
    this.dotSize = 10.0,
    this.indicatorRadius = 30.0,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
  }) : super(key: key);

  @override
  _AnimatedPageIndicatorState createState() => _AnimatedPageIndicatorState();
}

class _AnimatedPageIndicatorState extends State<AnimatedPageIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 0, end: widget.pageCount - 1).animate(_controller)
          ..addListener(() {
            setState(() {
              _currentPage = _animation.value.toInt();
            });
          });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.pageCount, (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: widget.dotSize,
                height: widget.dotSize,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? widget.activeColor
                        : widget.inactiveColor,
                  ),
                ),
              ),
            );
          }),
        ),
        Positioned(
          left: (_currentPage * (widget.dotSize * 2 + 16)) +
              widget.dotSize +
              (widget.dotSize / 2),
          top: 0,
          bottom: 0,
          child: SizedBox(
            width: widget.indicatorRadius,
            height: widget.indicatorRadius,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.activeColor,
                boxShadow: [
                  BoxShadow(
                    color: widget.activeColor.withOpacity(0.3),
                    blurRadius: 10,
                    spreadRadius: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void goToPage(int page) {
    _controller.animateTo(
      page.toDouble(),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
