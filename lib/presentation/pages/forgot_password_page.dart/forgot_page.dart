// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flixid/presentation/extensions/build_context_extension.dart';
import 'package:flixid/presentation/misc/methods.dart';
import 'package:flixid/presentation/widgets/flix_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/router/router_prov.dart';
import '../../widgets/back_nav.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  String email = '';
  TextEditingController mailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  resetPass() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      context.showSnackbar('A reset link has been sent to your email');

      Future.delayed(const Duration(seconds: 3))
          .then((_) => Navigator.pop(context));
    } on FirebaseAuthException catch (e) {
      context.showSnackbar(e.message!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              children: [
                BackNav(
                  'Forgot Password',
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                verticalSpace(100),
                const Text(
                  'Forgot Password?',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                verticalSpace(10),
                const Text(
                  'Enter your email to reset your password',
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
                verticalSpace(20),
                Form(
                  key: _formKey,
                  child: FlixTextField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter E-mail';
                      }
                      return null;
                    },
                    labelText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    controller: mailController,
                  ),
                ),
                verticalSpace(30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          email = mailController.text;
                        });
                        resetPass();
                      }
                    },
                    child: const Text('Send Reset Link'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
