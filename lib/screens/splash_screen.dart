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
  void initState() {
    super.initState();
    _openNextScreen();
  }

  Future<void> _openNextScreen() async {
    final result = await Future.wait<Object?>([
      UserService().currentUser(),
      Future<void>.delayed(const Duration(milliseconds: 1500)),
    ]);
    final user = result.first as dynamic;
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => user == null ? const SignInScreen() : const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.primary,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 104,
              height: 104,
              decoration: BoxDecoration(
                color: scheme.onPrimary,
                borderRadius: BorderRadius.circular(26),
              ),
              child: Icon(Icons.people_alt_rounded, size: 58, color: scheme.primary),
            ),
            const SizedBox(height: 24),
            Text(
              APP_NAME,
              style: TextStyle(
                color: scheme.onPrimary,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Connect. Share. Belong.',
              style: TextStyle(color: scheme.onPrimary.withValues(alpha: 0.8)),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: scheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
