import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RefContextModel {
  RefContextModel({
    required this.context,
    required this.ref,
  });

  WidgetRef ref;
  BuildContext context;
}
