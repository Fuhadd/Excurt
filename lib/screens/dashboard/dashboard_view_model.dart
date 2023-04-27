import 'package:hooks_riverpod/hooks_riverpod.dart';

final indexProvider = StateProvider.autoDispose<int>((ref) => 1);
