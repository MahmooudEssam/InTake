import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intake/features/onboardingTwo/presentation/onboardingTwo.dart';
import 'package:rive/rive.dart';

class AnimatedBtn extends StatelessWidget {
  const AnimatedBtn({
    super.key,
    required RiveAnimationController btnAnimationController,
    required this.press,
  }) : _btnAnimationController = btnAnimationController;

  final RiveAnimationController _btnAnimationController;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 1. Trigger the animation (Important: use parentheses to execute it)
        press();

        // 2. Wait a split second so the user sees the animation play
        Future.delayed(const Duration(milliseconds: 800), () {
          // 3. Navigate to the next page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OnboardingPage2(),
            ),
          );
        });
      },
      child: SizedBox(
        height: 64,
        width: 236,
        child: Stack(
          children: [
            RiveAnimation.asset(
              "assets/RiveAssets/button.riv",
              controllers: [_btnAnimationController],
            ),
            const Positioned.fill(
              top: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.arrow_right,
                    color: Colors.black,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Get Started",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 18
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}