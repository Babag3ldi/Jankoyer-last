import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jankoyer/const/colors.dart';

import '../widgets/navbar_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 1),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const NavBarHome())));
  }

  @override
  Widget build(BuildContext context) {
    double sizeWidth = MediaQuery.of(context).size.width / 100;
    double sizeHeight = MediaQuery.of(context).size.height / 100;
    return Scaffold(
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              Image.asset('assets/images/logo2.png',
                  height: sizeHeight * 50,
                  width: sizeWidth * 80,
                  fit: BoxFit.cover),
              const Spacer(),
              const SpinKitCircle(color: AppColors.primary),
              const Spacer(),
              const Text('Powered by Pikir.',
                  style: TextStyle(color: Colors.white)),
              const SizedBox(height: 20)
            ]),
      ),
    );
  }
}
