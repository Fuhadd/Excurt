import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
    this.color,
    this.size = 30,
  });
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitDoubleBounce(
      color: color ?? Colors.white,
      size: size,
    ));
  }
}
