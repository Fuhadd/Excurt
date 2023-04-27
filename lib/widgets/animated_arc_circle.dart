import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../screens/startup/welcome_screen.dart';

class AnimatedArc extends StatefulWidget {
  const AnimatedArc({required this.pageController, Key? key}) : super(key: key);
  final PageController pageController;

  @override
  _AnimatedArcState createState() => _AnimatedArcState();
}

class _AnimatedArcState extends State<AnimatedArc> {
  int _currentStop = 2; // starting at smallest stop
  int _lastPage = 0;
  final List<double> _stops = [0.3, 0.65, 1.0];

  void _incrementStop() {
    setState(() {
      _lastPage = _lastPage + 1;
      print(_lastPage);
      _currentStop = (_currentStop + 1) % _stops.length;
      widget.pageController.animateToPage(
        widget.pageController.page!.round() + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.decelerate,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _lastPage < 2
          ? _incrementStop
          : () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WelcomeScreen()));
            },
      child: SizedBox(
        width: 75,
        height: 75,
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(
            begin: _currentStop == 2
                ? 0
                : _stops[_currentStop], // starting at current stop value
            end: _stops[(_currentStop + 1) % _stops.length],
          ),
          duration: const Duration(milliseconds: 500),
          builder: (context, value, child) {
            return CustomPaint(
              painter: _ArcPainter(value * math.pi * 2),
            );
          },
        ),
      ),
    );
  }
}

class _ArcPainter extends CustomPainter {
  final double sweepAngle;

  _ArcPainter(this.sweepAngle);

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    final center = Offset(radius, radius);
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_ArcPainter oldDelegate) =>
      sweepAngle != oldDelegate.sweepAngle;
}
