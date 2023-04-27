import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedOutlinedCircle extends StatefulWidget {
  const AnimatedOutlinedCircle({Key? key}) : super(key: key);

  @override
  _AnimatedOutlinedCircleState createState() => _AnimatedOutlinedCircleState();
}

class _AnimatedOutlinedCircleState extends State<AnimatedOutlinedCircle> {
  bool _isSemiOutlined = false;

  void _toggleOutlined() {
    setState(() {
      _isSemiOutlined = !_isSemiOutlined;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleOutlined,
      child: SizedBox(
        width: 100,
        height: 100,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: _isSemiOutlined ? 20 : 40,
              style: _isSemiOutlined ? BorderStyle.none : BorderStyle.solid,
            ),
          ),
          child: CustomPaint(
            painter: _OutlinedCirclePainter(),
          ),
        ),
      ),
    );
  }
}

class _OutlinedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = Offset(radius, radius);
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      pi * 2,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_OutlinedCirclePainter oldDelegate) => false;
}
