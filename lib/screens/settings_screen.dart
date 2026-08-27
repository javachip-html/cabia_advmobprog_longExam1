import 'package:flutter/material.dart';
import '../providers/theme_provider.dart';
import '../services/user_service.dart';
import 'signin_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _themeProvider = ThemeProvider.instance;
  final _userService = UserService();

  @override
  void initState() {
    super.initState();
    _themeProvider.load();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _themeProvider,
      builder: (context, _) => Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: ListView(
          children: [
            SwitchListTile(
              title: const Text('Dark mode'),
              subtitle: const Text('Use a darker color theme'),
              value: _themeProvider.isDark,
              onChanged: _themeProvider.setDarkMode,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Sign Out'),
              onTap: () async {
                final navigator = Navigator.of(context);
                await _userService.signOut();
                if (!mounted) return;
                navigator.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const SignInScreen()),
                  (_) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}