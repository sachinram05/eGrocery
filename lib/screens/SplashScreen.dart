import 'dart:async';

import 'package:egrocery/screens/AuthScreen.dart';
import 'package:egrocery/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUserToken();
  }

  Future<void> checkUserToken() async {
    Timer(const Duration(seconds: 2), () async {
      final storedToken = await SharedPreferences.getInstance();
      final token = storedToken.getString('token');
      if (token != null && token.isNotEmpty) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SafeArea(child:  HomeScreen())));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AuthScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SizedBox(
        width: double.infinity,
        height: double.infinity,
        child:  Center(
        child: Image.asset('assets/images/splash.png')),
      ),
    );
  }
}
