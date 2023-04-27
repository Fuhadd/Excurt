import 'dart:io';

import 'package:escurt/Constants/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/spacers.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'signup_view_model.dart';

// import 'package:step_progress_indicator/step_progress_indicator.dart';

class SignupEmailScreen extends StatefulHookConsumerWidget {
  static const routeName = '/signupEmailScreen';

  const SignupEmailScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupEmailScreen> createState() => _SignupEmailScreenState();
}

class _SignupEmailScreenState extends ConsumerState<SignupEmailScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController phoneController = TextEditingController();

  File? image;
  String password = "";
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
                  "Enter your email and set your password",
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
                      // customTextField(
                      //   'firstname',
                      //   Icons.person,
                      //   null,
                      //   'First Name',
                      //   validator: FormBuilderValidators.compose(
                      //     [
                      //       FormBuilderValidators.minLength(4,
                      //           errorText:
                      //               'A valid first name should be greater than 4 characters '),
                      //     ],
                      //   ),
                      // ),
                      // verticalSpacer(25),

                      // customTextField(
                      //   'lastname',
                      //   Icons.person,
                      //   null,
                      //   'Last Name',
                      //   validator: FormBuilderValidators.compose(
                      //     [
                      //       FormBuilderValidators.minLength(4,
                      //           errorText:
                      //               'A valid last name should be greater than 4 characters '),
                      //     ],
                      //   ),
                      // ),
                      // verticalSpacer(25),
                      customTextField(
                        'email',
                        Icons.mail,
                        null,
                        'Email',
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.email(
                                errorText: 'Provided email not valid '),
                            FormBuilderValidators.required(
                                errorText: 'Email field cannot be empty '),
                          ],
                        ),
                      ),
                      // verticalSpacer(25),
                      // customTextField(
                      //   'phone',
                      //   Icons.phone,
                      //   null,
                      //   'Phone',
                      //   prefix: Text(
                      //     '+234 ',
                      //     style: Theme.of(context)
                      //         .textTheme
                      //         .headlineSmall!
                      //         .copyWith(color: Colors.grey),
                      //   ),
                      //   validator: FormBuilderValidators.compose(
                      //     [
                      //       FormBuilderValidators.required(
                      //           errorText: 'Email field cannot be empty '),
                      //     ],
                      //   ),
                      // ),
                      // IntlPhoneField(
                      //   controller: phoneController,
                      //   decoration:
                      //       customFormDecoration('Phone Number', null, null),
                      //   initialCountryCode: 'NG',
                      //   onChanged: (phone) {
                      //     phoneNumber = phone.completeNumber;
                      //   },
                      // ),

                      verticalSpacer(25),
                      customTextField(
                        'password',
                        Icons.vpn_key,
                        Icons.remove_red_eye_outlined,
                        'Password',
                        obscureText: true,
                        onChanged: (value) {
                          setState(() {
                            password = value!;
                            print(password);
                          });
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.minLength(6,
                              errorText:
                                  'Good passwords are greater than 6 characters'),
                          FormBuilderValidators.required(
                              errorText: 'Password field cannot be empty '),
                        ]),
                      ),
                      verticalSpacer(25),
                      customTextField(
                        'confirm_password',
                        Icons.vpn_key,
                        Icons.remove_red_eye_outlined,
                        'Confirm Password',
                        obscureText: true,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.equal(password,
                              errorText: 'Passwords do not match!  '),
                        ]),
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
                        title: 'Register',
                        onTap: () {
                          print(
                            _formKey.currentState?.fields['password']?.value,
                          );
                          FocusScope.of(context).unfocus();
                          var validate = _formKey.currentState?.validate();

                          if (validate == true) {
                            _formKey.currentState?.save();

                            var email = _formKey
                                .currentState?.fields['email']?.value
                                .toString()
                                .trim();
                            var password = _formKey
                                .currentState?.fields['password']?.value;
                            signUpVM.signUpEmailAndPassword(email, password,
                                context: context
                                // ref: ref,
                                );
                          }
                        },
                      ),
                      verticalSpacer(20),
                      const Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "I already have an account",
                          style: TextStyle(
                            color: CustomColors.greyTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
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
