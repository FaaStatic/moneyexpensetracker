import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> widthAnim;
  late Animation<double> heightAnim;
  late Animation<double> opacityAnim;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    widthAnim = Tween<double>(begin: 175, end: 350)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    heightAnim = Tween<double>(begin: 175, end: 350)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    opacityAnim = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.addListener(() {
        if (_controller.isCompleted) {
          context.go("/home");
        }
      });
      _controller.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return SizedBox(
                    child: Column(
                      children: [
                        AnimatedOpacity(
                          opacity: opacityAnim.value,
                          duration: const Duration(milliseconds: 500),
                          child: Lottie.asset(
                            "assets/lottie/splash_anim.json",
                            width: widthAnim.value,
                            height: heightAnim.value,
                            repeat: false,
                            frameRate: FrameRate.composition,
                          ),
                        ),
                        const Gap(16),
                        Text(
                          "Money Expenses Tracker",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: HexColor("#1B4242"),
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
