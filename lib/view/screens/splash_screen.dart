import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_reciepe_app/config/routes/routes.dart';
import 'package:food_reciepe_app/consant/use_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, RoutesName.home);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UseColors.textColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text(
              'Food Recipe App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color:UseColors.backgroundColor,
              ),
            ),
            const SizedBox(height: 10),
             CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(UseColors.backgroundColor),
            ),
          ],
        ),
      ),
    );
  }
}
