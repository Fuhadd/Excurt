import 'dart:io';

import 'package:escurt/Constants/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../utils/spacers.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

// import 'package:step_progress_indicator/step_progress_indicator.dart';

class SignupPageViewScreen extends StatefulWidget {
  static const routeName = '/signup';

  const SignupPageViewScreen({Key? key}) : super(key: key);

  @override
  State<SignupPageViewScreen> createState() => _SignupPageViewScreenState();
}

class _SignupPageViewScreenState extends State<SignupPageViewScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController phoneController = TextEditingController();

  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Hero(tag: "note", child: _CustomCurvedBar()),
              Padding(
                padding: const EdgeInsets.only(
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
                          FormBuilderValidators.minLength(6,
                              errorText:
                                  'Good passwords are greater than 6 characters'),
                          FormBuilderValidators.required(
                              errorText: 'Password field cannot be empty '),
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
                        title: 'Register',
                        onTap: () {
                          var validate = _formKey.currentState?.validate();
                          if (image == null) {
                            validate = false;
                            Future.delayed(Duration.zero, () {
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(const SnackBar(
                                  content: Text('Image Field Cannot Be Empty'),
                                  backgroundColor: Colors.red,
                                ));
                            });
                          }
                          if (validate == true) {
                            _formKey.currentState?.save();
                            var firstName = _formKey
                                .currentState?.fields['firstname']?.value
                                .toString()
                                .trim();
                            var lastName = _formKey
                                .currentState?.fields['lastname']?.value
                                .toString()
                                .trim();

                            var email = _formKey
                                .currentState?.fields['email']?.value
                                .toString()
                                .trim();
                            var phone = _formKey
                                .currentState?.fields['phone']?.value
                                .toString()
                                .trim();
                            var password = _formKey
                                .currentState?.fields['password']?.value;
                            print(1);
                          }
                        },
                      ),
                      verticalSpacer(20),
                      CustomButton(
                          textcolor: CustomColors.greyTextColor,
                          color: CustomColors.whiteColor,
                          title: 'I already have an account',
                          onTap: () {
                            //       Navigator.pushReplacementNamed(
                            //           context, LoginScreen.routeName);
                            //     }),
                            // BlocListener<SignupBloc, SignupState>(
                            //     listener: (context, state) {
                            //   if (state is SignupSuccessful) {
                            //     Navigator.pushReplacementNamed(
                            //         context, HomePage.routeName);

                            //     // HomePage()

                            //     //context, VerifyEmailScreen.routeName);
                            // //   }
                            // }, child: BlocBuilder<SignupBloc, SignupState>(
                            //   builder: ((context, state) {
                            //     if (state is SignupInProgress) {
                            //       Future.delayed(Duration.zero, () {
                            //         showdialog(context);
                            //       });
                            //     } else if (state is SignupFailed) {
                            //       Future.delayed(Duration.zero, () {
                            //         Navigator.of(context).pop();
                            //         ScaffoldMessenger.of(context)
                            //           ..removeCurrentSnackBar()
                            //           ..showSnackBar(SnackBar(
                            //             content: Text(state.message),
                            //             backgroundColor: Colors.red,
                            //           ));
                            //       });
                            //     }
                            //     // else if (state is SignupSuccessful) {
                            //     //   return Container();
                            //     // }
                            //     return Container();
                            //   }),
                            // )),

                            // CustomButton(
                            //   formKey: _formKey,
                            //   onPressed: () {
                            //     var validate = _formKey.currentState?.validate();
                            //     if (validate == true) {
                            //       _formKey.currentState?.save();
                            //       var username = _formKey
                            //           .currentState?.fields['username']?.value;
                            //       var email =
                            //           _formKey.currentState?.fields['email']?.value;
                            //       var gender =
                            //           _formKey.currentState?.fields['gender']?.value;
                            //       var password = _formKey
                            //           .currentState?.fields['password']?.value;
                            //       var phone = phoneNumber;
                            //       signupBloc?.add(SignUpButtonPressed(
                            //           email: email,
                            //           password: password,
                            //           userName: username,
                            //           phone: '+23481096789',
                            //           gender: gender));
                            //     }
                            //   },
                            //   child: Text('Next Step',
                            //       style: Theme.of(context)
                            //           .textTheme
                            //           .headline2!
                            //           .copyWith(color: Colors.white)),
                            // ),
                            // vericalSpacer(20),
                            // BlocListener<SignupBloc, SignupState>(
                            //     listener: (context, state) {
                            //   if (state is SignupSuccessful) {
                            //     Navigator.pushReplacementNamed(
                            //         context, SignUpSecondScreen.routeName);
                            //   }
                            // }, child: BlocBuilder<SignupBloc, SignupState>(
                            //   builder: ((context, state) {
                            //     if (state is SignupInProgress) {
                            //       Future.delayed(Duration.zero, () {
                            //         showdialog(context);
                            //       });
                            //     } else if (state is SignupFailed) {
                            //       Future.delayed(Duration.zero, () {
                            //         Navigator.of(context).pop();
                            //         ScaffoldMessenger.of(context)
                            //           ..removeCurrentSnackBar()
                            //           ..showSnackBar(SnackBar(
                            //             content: Text(state.message),
                            //             backgroundColor: Colors.red,
                            //           ));
                            //       });
                            //     }
                            //     // else if (state is SignupSuccessful) {
                            //     //   return Container();
                            //     // }
                            //     return Container();
                            //   }),
                            // )),
                          })
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
            padding: const EdgeInsets.only(bottom: 30, left: 50),
            child: Row(
              children: const [
                Text(
                  'Let\'s Get Started',
                  style: TextStyle(
                      color: CustomColors.blackColor,
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.insert_emoticon)
              ],
            ),
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
