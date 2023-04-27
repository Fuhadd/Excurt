import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../register/signup_view_model.dart';

class ProfileScreen extends StatefulHookConsumerWidget {
  static const routeName = '/ProfileScreen';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final signUpVM = ref.watch(signupProvider);
    return const Scaffold(
        extendBodyBehindAppBar: true,
        body: Center(
          child: Text("Profile"),
        ));
  }
}
