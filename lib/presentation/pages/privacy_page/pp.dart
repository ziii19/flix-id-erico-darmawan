import '../../misc/methods.dart';
import 'methods/cart_text.dart';
import '../../providers/router/router_prov.dart';
import '../../widgets/back_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrivacyPolicy extends ConsumerWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: Column(
              children: [
                BackNav(
                  'Privacy Policy',
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                verticalSpace(20),
                cardText(
                    title: 'Privacy Policy',
                    desc:
                        '"Flix-ID" is a cinema ticket booking application developed by [Company Name]. We highly value your privacy, and our commitment is to protect and respect your privacy. This document explains how we collect, use, and protect your personal information when you use our application.')
              ],
            ),
          )
        ],
      ),
    );
  }
}
