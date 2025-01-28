import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                    const SizedBox(height: 30),
                    // don't-have-an-account button
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed(
                          Routes.registerRoute,
                        );
                      },
                      child: Center(
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: tr("donotHaveAccount"),
                            ),
                            TextSpan(
                                text: tr("registerNow"),
                                style: TextStyle(
                                  color: Colors.blue,
                                )),
                          ]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              UserCredential credential = await FirebaseAuth
                                  .instance
                                  .signInWithEmailAndPassword(
                                      email: _emailController.text.trim(),
                                      password:
                                          _passwordController.text.trim());
                              if (context.mounted) {
                                if (credential.user != null) {
                                  Navigator.pushNamed(
                                      context, Routes.homeRoute);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'errors.something_went_wrong'
                                                  .tr())));
                                }
                              }
                            } on FirebaseAuthException catch (e) {
                              if (context.mounted) {
                                if (e.code == 'user-not-found') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'errors.no_user_found'.tr())));
                                } else if (e.code == 'wrong-password') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'errors.wrong_password'.tr())));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(e.message.toString())));
                                }
                              }
                            }
                          }
                        },
                        child: Text(
                          'buttons.sign_in'.tr(),
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
