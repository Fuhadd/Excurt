import 'package:escurt/screens/onboarding/first_onboarding_page.dart';
import 'package:escurt/screens/onboarding/onboarding_page_view.dart';
import 'package:escurt/screens/onboarding/second_onboarding_page.dart';
import 'package:escurt/screens/onboarding/third_onboarding_page.dart';
import 'package:escurt/screens/register/signup_email_screen.dart';
import 'package:escurt/screens/register/signup_name_screen.dart';
import 'package:escurt/screens/signin/signin_screen.dart';
import 'package:escurt/screens/startup/welcome_screen.dart';

import '../screens/chat/chat_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/discover/discover_screen.dart';
import '../screens/explore/explore_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/register/signup_dob_screen.dart';
import '../screens/register/signup_gender_screen.dart';
import '../screens/register/signup_image_screen.dart';
import '../screens/register/signup_interest_screen.dart';
import '../screens/register/signup_otp_screen.dart';
import '../screens/register/signup_phone_screen.dart';

var appRoutes = {
  WelcomeScreen.routeName: (context) => const WelcomeScreen(),
  OnboardingPageView.routeName: (context) => const OnboardingPageView(),
  FirstOnboardingPage.routeName: (context) => const FirstOnboardingPage(),
  SecondOnboardingPage.routeName: (context) => const SecondOnboardingPage(),
  ThirdOnboardingPage.routeName: (context) => const ThirdOnboardingPage(),
  SigninScreen.routeName: (context) => const SigninScreen(),
  SignupEmailScreen.routeName: (context) => const SignupEmailScreen(),
  SignupNameScreen.routeName: (context) => const SignupNameScreen(),
  SignupPhoneScreen.routeName: (context) => const SignupPhoneScreen(),
  SignupOtpScreen.routeName: (context) => const SignupOtpScreen(),
  SignupDOBScreen.routeName: (context) => const SignupDOBScreen(),
  SignupGenderScreen.routeName: (context) => const SignupGenderScreen(),
  SignupImageScreen.routeName: (context) => const SignupImageScreen(),
  SignupInterestScreen.routeName: (context) => const SignupInterestScreen(),
  DiscoverScreen.routeName: (context) => const DiscoverScreen(),
  ExploreScreen.routeName: (context) => const ExploreScreen(),
  ChatScreen.routeName: (context) => const ChatScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  DashboardScreen.routeName: (context) => const DashboardScreen(),
};
