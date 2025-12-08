import 'package:flutter/material.dart';
import 'package:intake/core/theme/appPalette.dart';
import '../widgets/auth_field.dart';
import '../widgets/auth_gradient_button.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => signup_page_State();
}

class signup_page_State extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/logos/intakeLogo_with_barcode.png",
            width: 200,
              height: 200,
            ),
            Text("Sign Up", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 50
            ),),
            SizedBox(height: 30,),
            AuthField(hintText: "Name"),
            SizedBox(height: 15,),
            AuthField(hintText: "Email"),
            SizedBox(height: 15,),
            AuthField(hintText: "Password"),
            SizedBox(height: 15,),
            AuthField(hintText: "Confirm Password"),
            SizedBox(height: 20,),
            AuthGradientButton(),
            SizedBox(height: 20,),
            RichText( text:
            TextSpan(
                text: "Already have an account? ",
              style: Theme.of(context).textTheme.titleMedium,
              children: [
                TextSpan(
                  text: "Sign In",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppPallete.gradient2,
                    fontWeight: FontWeight.bold
                  ),
                )
                ]

            ),

            )
          ],
        ),
      ),
    );
  }
}
