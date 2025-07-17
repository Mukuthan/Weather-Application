import 'package:flutter/material.dart';

class SunnySky extends StatelessWidget {
  const SunnySky({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.lightBlueAccent, Colors.white],
        ),
      ),
      child: Stack(children: [Align(child: SunnyWeatherApp())]),
    );
  }
}

class SunnyWeatherApp extends StatelessWidget {
  const SunnyWeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SunnyScene(),
        backgroundColor: Colors.lightBlue[300],
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SunnyScene extends StatefulWidget {
  const SunnyScene({super.key});

  @override
  _SunnySceneState createState() => _SunnySceneState();
}

class _SunnySceneState extends State<SunnyScene>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat(); // Continuous rotation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildSun() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * 3.1416,
          child: child,
        );
      },
      child: Container(
        width: 160,
        height: 160,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const RadialGradient(
            colors: [Colors.yellowAccent, Colors.orange],
            center: Alignment.center,
            radius: 0.8,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.yellow.withOpacity(0.6),
              blurRadius: 40,
              spreadRadius: 20,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Sky background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blueAccent,
                Colors.lightBlue,
                Colors.lightBlueAccent,
                Color(0xff87ceeb),
                Color(0xfffefcea),
              ],
            ),
          ),
        ),

        // Sun
        Positioned(
          top: 100,
          left: MediaQuery.of(context).size.width / 2 - 80,
          child: _buildSun(),
        ),

        // Optional: Add clouds or birds here
      ],
    );
  }
}
