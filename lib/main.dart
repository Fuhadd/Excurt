import 'package:escurt/screens/onboarding/onboarding_page_view.dart';
import 'package:escurt/utils/environment_config.dart';
import 'package:escurt/utils/navigator_handler.dart';
import 'package:escurt/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'firebase_options.dart';
import 'globals.dart';
import 'locator.dart';
import 'style/custom_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await loadEnvFile(path: ".env.dev");
  await dotenv.load(fileName: ".env.dev");
  await setupLocator();
  Global.environmentVariables = EnvironmentVariables(
    apiBaseUrl: dotenv.env['BASE_URL']!,
    clientKey: dotenv.env['CLIENT_KEY'] ?? "654321",
    versionName: dotenv.env['VERSION_NAME']!,
    agent: dotenv.env['AGENT_ID'] ?? "flutter_mobile",
    apiTimeoutInSeconds: int.parse(dotenv.env['API_TIMEOUT_IN_SECONDS']!),
    tokenValidityInMinutes: int.parse(dotenv.env['TOKEN_VALIDITY_IN_MINUTES']!),
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: appRoutes,
      navigatorKey: locator<NavigationHandler>().navigatorKey,
      title: 'Excurt',
      theme: AppTheme.defaultAppTheme,
      // home: const DashboardScreen(),
      home: const OnboardingPageView(),
    );
  }
}
