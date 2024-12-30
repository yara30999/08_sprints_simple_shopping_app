import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../resources/functions.dart';
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
      return 'validation.enter_full_name'.tr();
    }
    if (!value[0].contains(RegExp(r'[A-Z]'))) {
      showErrorSnackBar('validation.capitalize_first_letter'.tr(), context);
      return 'validation.capitalize_first_letter'.tr();
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation.enter_email'.tr();
    }
    if (!value.contains('@')) {
      showErrorSnackBar('validation.email_contains_at'.tr(), context);
      return 'validation.email_contains_at'.tr();
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation.enter_password'.tr();
    }
    if (value.length < 6) {
      showErrorSnackBar('validation.password_min_length'.tr(), context);
      return 'validation.password_min_length'.tr();
    }
    return null;
  }

  String? confirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'validation.confirm_password'.tr();
    }
    if (value != _passwordController.text) {
      showErrorSnackBar('validation.passwords_do_not_match'.tr(), context);
      return 'validation.passwords_do_not_match'.tr();
    }
    return null;
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('messages.success'.tr()),
          content: Text('messages.account_created'.tr()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, Routes.homeRoute);
              },
              child: const Text('buttons.close').tr(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 22.0,
                  children: [
                    SizedBox(
                      height: 40,
                      child: Center(
                        child: Text(
                          'buttons.login'.tr(),
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          onPressed: () {
                            changeLocale(context);
                          },
                          icon: Icon(Icons.language)),
                    ),
                    CustomTextField(
                      textEditingController: _nameController,
                      label: 'fields.full_name'.tr(),
                      validatorFunction: nameValidator,
                    ),
                    CustomTextField(
                      textEditingController: _emailController,
                      label: 'fields.email'.tr(),
                      validatorFunction: emailValidator,
                    ),
                    CustomTextField(
                      textEditingController: _passwordController,
                      label: 'fields.password'.tr(),
                      validatorFunction: passwordValidator,
                      showSuffixIcon: true,
                    ),
                    CustomTextField(
                      textEditingController: _confirmPasswordController,
                      label: 'fields.confirm_password'.tr(),
                      validatorFunction: confirmPassword,
                      showSuffixIcon: true,
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _showSuccessDialog();
                          }
                        },
                        child: Text(
                          'buttons.sign_up'.tr(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
