import 'package:flutter/material.dart';
import 'package:practica_2/src/screens/login-screen.dart';
import 'package:practica_2/src/utils/colors_settings.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: LoginScreen(),
      duration: 2000,
      //imageSrc: 'assets/logo',
      //imageSize: 150,
      text: 'Welcome Welcome...',
      backgroundColor: ColorSettings.colorPrimary,
      textType: TextType.ColorizeAnimationText,
      colors: [
        Colors.blue,
        Colors.green,
        Colors.orange,
        Colors.red,
      ],
    );
  }
}
