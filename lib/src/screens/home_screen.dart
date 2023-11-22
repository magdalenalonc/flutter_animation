import 'package:flutter/material.dart';

import '../widgets/cat.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late Animation<double> catAnimation;
  late AnimationController catController;

  @override
  void initState() {
    super.initState();
    catController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    catAnimation = Tween(begin: 0.0, end: 100.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          top: catAnimation.value,
          right: 0.0,
          left: 0.0,
          child: child!,
        );
      },
      child: const Cat(),
    );
  }

  void onTap() {
    if (catController.status == AnimationStatus.completed) {
      // reverse() method is opposite of forward(); form end value to begin
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed) {
      // starting animation method; from begin value to end
      catController.forward();
    }
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Animation!',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: GestureDetector(
        onTap: onTap,
        child: Center(
          child: Stack(
            children: [
              // 1st Widget in Stack is towards the very bottom
              buildBox(),
              // The last Widget in Stack is up the top
              buildCatAnimation(),
            ],
          ),
        ),
      ),
    );
  }
}
