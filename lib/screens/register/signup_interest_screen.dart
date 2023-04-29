import 'dart:convert';
import 'dart:io';

import 'package:escurt/Constants/custom_colors.dart';
import 'package:escurt/models/images_api_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/spacers.dart';
import '../../widgets/custom_button.dart';
import 'signup_view_model.dart';

// import 'package:step_progress_indicator/step_progress_indicator.dart';

class SignupInterestScreen extends StatefulHookConsumerWidget {
  static const routeName = '/signupInterestScreen';

  const SignupInterestScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupInterestScreen> createState() =>
      _SignupInterestScreenState();
}

class _SignupInterestScreenState extends ConsumerState<SignupInterestScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController phoneController = TextEditingController();

  File? _imageFile1;
  File? _imageFile2;
  File? _imageFile3;
  File? _imageFile4;
  File? _imageFile5;
  File? _imageFile6;
  int? _imageId1;
  int? _imageId2;
  int? _imageId3;
  int? _imageId4;
  int? _imageId5;
  int? _imageId6;
  String? _imageId7;
  String? _imageId8;
  String? imageId;
  // String? _base64Image;

  Future<UserImageApiResponseModel?> _pickImage(
      File? imageFile, SignupViewModel signUpVM) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      String base64Image = base64Encode(imageFile!.readAsBytesSync());
      await signUpVM.uploadUserImage(
          pickedFile.name, pickedFile.path, base64Image);
      return UserImageApiResponseModel(
          id: signUpVM.userImageId, image: imageFile);
      // return imageFile;
    }
    return null;
  }

  final List<dynamic> _interests = [
    'Cooking',
    'Sports',
    'Music',
    'Art',
    'Reading',
    'Travel',
  ];

  @override
  Widget build(BuildContext context) {
    final signUpVM = ref.watch(signupProvider);
    return Stack(
      children: [
        Scaffold(
            extendBodyBehindAppBar: true,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const _CustomCurvedBar(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      "Your Interest",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CustomColors.blackColor.withOpacity(0.8),
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  // FormBuilderCheckboxGroup(
                  //   name: 'interests',
                  //   options: const [
                  //     FormBuilderFieldOption(
                  //       value: 'Cooking',
                  //     ),
                  //     FormBuilderFieldOption(value: 'Sports'),
                  //     FormBuilderFieldOption(value: 'Music'),
                  //     FormBuilderFieldOption(value: 'Art'),
                  //     FormBuilderFieldOption(value: 'Reading'),
                  //     FormBuilderFieldOption(value: 'Travel'),
                  //   ],
                  //   wrapSpacing: 20,
                  //   decoration: const InputDecoration(),
                  // ),

                  FormBuilder(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 25,
                        left: 20,
                        right: 20,
                        bottom: 40,
                      ),
                      child: Column(
                        children: [
                          FormBuilderFilterChip(
                            //selectedColor: Colors.pink,
                            maxChips: 6,
                            runSpacing: 10,
                            spacing: 10,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            // backgroundColor: CustomColors.mainPinkColor,
                            checkmarkColor: CustomColors.mainPurpleColor,
                            selectedColor: CustomColors.mainPinkColor,

                            elevation: 10,
                            name: 'interests',
                            options: options,
                            decoration: const InputDecoration(
                              labelStyle: TextStyle(color: Colors.white),
                              hoverColor: Colors.white,
                              floatingLabelStyle: TextStyle(color: Colors.pink),
                              fillColor: Colors.pink,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.pink)),
                            ),
                          ),
                          verticalSpacer(50),
                          CustomButton(
                            color: CustomColors.mainPinkColor,
                            isLoading: signUpVM.isLoading,
                            title: 'Continue',
                            onTap: () {
                              var interests = _formKey
                                  .currentState?.fields['interests']?.value;
                              print(interests);
                              var validate = _formKey.currentState?.validate();
                              if (validate == true) {
                                _formKey.currentState?.save();
                                String userInterests = "";
                                List interests = _formKey
                                    .currentState?.fields['interests']?.value;
                                if (interests.length < 3) {
                                  ScaffoldMessenger.of(context)
                                    ..removeCurrentSnackBar()
                                    ..showSnackBar(const SnackBar(
                                      content: Text(
                                          "Please Select at least 3 Interests to continue"),
                                      backgroundColor: Colors.red,
                                    ));
                                } else {
                                  for (var interest in interests) {
                                    if (userInterests.isNotEmpty) {
                                      userInterests =
                                          "$userInterests-$interest";
                                    } else {
                                      userInterests = "$interest";
                                    }
                                  }
                                  signUpVM.uploadUserInterests(userInterests,
                                      context: context
                                      // ref: ref,
                                      );
                                  print(interests);
                                  print(userInterests);
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
        Visibility(
          visible: signUpVM.isImageLoading,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.imageFile,
    required this.onRemoveTap,
    required this.onTap,
  });

  final File? imageFile;
  final void Function()? onRemoveTap;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 140,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: CustomColors.greyBgColor,
            border: Border.all(
              color: CustomColors.greyTextColor.withOpacity(0.5),
              width: 2,
            )),
        child: imageFile != null
            ? Stack(
                children: [
                  Image.file(
                    imageFile!,
                    fit: BoxFit.cover,
                  ),
                  GestureDetector(
                    onTap: onRemoveTap,
                    child: const Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.remove_circle,
                        size: 30,
                        color: CustomColors.mainPinkColor,
                      ),
                    ),
                  ),
                ],
              )
            : GestureDetector(
                onTap: onTap,
                child: const Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.add_circle,
                    size: 30,
                    color: CustomColors.mainPinkColor,
                  ),
                ),
              ),
      ),
    );
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
              )),
        ),
      ),
    ]);
  }
}

var options = const [
  FormBuilderChipOption(value: 'Football', child: Text('Football')),
  FormBuilderChipOption(value: 'Basketball', child: Text('Basketball')),
  FormBuilderChipOption(value: 'Tennis', child: Text('Tennis')),
  FormBuilderChipOption(value: 'Ice Hockey', child: Text('Ice Hockey')),
  FormBuilderChipOption(value: 'Wrestling', child: Text('Wrestling')),
  FormBuilderChipOption(value: 'Gaming', child: Text('Gaming')),
  FormBuilderChipOption(value: 'Motorsports', child: Text('Motorsports')),
  FormBuilderChipOption(value: 'Bandy', child: Text('Bandy')),
  FormBuilderChipOption(value: 'Rugby', child: Text('Rugby')),
  FormBuilderChipOption(value: 'Skiing', child: Text('Skiing')),
  FormBuilderChipOption(value: 'Shooting', child: Text('Shooting')),
];

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
}
