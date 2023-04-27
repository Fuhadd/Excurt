import 'dart:io';

import 'package:escurt/Constants/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../utils/spacers.dart';
import '../../widgets/custom_button.dart';
import 'signup_view_model.dart';

// import 'package:step_progress_indicator/step_progress_indicator.dart';

class SignupPhoneScreen extends StatefulHookConsumerWidget {
  static const routeName = '/signupPhoneScreen';

  const SignupPhoneScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupPhoneScreen> createState() => _SignupPhoneScreenState();
}

class _SignupPhoneScreenState extends ConsumerState<SignupPhoneScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController phoneController = TextEditingController();

  File? image;
  String mobileNumberDialCode = "";
  String mobileNumber = "";
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
                  "Your Phone Number",
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
                child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      //
                      verticalSpacer(25),
                      IntlPhoneField(
                        controller: phoneController,
                        decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            helperMaxLines: 7,
                            helperStyle: TextStyle(fontSize: 13),
                            floatingLabelStyle:
                                TextStyle(color: CustomColors.mainPinkColor),
                            fillColor: CustomColors.mainPinkColor,
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: CustomColors.mainPinkColor)),
                            prefixIcon: Icon(
                              Icons.phone,
                              size: 20,
                              color: CustomColors.blackIconColor,
                            ),
                            // prefixIconColor: Colors.red,

                            // labelText: labelText,
                            labelStyle: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                        initialCountryCode: 'NG',
                        onChanged: (phone) {
                          setState(() {
                            mobileNumberDialCode = phone.countryCode;
                            mobileNumber = phone.number;
                          });
                        },
                      ),
                      verticalSpacer(50),
                      CustomButton(
                        color: CustomColors.mainPinkColor,
                        isLoading: signUpVM.isLoading,
                        title: 'Continue',
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          var validate = _formKey.currentState?.validate();

                          if (validate == true) {
                            _formKey.currentState?.save();
                            signUpVM.sendOtp(mobileNumberDialCode, mobileNumber,
                                context: context
                                // ref: ref,
                                );
                          }
                        },
                      ),
                      verticalSpacer(20),
                    ],
                  ),
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
