import 'package:flutter/material.dart';
import '../constants.dart';
import '../services/user_service.dart';
import 'home_screen.dart';
import 'signin_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() { super.initState(); _openNextScreen(); }

  Future<void> _openNextScreen() async {
    final user = await UserService().currentUser();
    if (!mounted) return;
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => user == null ? const SignInScreen() : const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) => const Scaffold(body: Center(child: CircularProgressIndicator(color: APP_PRIMARY)));
}
