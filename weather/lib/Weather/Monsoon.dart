import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';

class ThunderStormBackground extends StatelessWidget {
  const ThunderStormBackground({super.key});

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
          // You might have multiple RainDropWidgets animated or positioned
          Align(alignment: Alignment.topCenter, child: ThunderWidget()),
          Align(alignment: Alignment.topLeft, child: ThunderWidget()),
          Align(alignment: Alignment.topRight, child: ThunderWidget()),
          Positioned(
            bottom: 660,
            left: 90,
            child: Icon(Icons.flash_on, size: 50, color: Colors.yellowAccent),
          ),
          Positioned(
            bottom: 635,
            right: 45,
            child: Icon(Icons.cloud, size: 150, color: Colors.white70),
          ),
          Positioned(
            bottom: 600,
            right: 90,
            child: Icon(Icons.flash_on, size: 50, color: Colors.yellowAccent),
          ),
        ],
      ),
    );
  }
}

class RainySky extends StatelessWidget {
  const RainySky({super.key});

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
          Align(alignment: Alignment.topCenter, child: CloudWidget()),
          Align(
            alignment: Alignment.topLeft, // Or any other alignment
            child: RainWidget(), // This could be a full-screen rain effect
          ),
          Align(
            alignment: Alignment.topRight, // Or any other alignment
            child: RainWidget(), // This could be a full-screen rain effect
          ),
          // You might have multiple RainDropWidgets animated or positioned
        ],
      ),
    );
  }
}

class Storm extends StatelessWidget {
  const Storm({super.key});

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
            alignment: Alignment.center, // Or any other alignment
            child: RainWidget(), // This could be a full-screen rain effect
          ),
          Align(
            alignment: Alignment.centerRight, // Or any other alignment
            child: RainWidget(), // This could be a full-screen rain effect
          ),
          Align(
            alignment: Alignment.centerLeft, // Or any other alignment
            child: RainWidget(), // This could be a full-screen rain effect
          ),
          Align(alignment: Alignment.topCenter, child: ThunderWidget()),
          Positioned(
            bottom: 660,
            left: 90,
            child: Icon(Icons.flash_on, size: 50, color: Colors.yellowAccent),
          ),
          Positioned(
            bottom: 635,
            right: 45,
            child: Icon(Icons.cloud, size: 150, color: Colors.white70),
          ),
          Positioned(
            bottom: 600,
            right: 90,
            child: Icon(Icons.flash_on, size: 50, color: Colors.yellowAccent),
          ),
        ],
      ),
    );
  }
}

class CloudySky extends StatelessWidget {
  const CloudySky({super.key});

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
      child: Stack(children: [Align(child: CloudyWeather())]),
    );
  }
}

class CloudyWeather extends StatelessWidget {
  const CloudyWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: CloudyScene(),
        backgroundColor: Colors.lightBlue[300],
      ),
    );
  }
}

class CloudyScene extends StatefulWidget {
  const CloudyScene({super.key});

  @override
  _CloudySceneState createState() => _CloudySceneState();
}

class _CloudySceneState extends State<CloudyScene>
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
            Colors.grey, // Dark grey clouds
            Colors.black54,
            Colors.black54,
            Colors.blueGrey, // Moody blue-grey
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
            child: Icon(Icons.cloud, size: 220, color: Colors.white70),
          ),

          Positioned(
            top: 85,
            left: 20,
            child: Icon(Icons.cloud, size: 220, color: Colors.white70),
          ),

          Align(alignment: Alignment.topLeft, child: WindWidget()),
          Align(alignment: Alignment.topCenter, child: WindWidget()),
          Align(alignment: Alignment.topLeft, child: WindWidget()),
          Align(alignment: Alignment.centerLeft, child: WindWidget()),
          Align(alignment: Alignment.center, child: WindWidget()),
          Align(alignment: Alignment.centerLeft, child: WindWidget()),
          // Optional: Add clouds or birds here
        ],
      ),
    );
  }
}
