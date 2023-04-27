import 'dart:convert';
import 'dart:io';

import 'package:escurt/Constants/custom_colors.dart';
import 'package:escurt/models/images_api_response.dart';
import 'package:escurt/screens/register/signup_interest_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '../../utils/spacers.dart';
import '../../widgets/custom_button.dart';
import 'signup_view_model.dart';

// import 'package:step_progress_indicator/step_progress_indicator.dart';

class SignupImageScreen extends StatefulHookConsumerWidget {
  static const routeName = '/signupImageScreen';

  const SignupImageScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupImageScreen> createState() => _SignupImageScreenState();
}

class _SignupImageScreenState extends ConsumerState<SignupImageScreen> {
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

  Future<UserImageResponseModel?> _pickImage(
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
      return UserImageResponseModel(id: signUpVM.userImageId, image: imageFile);
      // return imageFile;
    }
    return null;
  }

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
                      "Add Your photos",
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
                      "Your photos will be displayed on your profile",
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
                      left: 20,
                      right: 20,
                      bottom: 40,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ImageContainer(
                              imageFile: _imageFile1,
                              onTap: () async {
                                var image =
                                    await _pickImage(_imageFile1, signUpVM);
                                _imageFile1 = image!.image;
                                _imageId1 = image.id;
                              },
                              onRemoveTap: () async {
                                await signUpVM.deleteUserImage(_imageId1!);
                                setState(() {
                                  _imageFile1 = null;
                                });
                              },
                            ),
                            horizontalSpacer(10),
                            ImageContainer(
                              imageFile: _imageFile2,
                              onTap: () async {
                                var image =
                                    await _pickImage(_imageFile2, signUpVM);
                                _imageFile2 = image!.image;
                                _imageId2 = image.id;
                              },
                              onRemoveTap: () async {
                                await signUpVM.deleteUserImage(_imageId2!);
                                setState(() {
                                  _imageFile2 = null;
                                });
                              },
                            ),
                            horizontalSpacer(10),
                            ImageContainer(
                              imageFile: _imageFile3,
                              onTap: () async {
                                var image =
                                    await _pickImage(_imageFile3, signUpVM);

                                _imageFile3 = image!.image;
                                _imageId3 = image.id;
                              },
                              onRemoveTap: () async {
                                await signUpVM.deleteUserImage(_imageId3!);
                                setState(() {
                                  _imageFile3 = null;
                                });
                              },
                            ),
                            horizontalSpacer(10),
                          ],
                        ),
                        verticalSpacer(10),
                        Row(
                          children: [
                            ImageContainer(
                              imageFile: _imageFile4,
                              onTap: () async {
                                var image =
                                    await _pickImage(_imageFile4, signUpVM);

                                _imageFile4 = image!.image;
                                _imageId4 = image.id;
                              },
                              onRemoveTap: () async {
                                await signUpVM.deleteUserImage(_imageId4!);
                                setState(() {
                                  _imageFile4 = null;
                                });
                              },
                            ),
                            horizontalSpacer(10),
                            ImageContainer(
                              imageFile: _imageFile5,
                              onTap: () async {
                                var image =
                                    await _pickImage(_imageFile5, signUpVM);

                                _imageFile5 = image!.image;
                                _imageId5 = image.id;
                              },
                              onRemoveTap: () async {
                                await signUpVM.deleteUserImage(_imageId5!);
                                setState(() {
                                  _imageFile5 = null;
                                });
                              },
                            ),
                            horizontalSpacer(10),
                            ImageContainer(
                              imageFile: _imageFile6,
                              onTap: () async {
                                var image =
                                    await _pickImage(_imageFile6, signUpVM);

                                _imageFile6 = image!.image;
                                _imageId6 = image.id;
                              },
                              onRemoveTap: () async {
                                await signUpVM.deleteUserImage(_imageId6!);
                                setState(() {
                                  _imageFile6 = null;
                                });
                              },
                            ),
                            horizontalSpacer(10),
                          ],
                        ),
                        verticalSpacer(50),
                        CustomButton(
                          color: CustomColors.mainPinkColor,
                          isLoading: signUpVM.isLoading,
                          title: 'Continue',
                          onTap: () {
                            if ([
                                  _imageFile1,
                                  _imageFile2,
                                  _imageFile3,
                                  _imageFile4,
                                  _imageFile5,
                                  _imageFile6
                                ].where((file) => file != null).length >=
                                2) {
                              Navigator.of(context)
                                  .pushNamed(SignupInterestScreen.routeName);
                              // Navigate to the next screen
                            } else {
                              // Show an error message or take some other action
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(const SnackBar(
                                  content: Text(
                                      "Please Upload at least 2 Images to continue"),
                                  backgroundColor: Colors.red,
                                ));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
        Visibility(
          visible: signUpVM.isImageLoading,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: Lottie.asset(
                "assets/animations/flower_loading.json",
                height: 150,
                animate: true,
                repeat: true,
                reverse: false,
                // fit: BoxFit.contain,
              ),
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
