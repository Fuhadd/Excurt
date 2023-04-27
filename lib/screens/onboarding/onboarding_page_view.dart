import 'package:escurt/Constants/custom_colors.dart';
import 'package:escurt/screens/startup/welcome_screen.dart';
import 'package:escurt/utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../widgets/animated_arc_circle.dart';
import 'first_onboarding_page.dart';
import 'second_onboarding_page.dart';
import 'third_onboarding_page.dart';

class OnboardingPageView extends StatefulWidget {
  static const routeName = '/onboardingScreen';
  const OnboardingPageView({super.key});

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WelcomeScreen()));
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0, right: 20),
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: CustomColors.whiteColor.withOpacity(0.6),
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              ),
              verticalSpacer(20),
              Expanded(
                  child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: const [
                  FirstOnboardingPage(),
                  SecondOnboardingPage(),
                  ThirdOnboardingPage(),
                ],
              )),
              // verticalSpacer(30),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   child: Lottie.asset(
              //     "assets/animations/couple_dinner.json",
              //     animate: true,
              //     repeat: true,
              //     reverse: false,
              //     // fit: BoxFit.contain,
              //   ),
              // ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 20.0, left: 20, bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: 3,
                        effect: ExpandingDotsEffect(
                          activeDotColor: CustomColors.whiteColor,
                          dotColor: CustomColors.whiteColor.withOpacity(0.3),
                          dotHeight: 8,
                          dotWidth: 13,
                          spacing: 8,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: const Icon(Icons.arrow_forward_ios),
                              ),
                              AnimatedArc(
                                pageController: _pageController,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
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
