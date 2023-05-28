import 'package:escurt/utils/spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../Constants/custom_colors.dart';
import '../../components/base_scaffold.dart';
import '../chat/chat_screen.dart';
import '../discover/discover_screen.dart';
import '../explore/explore_screen.dart';
import '../profile/profile_screen.dart';
import 'dashboard_view_model.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);
  static const String routeName = "dashboardScreen";
  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final userData = locator<LocalCache>().getUserData();
    final menuIndex = ref.watch(indexProvider);
    final List<Widget> pages = [
      const ExploreScreen(),
      const DiscoverScreen(),
      const ChatScreen(),
      const ProfileScreen(),
    ];
    return BaseScaffold(
      onWillPop: () async {
        false;
      },
      // backgroundColor: CustomColors.grayBackgroundColor,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        // backgroundColor: CustomColors.scaffoldBackgroundColor,
        // leading: IconButton(
        //   icon: Icon(Icons.schedule_rounded,
        //       color: CustomColors.blackColor, size: ScreenUtil().setSp(30)),
        //   onPressed: () {},
        // ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0, top: 10, bottom: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: CustomColors.greyBgColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  children: [
                    Text(
                      "100",
                      style: TextStyle(
                          color: CustomColors.blackColor.withOpacity(0.9),
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    horizontalSpacer(5),
                    SvgPicture.asset(
                      'assets/icons/coin_icon.svg',
                      height: 25,
                      // color: CustomColors.navBarGrey
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: SvgPicture.asset(
              'assets/icons/notification_icon.svg',
              height: 25,
              // color: CustomColors.navBarGrey
            ),
          ),

          // menuIndex == 1
          //     ? ProductIconButtonWidget(
          //         filter: ProductType.savings.name,
          //         activePage: SavingsProductType.regular.index,
          //       )
          //     : menuIndex == 2
          //         ? ProductIconButtonWidget(
          //             filter: ProductType.investments.name,
          //             activePage: InvestmentProducts.HYISClassic.index,
          //           )
          //         : IconButton(
          //             icon: Icon(Icons.account_circle_outlined,
          //                 color: CustomColors.blackColor,
          //                 size: ScreenUtil().setSp(30)),
          //             onPressed: () {
          //               Navigator.push(context,
          //                   MaterialPageRoute(builder: (context) {
          //                 return const ProfileView();
          //               }));
          //             },
          //           ),
        ],
        title: Text(
          "App Logo/Name Here ",
          style: TextStyle(
              color: CustomColors.blackColor.withOpacity(0.9),
              fontWeight: FontWeight.w600,
              fontSize: 16),
        ),
        // title: Text(
        //   menuIndex == 0
        //       ? "Welcome, ${userData.firstname}"
        //       : menuIndex == 1
        //           ? "Savings"
        //           : menuIndex == 2
        //               ? "Investments"
        //               : menuIndex == 3
        //                   ? "Wallet"
        //                   : "",
        //   style: TextStyle(
        //       fontSize: 18.sp,
        //       fontWeight: FontWeight.w500,
        //       color: CustomColors.blackColor),
        // )
      ),

      bottomNavBar: Row(
        children: [
          Expanded(
            child: Container(
              color: CustomColors.whiteColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  // margin: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    elevation: 0,
                    selectedItemColor: CustomColors.mainPinkColor,
                    unselectedItemColor: const Color.fromARGB(255, 65, 37, 37),
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    selectedFontSize: 14,
                    unselectedFontSize: 13,
                    backgroundColor: CustomColors.whiteColor,
                    // selectedLabelStyle: TextStyle(
                    //   fontSize: 12.sp,
                    //   fontWeight: FontWeight.w500,
                    //   color: CustomColors.deepGoldColor,
                    // ),
                    // unselectedLabelStyle: TextStyle(
                    //   fontSize: 12.sp,
                    //   fontWeight: FontWeight.w500,
                    //   color: CustomColors.grayBackgroundColor,
                    // ),
                    currentIndex: menuIndex,
                    onTap: (i) {
                      ref.read(indexProvider.notifier).state = i;
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          'assets/icons/explore_icon.svg',
                          height: 30,
                          // color: CustomColors.navBarGrey
                        ),
                        label: '',
                        activeIcon: SvgPicture.asset(
                            'assets/icons/explore_icon.svg',
                            height: 32,
                            color: CustomColors.mainPinkColor),
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          'assets/icons/discover_icon.svg',
                          height: 30,
                        ),
                        label: '',
                        activeIcon: SvgPicture.asset(
                            'assets/icons/discover_icon.svg',
                            height: 32,
                            color: CustomColors.mainPinkColor),
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          'assets/icons/message_icon.svg',
                          height: 30,
                        ),
                        label: '',
                        activeIcon: SvgPicture.asset(
                            'assets/icons/message_icon.svg',
                            height: 32,
                            color: CustomColors.mainPinkColor),
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          'assets/icons/profile_icon.svg',
                          height: 30,
                          // color: CustomColors.greyColor
                        ),
                        label: '',
                        activeIcon: SvgPicture.asset(
                            'assets/icons/profile_icon.svg',
                            height: 32,
                            color: CustomColors.mainPinkColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      builder: ((size) {
        return pages[menuIndex];
      }),
    );
  }
}
