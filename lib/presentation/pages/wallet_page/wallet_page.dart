import '../../misc/methods.dart';
import 'methods/recent_transaction.dart';
import 'methods/wallet_cart.dart';
import '../../providers/router/router_prov.dart';
import '../../widgets/back_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WalletPage extends ConsumerWidget {
  const WalletPage({super.key});
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
                  'My Wallet',
                  onTap: () => ref.read(routerProvider).pop(),
                ),
                verticalSpace(24),
                // Wallet Card
                walletCart(ref),
                verticalSpace(24),
                // Recent Transactions
                ...recentTransaction(ref),
              ],
            ),
          )
        ],
      ),
    );
  }
}
