import 'dart:io';

import 'package:escurt/Constants/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/spacers.dart';
import '../../widgets/custom_button.dart';
import 'signup_view_model.dart';

// import 'package:step_progress_indicator/step_progress_indicator.dart';

class SignupGenderScreen extends StatefulHookConsumerWidget {
  static const routeName = '/signupGenderScreen';

  const SignupGenderScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupGenderScreen> createState() => _SignupGenderScreenState();
}

class _SignupGenderScreenState extends ConsumerState<SignupGenderScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController phoneController = TextEditingController();

  File? image;
  String password = "";
  String gender = "";
  @override
  Widget build(BuildContext context) {
    final signUpVM = ref.watch(signupProvider);
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const _CustomCurvedBar(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  "Your Gender",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CustomColors.blackColor.withOpacity(0.8),
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                  left: 40,
                  right: 40,
                  bottom: 40,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                gender = 'F';
                              });
                            },
                            child: Container(
                              height: 170,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: gender == 'F'
                                      ? CustomColors.mainPinkColor
                                          .withOpacity(0.8)
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: CustomColors.greyTextColor
                                        .withOpacity(0.5),
                                    width: 2,
                                  )),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/female_icon.png",
                                    height: 60,
                                    width: 60,
                                    // color: Colors.red,
                                    // color: CustomColors.whiteColor,
                                  ),
                                  verticalSpacer(10),
                                  Text(
                                    "Woman",
                                    style: TextStyle(
                                      color: CustomColors.blackColor
                                          .withOpacity(0.7),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        horizontalSpacer(20),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                gender = 'M';
                              });
                            },
                            child: Container(
                              height: 170,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: gender == 'M'
                                      ? CustomColors.mainPinkColor
                                          .withOpacity(0.8)
                                      : Colors.transparent,
                                  border: Border.all(
                                    color: CustomColors.greyTextColor
                                        .withOpacity(0.5),
                                    width: 2,
                                  )),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/images/male_icon.png",
                                    height: 55,
                                    width: 55,
                                    // color: Colors.red,
                                    // color: CustomColors.whiteColor,
                                  ),
                                  verticalSpacer(10),
                                  Text(
                                    "Man",
                                    style: TextStyle(
                                      color: CustomColors.blackColor
                                          .withOpacity(0.7),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    verticalSpacer(50),
                    CustomButton(
                      color: CustomColors.mainPinkColor,
                      isLoading: signUpVM.isLoading,
                      title: 'Continue',
                      onTap: gender.isEmpty
                          ? null
                          : () {
                              signUpVM.uploadGender(gender, context: context
                                  // ref: ref,
                                  );
                            },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class _CustomCurvedBar extends StatelessWidget {
  const _CustomCurvedBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipPath(
        clipper: WaveClipper(),
        child: Container(
          height: 200,
          decoration: const BoxDecoration(color: CustomColors.mainPinkColor),
        ),
      ),
      ClipPath(
        clipper: WaveClipper(),
        child: Container(
          height: 190,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              CustomColors.mainPurpleColor,
              CustomColors.mainPinkColor,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Padding(
              padding: const EdgeInsets.only(bottom: 30, left: 40),
              child: Container(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(90, 35),
                        backgroundColor: const Color(0xffF9EBE7),
                        maximumSize: const Size(90, 35),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(
                              color: Color(0xffF9EBE7),
                            )),
                        shadowColor: Colors.transparent,
                        elevation: 0),
                    onPressed: () {
                      Navigator.pop(context);
                      // Get.to(() => NavigationPage());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text(
                          'Back',
                          style: TextStyle(
                              fontSize: 11, color: CustomColors.mainPinkColor),
                        ),
                        Icon(
                          Icons.arrow_back,
                          color: CustomColors.mainPinkColor,
                          size: 17,
                        ),
                      ],
                    ),
                  ),
                ),
              )
              // Row(
              //   children: const [
              //     Text(
              //       'Let\'s Get Started',
              //       style: TextStyle(
              //           color: CustomColors.blackColor,
              //           fontSize: 25,
              //           fontWeight: FontWeight.w700),
              //       textAlign: TextAlign.center,
              //     ),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Icon(Icons.insert_emoticon)
              //   ],
              // ),
              ),
        ),
      ),
    ]);
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    var firstController = Offset(0, size.height - 70);
    var firstEnd = Offset(size.width / 4, size.height - 70);
    path.quadraticBezierTo(
      firstController.dx,
      firstController.dy,
      firstEnd.dx,
      firstEnd.dy,
    );
    path.lineTo(size.width - 100, size.height - 70);
    var secondController = Offset(size.width - 55, size.height - 70);
    var secondEnd = Offset(size.width, size.height - 135);
    path.quadraticBezierTo(
      secondController.dx,
      secondController.dy,
      secondEnd.dx,
      secondEnd.dy,
    );
    path.lineTo(size.width, 0);
    path.close;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }

  InputDecoration formDecoration = const InputDecoration(
      floatingLabelStyle: TextStyle(color: Colors.pink),
      fillColor: Colors.pink,
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.pink)),
      prefixIcon: Icon(
        Icons.mail,
        size: 20,
      ),
      labelText: 'Gender');
}
