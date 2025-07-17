import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

class Sky extends StatelessWidget {
  const Sky({super.key});

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
      child: Stack(children: [Align(child: SkyWeather())]),
    );
  }
}

class SkyWeather extends StatelessWidget {
  const SkyWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SunnyScene(),
        backgroundColor: Colors.lightBlue[300],
      ),
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
      child: Stack(
        children: [
          Container(
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
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1565C0), // Dark grey clouds
            Colors.blueGrey, // Moody blue-grey
            Colors.black54,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          // Sky background
          // Sun
          Positioned(
            top: 100,
            left: MediaQuery.of(context).size.width / 2 - 80,
            child: _buildSun(),
          ),

          Positioned(
            top: 110,
            right: 20,
            child: Icon(Icons.cloud, size: 220, color: Colors.white),
          ),
          // Optional: Add clouds or birds here
        ],
      ),
    );
  }
}

class TornadoSky extends StatelessWidget {
  const TornadoSky({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // Consider more thematic colors for a thunderstorm:
          colors: [
            Colors.grey.shade800, // Dark grey clouds
            Colors.blueGrey.shade700, // Moody blue-grey
            Colors.black54, // Darker base
          ],
          // Typical sky gradient direction
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      // Using a Stack to allow weather elements to overlap and be positioned
      // more freely over the gradient background.
      child: const Stack(
        children: [
          // Example positioning:
          Positioned(
            bottom: 650,
            right: 100,
            child: Icon(Icons.cloud, size: 250, color: Colors.white70),
          ),
          Align(
            alignment: Alignment.topCenter, // Or any other alignment
            child: WindWidget(), // This could be a full-screen rain effect
          ),
          Positioned(
            bottom: 635,
            right: 45,
            child: Icon(Icons.cloud, size: 150, color: Colors.white70),
          ),
          Positioned(bottom: 960, left: 10, child: WindWidget()),

          Positioned(bottom: 1000, left: -20, child: WindWidget()),

          Positioned(bottom: 900, left: 0, child: WindWidget()),

          Positioned(bottom: 1020, left: -10, child: WindWidget()),

          Positioned(bottom: 930, left: 20, child: WindWidget()),

          Positioned(bottom: 910, left: -50, child: WindWidget()),

          Positioned(bottom: 930, left: 20, child: WindWidget()),

          Positioned(bottom: 1060, left: -60, child: WindWidget()),
        ],
      ),
    );
  }
}
