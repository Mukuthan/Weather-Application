import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

class Snow extends StatelessWidget {
  const Snow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.lightBlue,
            Colors.lightBlueAccent,
            Colors.lightBlueAccent,
            Colors.white,
          ],
        ),
      ),
      child: Stack(
        children: [
          Align(alignment: Alignment.topCenter, child: CloudWidget()),
          Align(alignment: Alignment.topLeft, child: SnowWidget()),
          Align(alignment: Alignment.center, child: SnowWidget()),
          Align(alignment: Alignment.topRight, child: SnowWidget()),
        ],
      ),
    );
  }
}

class SnowScene extends StatefulWidget {
  const SnowScene({super.key});
  @override
  State<SnowScene> createState() => _SnowSceneState();
}

class _SnowSceneState extends State<SnowScene>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Snowflake> _flakes = List.generate(100, (_) => Snowflake());

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    _controller.addListener(() {
      for (final flake in _flakes) {
        flake.update();
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightBlue,
              Colors.lightBlueAccent,
              Colors.lightBlueAccent,
              Colors.white,
            ],
          ),
        ),
        child: Stack(
          children: [
            CustomPaint(painter: SnowPainter(_flakes), child: Container()),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class Snowflake {
  double x = Random().nextDouble() * window.physicalSize.width;
  double y = Random().nextDouble() * window.physicalSize.height;
  double radius = Random().nextDouble() * 4 + 2;
  double speed = Random().nextDouble() * 2 + 1;

  void update() {
    y += speed;
    if (y > window.physicalSize.height) {
      y = -radius;
      x = Random().nextDouble() * window.physicalSize.width;
    }
  }
}

class SnowPainter extends CustomPainter {
  final List<Snowflake> flakes;
  SnowPainter(this.flakes);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.8);
    for (final flake in flakes) {
      canvas.drawCircle(Offset(flake.x, flake.y), flake.radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
