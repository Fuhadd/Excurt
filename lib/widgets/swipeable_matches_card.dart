import 'package:escurt/models/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../Constants/custom_colors.dart';
import '../models/user_images_response.dart';
import '../screens/discover/discover_view_model.dart';
import '../utils/spacers.dart';

class SwipeableMatchesCard extends StatefulWidget {
  const SwipeableMatchesCard(
      {super.key,
      required this.name,
      required this.age,
      required this.images,
      required this.discoverVM,
      required this.user,
      required this.pageNumber,
      required this.ref});
  final String name;
  final String age;
  final List<UserImageResponseModel> images;
  final DiscoverViewModel discoverVM;
  final UserDataModel user;
  final WidgetRef ref;
  final int pageNumber;

  @override
  State<SwipeableMatchesCard> createState() => _SwipeableMatchesCardState();
}

class _SwipeableMatchesCardState extends State<SwipeableMatchesCard> {
  int _currentIndex = 0;

  void _nextImage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.images.length;
    });
  }

  void _prevImage() {
    setState(() {
      _currentIndex =
          (_currentIndex - 1 + widget.images.length) % widget.images.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTapUp: (TapUpDetails details) {
          // Determine which side of the container was tapped
          double width = MediaQuery.of(context).size.width;
          double tapX = details.globalPosition.dx;
          if (tapX < width / 2) {
            _prevImage();
          } else {
            _nextImage();
          }
        },
        // image:
        //  imag(
        //     "https://firebasestorage.googleapis.com/v0/b/palata-2dbc5.appspot.com/o/istockphoto-1296271163-612x612%20(2).jpg?alt=media&token=44082fee-75ef-4a03-91ec-dacf2dfb34c1"),
        // image: MemoryImage(base64.decode(widget.images[0].base64)),
        // image: AssetImage("assets/images/profile_image.png"),
        // fit: BoxFit.cover,
        // placeholder: (context, url) => Image.asset(
        //   'assets/images/placeholder.png',
        //   fit: BoxFit.cover,
        // ),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                height: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: FadeInImage(
                    placeholder:
                        const AssetImage('assets/images/female_icon.png'),
                    image: NetworkImage(
                      widget.images[_currentIndex].imageUrl,
                    ),
                    // 'https://firebasestorage.googleapis.com/v0/b/palata-2dbc5.appspot.com/o/istockphoto-1296271163-612x612%20(2).jpg?alt=media&token=44082fee-75ef-4a03-91ec-dacf2dfb34c1'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 25, left: 25),
                      child: StepProgressIndicator(
                        padding: 3,
                        totalSteps: widget.images.length,
                        currentStep: _currentIndex + 1,
                        selectedColor: CustomColors.whiteColor,
                        unselectedColor: CustomColors.stepIndicatorGrey,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(40),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 25, left: 25, bottom: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  // "Ratna" ", ",
                                  "${widget.name} ",
                                  style: const TextStyle(
                                      color: CustomColors.whiteColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 30),
                                ),
                                Text(
                                  widget.age,
                                  //"22",
                                  style: const TextStyle(
                                      color: CustomColors.whiteColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 30),
                                ),
                                horizontalSpacer(10),
                                SvgPicture.asset(
                                  'assets/icons/verified_icon.svg',
                                  // height: 25,
                                  // color: CustomColors.navBarGrey
                                ),
                              ],
                            ),
                            verticalSpacer(10),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_pin,
                                  color: CustomColors.locationIconGrey,
                                ),
                                horizontalSpacer(5),
                                const Text(
                                  "Lagos",
                                  style: TextStyle(
                                      color: CustomColors.stepIndicatorGrey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                                horizontalSpacer(3),
                                const Text(
                                  "10km",
                                  style: TextStyle(
                                      color: CustomColors.stepIndicatorGrey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            verticalSpacer(20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 5,
                                          blurRadius: 10,
                                          offset: const Offset(0, 0),
                                        ),
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/icons/dislike_icon.svg',
                                        // height: 25,
                                        // color: CustomColors.navBarGrey
                                      ),
                                    ),
                                  ),
                                ),
                                horizontalSpacer(30),
                                GestureDetector(
                                  onTap: () {
                                    widget.discoverVM.likeUser(
                                        pageNumber: widget.pageNumber,
                                        likedUserId: widget.user.id,
                                        ref: widget.ref);
                                  },
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: CustomColors.mainPinkColor
                                              .withOpacity(0.3),
                                          spreadRadius: 5,
                                          blurRadius: 10,
                                          offset: const Offset(0, 0),
                                        ),
                                      ],
                                      color: CustomColors.mainPinkColor,
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/icons/match_icon.svg',
                                        // height: 25,
                                        // color: CustomColors.navBarGrey
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
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
