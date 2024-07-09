import 'dart:io';

import 'package:flixid/data/Firebase/upload_image.dart';

import '../../extensions/build_context_extension.dart';
import '../../misc/methods.dart';
import '../../providers/router/router_prov.dart';
import '../../providers/user_data/user_data_prov.dart';
import '../../widgets/flix_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();

  XFile? xfile;

  @override
  Widget build(BuildContext context) {
    ref.listen(userDataProvider, (previous, next) {
      if (next is AsyncData && next.value != null) {
        ref.read(routerProvider).goNamed(
              'main',
            );
      } else if (next is AsyncError) {
        context.showSnackbar(next.error.toString());
      }
    });

    return Scaffold(
      body: ListView(
        children: [
          verticalSpace(50),
          Center(
            child: Image.asset(
              'assets/flix_logo.png',
              width: 150,
            ),
          ),
          verticalSpace(50),
          GestureDetector(
            onTap: () async {
              xfile =
                  await ImagePicker().pickImage(source: ImageSource.gallery);
              setState(() {});
            },
            child: CircleAvatar(
              radius: 50,
              backgroundImage:
                  xfile != null ? FileImage(File(xfile!.path)) : null,
              child: xfile != null
                  ? null
                  : const Icon(
                      Icons.add_a_photo,
                      size: 50.0,
                    ),
            ),
          ),
          verticalSpace(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                FlixTextField(labelText: 'Name', controller: nameController),
                verticalSpace(24),
                FlixTextField(labelText: 'Email', controller: emailController),
                verticalSpace(24),
                FlixTextField(
                  labelText: 'Password',
                  controller: passwordController,
                  obscureText: true,
                ),
                verticalSpace(24),
                FlixTextField(
                  labelText: 'Retype Password',
                  controller: retypePasswordController,
                  obscureText: true,
                ),
                verticalSpace(24),
                switch (ref.watch(userDataProvider)) {
                  AsyncData(:final value) => value == null
                      ? SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (passwordController.text ==
                                    retypePasswordController.text) {
                                  String imgUrl = await UploadImage()
                                      .uploadImage(
                                          File(xfile!.path), 'profileImage');

                                  ref.read(userDataProvider.notifier).register(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      imageUrl: imgUrl);
                                } else {
                                  context.showSnackbar(
                                      'Please retype your password with the same value');
                                }
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  _ => const Center(
                      child: CircularProgressIndicator(),
                    ),
                },
                verticalSpace(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    TextButton(
                        onPressed: () {
                          ref.read(routerProvider).goNamed('login');
                        },
                        child: const Text(
                          'Login here',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
