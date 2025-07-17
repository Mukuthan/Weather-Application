import 'package:flutter/material.dart';

class LimitOver extends StatelessWidget {
  const LimitOver({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Center(
          child: Text(
            "Today API's limit over try tomorrow",
            style: TextStyle(color: Colors.black, fontSize: 10),
          ),
        ),
      ),
    );
  }
}

class Error extends StatelessWidget {
  const Error({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Center(
          child: Text(
            "Some Error Occured Try again later / send report to the developer",
            style: TextStyle(color: Colors.black, fontSize: 10),
          ),
        ),
      ),
    );
  }
}
