import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shop_com_admin_web/data/config/app_config.dart';
import 'package:shop_com_admin_web/providers/auth_provider.dart';

import '../../../utils/widgets/input_form_widget.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: getValueForScreenType(context: context, mobile: 1, desktop: 0.4, tablet: 0.8),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Email field
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InputForm(
                            labelText: 'Email',
                            prefixIcon: const Icon(Icons.email_outlined),
                            suffixIcon: const Icon(Icons.check, color: Colors.green),
                            hintText: 'anhtu@gmail.com',
                            onSaved: (newValue) {
                              _email = newValue.toString();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter email";
                              } else {
                                return null;
                              }
                            }),
                        const SizedBox(height: 20),
                        // Password field
                        InputForm(
                          obscureText: true,
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          onSaved: (newValue) {
                            _password = newValue.toString();
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter password";
                            } else {
                              return null;
                            }
                          },
                        ),
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
                            onPressed: _onLogin,
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
                      ],
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
          ),
        ),
      ),
    );
  }

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    final user = await userController.login(_email, _password);
    if (mounted && user != null && user.isAdmin == true) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Login success"),
        backgroundColor: Colors.green,
      ));
      reloadApiUrl();
      if (mounted) {
        context.goNamed("home", extra: true);
      }
      // Future.microtask(() => context.go("/tab1"));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Login failed"),
        backgroundColor: Colors.red,
      ));
    }
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
