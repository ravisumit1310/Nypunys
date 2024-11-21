import 'package:flutter/material.dart';

class ErrorAnimation extends StatefulWidget {
  const ErrorAnimation({super.key});

  @override
  State<ErrorAnimation> createState() => _ErrorAnimationState();
}

class _ErrorAnimationState extends State<ErrorAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
      reverseDuration: Duration(seconds: 2),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned(
            bottom: height * 0.05,
            right: height * 0.16,
            child: AnimatedBuilder(
              animation: controller,
              child: Image.asset(
                'assets/images/lightray.png',
                height: height * 0.15,
              ),
              builder: (context, widget) {
                return Transform.rotate(
                  angle: controller.value * (-5 * 3.14159 / 6 + 3.14159 / 1.5) -
                      (3.14159 / 3),
                  alignment: Alignment.bottomCenter,
                  child: widget,
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            right: height * 0.02,
            child: Image.asset(
              "assets/images/erroricon.png",
              width: height / 4.6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'No file found',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  Text(
                    'No data',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
