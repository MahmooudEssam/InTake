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
      onTap: (){
        press;
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => OnboardingPage2()
            ));
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
            Positioned.fill(
              top: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(CupertinoIcons.arrow_right_circle,color: Colors.black,fontWeight: FontWeight.bold,),
                  const SizedBox(width: 8),
                  Text(
                    "Get Started",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800,fontSize: 18),

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