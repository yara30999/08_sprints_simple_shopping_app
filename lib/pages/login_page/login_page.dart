import 'package:flutter/material.dart';
import '../../resources/routes_manager.dart';
import 'widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    if (!value[0].contains(RegExp(r'[A-Z]'))) {
      _showErrorSnackBar('First letter must be capitalized');
      return 'First letter must be capitalized';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!value.contains('@')) {
      _showErrorSnackBar('Email must contain @');
      return 'Email must contain @';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      _showErrorSnackBar('Password must be at least 6 characters');
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? confirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      _showErrorSnackBar('Passwords do not match');
      return 'Passwords do not match';
    }
    return null;
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: const Text('Account created successfully'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, Routes.homeRoute);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 12.0,
                children: [
                  SizedBox(
                    height: 120,
                    child: Center(
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                  ),
                  CustomTextField(
                    textEditingController: _nameController,
                    label: 'Full Name',
                    validatorFunction: nameValidator,
                  ),
                  CustomTextField(
                    textEditingController: _emailController,
                    label: 'Email',
                    validatorFunction: emailValidator,
                  ),
                  CustomTextField(
                    textEditingController: _passwordController,
                    label: 'Password',
                    validatorFunction: passwordValidator,
                    showSuffixIcon: true,
                  ),
                  CustomTextField(
                    textEditingController: _confirmPasswordController,
                    label: 'Confirm Password',
                    validatorFunction: confirmPassword,
                    showSuffixIcon: true,
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _showSuccessDialog();
                      }
                    },
                    child: Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
