import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../widgets/input_form_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreen();
}

class _SignupScreen extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            // Back button
            // IconButton(
            //   icon: const Icon(Icons.arrow_back),
            //   onPressed: () {},
            // ),
            // Title
            Center(
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            // Email field
            InputForm(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email_outlined),
                suffixIcon: const Icon(Icons.check, color: Colors.green),
                hintText: 'anhtu@gmail.com'),
            const SizedBox(height: 20),
            // Password field
            InputForm(
                obscureText: true,
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline)),
            const SizedBox(height: 10),
            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Forgot your password?",
                        style: TextStyle(color: Colors.black87)),
                    Icon(Icons.arrow_right_alt, color: Colors.red),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("LOGIN",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
            const SizedBox(height: 30),
            // Or login with
            const Center(child: Text("Or auth with social account")),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _socialButton(FontAwesomeIcons.google, Colors.white),
                const SizedBox(width: 20),
                _socialButton(FontAwesomeIcons.facebook, Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialButton(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
      ),
      child: FaIcon(icon, size: 28, color: Colors.black87),
    );
  }
}
