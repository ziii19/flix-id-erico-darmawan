import '../../../misc/methods.dart';
import '../../../providers/transaction_data/transaction_data_prov.dart';
import '../../../widgets/trx_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> recentTransaction(WidgetRef ref) => [
      const Text(
        'Recent Transaction',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      verticalSpace(24),
      ...ref.watch(transactionDataProvider).when(
            data: (data) => data.isEmpty
                ? []
                : (data
                      ..sort(
                        (a, b) =>
                            -a.transactionTime!.compareTo(b.transactionTime!),
                      ))
                    .map((e) => TrxCard(transaction: e)),
            error: (error, stackTrace) => [],
            loading: () => [const CircularProgressIndicator()],
          ),
    ];

// import 'package:flixid/presentation/misc/methods.dart';
// import 'package:flixid/presentation/providers/transaction_data/transaction_data_prov.dart';
// import 'package:flixid/presentation/providers/usecases/get_logged_in_user_prov.dart';
// import 'package:flixid/presentation/widgets/trx_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// List<Widget> recentTransaction(WidgetRef ref) {
//   // Mendapatkan informasi pengguna yang login
//   final loggedInUser = ref.watch(getLoggedInUserProvider);

//   // Mendapatkan data transaksi dari provider
//   final transactionData = ref.watch(transactionDataProvider);

//   // Memfilter data transaksi berdasarkan pengguna yang login
//   final userTransactions = transactionData.when(
//     data: (data) => data
//         .where((transaction) => transaction.uid == loggedInUser?.uid)
//         .toList(),
//     // orElse: () => [], // Handle ketika tidak ada data atau error
//   );

//   // Menampilkan daftar transaksi terbaru pengguna yang login
//   return [
//     const Text(
//       'Recent Transaction',
//       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//     ),
//     verticalSpace(24),
//     ...userTransactions.isEmpty
//         ? [
//             Text('No recent transactions')
//           ] // Tampilkan pesan jika tidak ada transaksi
//         : userTransactions
//             .sort((a, b) => -a.transactionTime!.compareTo(b.transactionTime!))
//             .map((transaction) => TrxCard(transaction: transaction))
//             .toList(), // Tampilkan daftar transaksi terurut dari terbaru ke terlama
//   ];
// }
