import 'dart:async';

import 'package:escurt/Constants/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utils/spacers.dart';
import '../../widgets/custom_button.dart';
import 'signup_view_model.dart';

// import 'package:step_progress_indicator/step_progress_indicator.dart';

class SignupOtpScreen extends StatefulHookConsumerWidget {
  static const routeName = '/signupOtpScreen';

  const SignupOtpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupOtpScreen> createState() => _SignupOtpScreenState();
}

class _SignupOtpScreenState extends ConsumerState<SignupOtpScreen> {
  bool buttonActive = false;

  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 3);
  String seconds = "60";
  bool isCountdownActive = false;

  @override
  void initState() {
    // ref.read(Si);
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
    setState(() {
      isCountdownActive = true;
    });
  }

  void stopTimer() {
    setState(() {
      countdownTimer?.cancel();
      isCountdownActive = false;
    });
  }

  void resetTimer() {
    stopTimer();
    setState(() {
      myDuration = const Duration(minutes: 3);
      isCountdownActive = false;
    });
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        if (countdownTimer != null) {
          countdownTimer?.cancel();
        }
        isCountdownActive = false;
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final signUpVM = ref.watch(signupProvider);
    final Map args = ModalRoute.of(context)?.settings.arguments as Map;

    final String otpMessage = args['otpMessage'];
    final String mobileNumberDialCode = args['mobileNumberDialCode'];
    final String mobileNumber = args['mobileNumber'];

    final pinController = useTextEditingController();

    var isPin = useState(false);

    String strDigits(int n) => n.toString().padLeft(2, '0');

    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const _CustomCurvedBar(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  "OTP Verification",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CustomColors.blackColor.withOpacity(0.8),
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              verticalSpacer(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  otpMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CustomColors.blackColor.withOpacity(0.5),
                    fontSize: 15,
                    // fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 25,
                  left: 10,
                  right: 10,
                  bottom: 40,
                ),
                child: Column(
                  children: [
                    //
                    verticalSpacer(25),
                    PinCodeTextField(
                      mainAxisAlignment: MainAxisAlignment.center,
                      appContext: context,
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      keyboardType: TextInputType.number,
                      controller: pinController,
                      pinTheme: PinTheme(
                        fieldOuterPadding:
                            const EdgeInsets.only(right: 4.0, left: 4.0),
                        shape: PinCodeFieldShape.box,
                        fieldHeight: 50,
                        fieldWidth: 45,
                        selectedColor: CustomColors.textFieldBackgroundColor,
                        selectedFillColor: CustomColors.whiteColor,
                        activeFillColor:
                            CustomColors.mainPinkColor.withOpacity(0.06),
                        activeColor: CustomColors.textFieldBackgroundColor,
                        inactiveColor: CustomColors.textFieldBackgroundColor,
                        inactiveFillColor:
                            CustomColors.textFieldBackgroundColor,
                        borderWidth: 1,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      cursorColor: Theme.of(context).primaryColor,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      onCompleted: (v) {
                        isPin.value = true;
                      },
                      onChanged: (value) {
                        isPin.value =
                            pinController.text.length >= 6 ? true : false;
                      },
                      beforeTextPaste: (text) {
                        return true;
                      },
                    ),

                    // vericalSpacer(25),
                    // customTextField(
                    //   'confirm_password',
                    //   Icons.vpn_key,
                    //   Icons.remove_red_eye_outlined,
                    //   'Confirm Password',
                    //   obscureText: true,
                    //   validator: FormBuilderValidators.compose([
                    //     FormBuilderValidators.notEqual(context,
                    //         _formKey.currentState?.fields['password']?.value,
                    //         errorText: 'Passwords do not match!  '),
                    //   ]),
                    // ),
                    verticalSpacer(50),
                    CustomButton(
                      color: CustomColors.mainPinkColor,
                      isLoading: signUpVM.isLoading,
                      title: 'Continue',
                      onTap: !isPin.value || signUpVM.isLoading
                          ? null
                          : () {
                              signUpVM.uploadPhoneNumber(mobileNumberDialCode,
                                  mobileNumber, pinController.text,
                                  context: context
                                  // ref: ref,
                                  );
                            },
                    ),
                    verticalSpacer(20),
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
