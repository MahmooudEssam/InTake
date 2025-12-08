import 'package:flutter/material.dart';

import '../../../../core/theme/appPalette.dart';

class AuthGradientButton extends StatelessWidget {
  const AuthGradientButton({super.key});

  @override
  Widget build(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      gradient: const LinearGradient(
          colors: [
            AppPallete.gradient1,
            AppPallete.gradient2,
          ],
        begin: Alignment.topLeft,
        end: Alignment.topRight
      ),
      borderRadius: BorderRadius.circular(7),
    ),

    child: ElevatedButton(
        onPressed: (){},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPallete.transparentColor,
          shadowColor: AppPallete.transparentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          fixedSize: const Size(395, 55),
        ),
        child: Text("Sign Up", style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),),
    ),
  );
  }
}
