import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:intake/core/theme/appPalette.dart';
import 'package:intake/features/auth/presentation/pages/signup_page.dart';
import 'package:intake/features/lang_model_connection/chatBot_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _coffeeController;
  bool copAnimated = false;
  bool animateCafeText = false;

  @override
  void initState() {
    super.initState();
    _coffeeController = AnimationController(vsync: this);
    _coffeeController.addListener(() {
      if (_coffeeController.value > 0.7) {
        _coffeeController.stop();
        copAnimated = true;
        setState(() {});
        Future.delayed(const Duration(seconds: 1), () {
          animateCafeText = true;
          setState(() {});
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _coffeeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppPallete.backgroundColor,
      body: Stack(
        children: [
          // White Container top half
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            height: copAnimated ? screenHeight / 1.9 : screenHeight,
            decoration: BoxDecoration(
              color: AppPallete.backgroundColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(copAnimated ? 40.0 : 0.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Visibility(
                  visible: !copAnimated,
                  child: Lottie.asset(
                    'assets/lottie/Active lifestyle and healthy food.json',
                    controller: _coffeeController,
                    onLoaded: (composition) {
                      _coffeeController
                        ..duration = composition.duration
                        ..forward();
                    },
                  ),
                ),
                Visibility(
                  visible: copAnimated,
                  child: Image.asset(
                    'assets/logos/intakeLogo_with_barcode.png',
                    height: 190.0,
                    width: 190.0,
                  ),
                ),
                Center(
                  child: AnimatedOpacity(
                    opacity: animateCafeText ? 1 : 0,
                    duration: const Duration(seconds: 1),
                    child: const Text(
                      'Your Health Companion',
                      style: TextStyle(fontSize: 30.0, color: AppPallete.whiteColor),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Text bottom part
          Visibility(visible: copAnimated, child: const _BottomPart()),
        ],
      ),
    );
  }
}

class _BottomPart extends StatelessWidget {
  const _BottomPart();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Cravings are Healthy',
              style: TextStyle(
                fontSize: 27.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 30.0),

            Text(
              'Your guide to find healthier option. '
                  'Customized food plans suitable for your goal & health condition.',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.white.withOpacity(0.8),
                height: 1.5,
              ),
            ),

            const SizedBox(height: 40.0),

            /// 👉 Button aligned to the right
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SignUpPage(),
                    ),
                  );
                },
                child: Container(
                  height: 85.0,
                  width: 85.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                  child: const Icon(
                    Icons.chevron_right,
                    size: 50.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}
