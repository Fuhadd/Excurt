import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:escurt/Constants/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../models/ref_context_request_model.dart';
import '../../models/user_data.dart';
import '../../widgets/swipeable_matches_card.dart';
import 'discover_view_model.dart';

class DiscoverScreen extends StatefulHookConsumerWidget {
  static const routeName = '/DiscoverScreen';

  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends ConsumerState<DiscoverScreen> {
  // final SwipeableCardSectionController swiperController =
  //     SwipeableCardSectionController();
  final swiperController = AppinioSwiperController();

  void removeCurrentUser(WidgetRef ref, UserDataModel user) {
    final userListNotifier = ref.read(discoverMatchesProvider.notifier).state;
    userListNotifier.remove(user);
  }

  @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//   swiperController.; // set the initial index to 2
// });
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    final discoverVM = ref.watch(discoverProvider);
    RefContextModel model = RefContextModel(ref: ref, context: context);
    final initialUsers = ref.watch(discoverMatchesProvider);
    // print("--> Here Here Here");
    // print(ref.watch(discoverMatchesProvider));
    final pageNumber = ref.watch(pageNumberProvider);

    bool isNewPage = ref.read(newPageProvider.notifier).state;
    int currentIndex = ref.read(currentIndexProvider.notifier).state;

    // print(initialUsers[0].userImages);

    if (initialUsers.isNotEmpty) {
      return Padding(
        padding:
            const EdgeInsets.only(bottom: 20.0, top: 10, right: 10, left: 10),
        child: AppinioSwiper(
            controller: swiperController,
            onSwipe: (index, direction) {
              if (direction == AppinioSwiperDirection.left ||
                  direction == AppinioSwiperDirection.right) {
                int matchIndex = ref.read(matchIndexProvider.notifier).state;
                print("--> Here Here Here");
                print(matchIndex);
                print(index);
                ref.read(newPageProvider.notifier).state = false;
              }
            },
            padding: EdgeInsets.zero,
            cardsCount: initialUsers.length,
            cardsBuilder: (BuildContext context, int newIndex) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                currentIndex = newIndex;
                if (isNewPage) {
                  ref.read(matchIndexProvider.notifier).state = newIndex;
                } else {
                  setState(() {
                    currentIndex = ref.read(matchIndexProvider.notifier).state;
                  });

                  // currentIndex =newIndex;
                }
              });

              return Column(
                children: [
                  SwipeableMatchesCard(
                    name: initialUsers[newIndex].firstName,
                    age: initialUsers[newIndex].age.toString(),
                    images: initialUsers[newIndex].userImages,
                    discoverVM: discoverVM,
                    user: initialUsers[0],
                    ref: ref,
                    pageNumber: pageNumber,
                  ),
                ],
              );
            }),
      );
    } else {
      ref.read(pageNumberProvider.notifier).state = 1;
      return FutureBuilder<void>(
          future: DiscoverViewModel.exploreSetup().getUsersForMatching(
              pageNumber: 1, pageSize: 3, ref: ref, context: context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final updatedUsers = ref.watch(discoverMatchesProvider);
              if (updatedUsers.isEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.25),
                  child: Column(
                    children: const [
                      Text(
                        "Still Cooking!",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.blackIconColor),
                      ),
                      Text(
                        "Dollar products are on the way",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.blackIconColor),
                      )
                    ],
                  ),
                );
              } else {
                setState(() {});
                return const SizedBox();
              }
            } else if (snapshot.hasError) {
              String errorMessage = snapshot.error.toString();
              return Center(
                  child: Padding(
                      padding: const EdgeInsets.all(80),
                      child: Text(errorMessage)));
            } else {
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(80),
                child: Lottie.asset(
                  "assets/animations/flower_loading.json",
                  height: 150,
                  animate: true,
                  repeat: true,
                  reverse: false,
                  // fit: BoxFit.contain,
                ),
              ));
            }
          });
    }
    // return allUsersForMatching.when(
    //     loading: () => Center(
    //             child: Padding(
    //           padding: const EdgeInsets.all(80),
    //           child: Center(
    //             child: Lottie.asset(
    //               "assets/animations/flower_loading.json",
    //               height: 150,
    //               animate: true,
    //               repeat: true,
    //               reverse: false,
    //               // fit: BoxFit.contain,
    //             ),
    //           ),
    //         )),
    //     error: (error, stackTrace) => Center(
    //         child: Padding(
    //             padding: const EdgeInsets.all(80), child: Text('$error'))),
    //     data: (allInvestmentProducts) {
    //       final allUsers = ref.watch(discoverMatchesProvider);
    //       if (allUsers.isEmpty) {
    //         return Padding(
    //           padding: EdgeInsets.symmetric(
    //               vertical: MediaQuery.of(context).size.height * 0.25),
    //           child: Column(
    //             children: const [
    //               Text(
    //                 "Still Cooking!",
    //                 style: TextStyle(
    //                     fontSize: 16,
    //                     fontWeight: FontWeight.w500,
    //                     color: CustomColors.blackIconColor),
    //               ),
    //               Text(
    //                 "Dollar products are on the way",
    //                 style: TextStyle(
    //                     fontSize: 16,
    //                     fontWeight: FontWeight.w500,
    //                     color: CustomColors.blackIconColor),
    //               )
    //             ],
    //           ),
    //         );
    //       } else {
    //         return Padding(
    //           padding: const EdgeInsets.only(
    //               bottom: 20.0, top: 10, right: 10, left: 10),
    //           child: Column(
    //             children: [
    //               Expanded(
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                       image: const DecorationImage(
    //                         image:
    //                             AssetImage("assets/images/profile_image.png"),
    //                         fit: BoxFit.cover,
    //                       ),
    //                       borderRadius: BorderRadius.circular(40)),
    //                   child: Padding(
    //                     padding: const EdgeInsets.only(top: 30.0),
    //                     child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         const Padding(
    //                           padding: EdgeInsets.only(right: 25, left: 25),
    //                           child: StepProgressIndicator(
    //                             padding: 3,
    //                             totalSteps: 3,
    //                             currentStep: 1,
    //                             selectedColor: CustomColors.whiteColor,
    //                             unselectedColor: CustomColors.stepIndicatorGrey,
    //                           ),
    //                         ),
    //                         Container(
    //                           decoration: BoxDecoration(
    //                             borderRadius:
    //                                 BorderRadiusDirectional.circular(20),
    //                             gradient: const LinearGradient(
    //                               colors: [
    //                                 Color.fromARGB(200, 0, 0, 0),
    //                                 Color.fromARGB(0, 0, 0, 0),
    //                               ],
    //                               begin: Alignment.bottomCenter,
    //                               end: Alignment.topCenter,
    //                             ),
    //                           ),
    //                           child: Padding(
    //                             padding: const EdgeInsets.only(
    //                                 right: 25, left: 25, bottom: 20),
    //                             child: Column(
    //                               children: [
    //                                 Row(
    //                                   children: [
    //                                     const Text(
    //                                       "Ratna" ", ",
    //                                       style: TextStyle(
    //                                           color: CustomColors.whiteColor,
    //                                           fontWeight: FontWeight.w700,
    //                                           fontSize: 30),
    //                                     ),
    //                                     const Text(
    //                                       "22",
    //                                       style: TextStyle(
    //                                           color: CustomColors.whiteColor,
    //                                           fontWeight: FontWeight.w400,
    //                                           fontSize: 30),
    //                                     ),
    //                                     horizontalSpacer(10),
    //                                     SvgPicture.asset(
    //                                       'assets/icons/verified_icon.svg',
    //                                       // height: 25,
    //                                       // color: CustomColors.navBarGrey
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 verticalSpacer(10),
    //                                 Row(
    //                                   children: [
    //                                     const Icon(
    //                                       Icons.location_pin,
    //                                       color: CustomColors.locationIconGrey,
    //                                     ),
    //                                     horizontalSpacer(5),
    //                                     const Text(
    //                                       "Lagos",
    //                                       style: TextStyle(
    //                                           color: CustomColors
    //                                               .stepIndicatorGrey,
    //                                           fontWeight: FontWeight.w500,
    //                                           fontSize: 14),
    //                                     ),
    //                                     horizontalSpacer(3),
    //                                     const Text(
    //                                       "10km",
    //                                       style: TextStyle(
    //                                           color: CustomColors
    //                                               .stepIndicatorGrey,
    //                                           fontWeight: FontWeight.w500,
    //                                           fontSize: 14),
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 verticalSpacer(20),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Container(
    //                                       width: 70,
    //                                       height: 70,
    //                                       decoration: BoxDecoration(
    //                                         shape: BoxShape.circle,
    //                                         boxShadow: [
    //                                           BoxShadow(
    //                                             color: Colors.grey
    //                                                 .withOpacity(0.3),
    //                                             spreadRadius: 5,
    //                                             blurRadius: 10,
    //                                             offset: const Offset(0, 0),
    //                                           ),
    //                                         ],
    //                                         color: Colors.white,
    //                                       ),
    //                                       child: Center(
    //                                         child: SvgPicture.asset(
    //                                           'assets/icons/dislike_icon.svg',
    //                                           // height: 25,
    //                                           // color: CustomColors.navBarGrey
    //                                         ),
    //                                       ),
    //                                     ),
    //                                     horizontalSpacer(30),
    //                                     Container(
    //                                       width: 70,
    //                                       height: 70,
    //                                       decoration: BoxDecoration(
    //                                         shape: BoxShape.circle,
    //                                         boxShadow: [
    //                                           BoxShadow(
    //                                             color: CustomColors
    //                                                 .mainPinkColor
    //                                                 .withOpacity(0.3),
    //                                             spreadRadius: 5,
    //                                             blurRadius: 10,
    //                                             offset: const Offset(0, 0),
    //                                           ),
    //                                         ],
    //                                         color: CustomColors.mainPinkColor,
    //                                       ),
    //                                       child: Center(
    //                                         child: SvgPicture.asset(
    //                                           'assets/icons/match_icon.svg',
    //                                           // height: 25,
    //                                           // color: CustomColors.navBarGrey
    //                                         ),
    //                                       ),
    //                                     )
    //                                   ],
    //                                 )
    //                               ],
    //                             ),
    //                           ),
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         );
    //       }
    //     });

    // return Padding(
    //   padding:
    //       const EdgeInsets.only(bottom: 20.0, top: 10, right: 10, left: 10),
    //   child: Column(
    //     children: [
    //       Expanded(
    //         child: Container(
    //           decoration: BoxDecoration(
    //               image: const DecorationImage(
    //                 image: AssetImage("assets/images/profile_image.png"),
    //                 fit: BoxFit.cover,
    //               ),
    //               borderRadius: BorderRadius.circular(40)),
    //           child: Padding(
    //             padding: const EdgeInsets.only(top: 30.0),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 const Padding(
    //                   padding: EdgeInsets.only(right: 25, left: 25),
    //                   child: StepProgressIndicator(
    //                     padding: 3,
    //                     totalSteps: 3,
    //                     currentStep: 1,
    //                     selectedColor: CustomColors.whiteColor,
    //                     unselectedColor: CustomColors.stepIndicatorGrey,
    //                   ),
    //                 ),
    //                 Container(
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadiusDirectional.circular(20),
    //                     gradient: const LinearGradient(
    //                       colors: [
    //                         Color.fromARGB(200, 0, 0, 0),
    //                         Color.fromARGB(0, 0, 0, 0),
    //                       ],
    //                       begin: Alignment.bottomCenter,
    //                       end: Alignment.topCenter,
    //                     ),
    //                   ),
    //                   child: Padding(
    //                     padding: const EdgeInsets.only(
    //                         right: 25, left: 25, bottom: 20),
    //                     child: Column(
    //                       children: [
    //                         Row(
    //                           children: [
    //                             const Text(
    //                               "Ratna" ", ",
    //                               style: TextStyle(
    //                                   color: CustomColors.whiteColor,
    //                                   fontWeight: FontWeight.w700,
    //                                   fontSize: 30),
    //                             ),
    //                             const Text(
    //                               "22",
    //                               style: TextStyle(
    //                                   color: CustomColors.whiteColor,
    //                                   fontWeight: FontWeight.w400,
    //                                   fontSize: 30),
    //                             ),
    //                             horizontalSpacer(10),
    //                             SvgPicture.asset(
    //                               'assets/icons/verified_icon.svg',
    //                               // height: 25,
    //                               // color: CustomColors.navBarGrey
    //                             ),
    //                           ],
    //                         ),
    //                         verticalSpacer(10),
    //                         Row(
    //                           children: [
    //                             const Icon(
    //                               Icons.location_pin,
    //                               color: CustomColors.locationIconGrey,
    //                             ),
    //                             horizontalSpacer(5),
    //                             const Text(
    //                               "Lagos",
    //                               style: TextStyle(
    //                                   color: CustomColors.stepIndicatorGrey,
    //                                   fontWeight: FontWeight.w500,
    //                                   fontSize: 14),
    //                             ),
    //                             horizontalSpacer(3),
    //                             const Text(
    //                               "10km",
    //                               style: TextStyle(
    //                                   color: CustomColors.stepIndicatorGrey,
    //                                   fontWeight: FontWeight.w500,
    //                                   fontSize: 14),
    //                             ),
    //                           ],
    //                         ),
    //                         verticalSpacer(20),
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Container(
    //                               width: 70,
    //                               height: 70,
    //                               decoration: BoxDecoration(
    //                                 shape: BoxShape.circle,
    //                                 boxShadow: [
    //                                   BoxShadow(
    //                                     color: Colors.grey.withOpacity(0.3),
    //                                     spreadRadius: 5,
    //                                     blurRadius: 10,
    //                                     offset: const Offset(0, 0),
    //                                   ),
    //                                 ],
    //                                 color: Colors.white,
    //                               ),
    //                               child: Center(
    //                                 child: SvgPicture.asset(
    //                                   'assets/icons/dislike_icon.svg',
    //                                   // height: 25,
    //                                   // color: CustomColors.navBarGrey
    //                                 ),
    //                               ),
    //                             ),
    //                             horizontalSpacer(30),
    //                             Container(
    //                               width: 70,
    //                               height: 70,
    //                               decoration: BoxDecoration(
    //                                 shape: BoxShape.circle,
    //                                 boxShadow: [
    //                                   BoxShadow(
    //                                     color: CustomColors.mainPinkColor
    //                                         .withOpacity(0.3),
    //                                     spreadRadius: 5,
    //                                     blurRadius: 10,
    //                                     offset: const Offset(0, 0),
    //                                   ),
    //                                 ],
    //                                 color: CustomColors.mainPinkColor,
    //                               ),
    //                               child: Center(
    //                                 child: SvgPicture.asset(
    //                                   'assets/icons/match_icon.svg',
    //                                   // height: 25,
    //                                   // color: CustomColors.navBarGrey
    //                                 ),
    //                               ),
    //                             )
    //                           ],
    //                         )
    //                       ],
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
