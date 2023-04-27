import 'package:flutter/material.dart';

class MyAnimatedCircle extends StatefulWidget {
  const MyAnimatedCircle({super.key});

  @override
  _MyAnimatedCircleState createState() => _MyAnimatedCircleState();
}

class _MyAnimatedCircleState extends State<MyAnimatedCircle> {
  bool _isQuarterSize = true;

  void _toggleSize() {
    setState(() {
      _isQuarterSize = !_isQuarterSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSize,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: _isQuarterSize
            ? MediaQuery.of(context).size.width / 8
            : MediaQuery.of(context).size.width / 4,
        height: _isQuarterSize
            ? MediaQuery.of(context).size.width / 8
            : MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
