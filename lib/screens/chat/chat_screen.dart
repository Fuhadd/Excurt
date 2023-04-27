import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../register/signup_view_model.dart';

class ChatScreen extends StatefulHookConsumerWidget {
  static const routeName = '/ChatScreen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final signUpVM = ref.watch(signupProvider);
    return const Scaffold(
        extendBodyBehindAppBar: true,
        body: Center(
          child: Text("Chat"),
        ));
  }
}
