import 'card_content.dart';
import 'card_pattern.dart';
import 'membership_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget walletCart(WidgetRef ref) => Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          // cardPattern
          cardPattern(),
          // membership banner
          membershipBanner(),
          //content
          cardContent(ref),
        ],
      ),
    );
