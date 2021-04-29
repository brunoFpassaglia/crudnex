import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController animationController = AnimationController(
    duration: const Duration(seconds: 8),
    vsync: this,
  )..repeat();
  double angle = 20;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
            angle: angle * animationController.value,
            child: child,
          );
        },
        child: Center(
          child: Container(
            child: Image.asset('lib/assets/nexlogo.png'),
          ),
        ),
      ),
    );
  }
}
