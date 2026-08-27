import 'package:flutter/material.dart';
import '../constants.dart';
import '../services/user_service.dart';
import 'splash_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController(text: 'nashuu');
  final _password = TextEditingController(text: 'nashuupass');
  final _service = UserService();
  bool _loading = false;
  String? _error;

  @override
  void dispose() { _username.dispose(); _password.dispose(); super.dispose(); }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _error = null; });
    try {
      await _service.login(_username.text.trim(), _password.text);
      if (mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SplashScreen()));
    } catch (error) {
      if (mounted) setState(() => _error = error.toString().replaceFirst('Exception: ', ''));
    } finally { if (mounted) setState(() => _loading = false); }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Form(
              key: _formKey,
              child: Column(children: [
                Text(APP_NAME, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: APP_PRIMARY, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('Sign in to continue'),
                const SizedBox(height: 32),
                TextFormField(controller: _username, decoration: const InputDecoration(labelText: 'Username', prefixIcon: Icon(Icons.person_outline)), validator: (value) => value == null || value.isEmpty ? 'Enter your username' : null),
                const SizedBox(height: 16),
                TextFormField(controller: _password, obscureText: true, decoration: const InputDecoration(labelText: 'Password', prefixIcon: Icon(Icons.lock_outline)), validator: (value) => value == null || value.isEmpty ? 'Enter your password' : null),
                if (_error != null) Padding(padding: const EdgeInsets.only(top: 16), child: Text(_error!, style: const TextStyle(color: Colors.red))),
                const SizedBox(height: 24),
                SizedBox(width: double.infinity, child: FilledButton(onPressed: _loading ? null : _signIn, child: _loading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Sign In'))),
              ]),
            ),
          ),
        ),
      );
}
