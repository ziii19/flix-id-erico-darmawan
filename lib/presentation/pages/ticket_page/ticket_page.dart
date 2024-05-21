import '../../providers/transaction_data/transaction_data_prov.dart';
import '../../widgets/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TicketPage extends ConsumerWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: ref.watch(transactionDataProvider).when(
                    data: (data) => (data
                            .where((element) =>
                                element.title != 'Top Up' &&
                                element.watchingTime! >=
                                    DateTime.now().millisecondsSinceEpoch)
                            .toList()
                          ..sort(
                            (a, b) =>
                                a.watchingTime!.compareTo(b.watchingTime!),
                          ))
                        .map((trx) => Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Ticket(transaction: trx),
                            ))
                        .toList(),
                    error: (error, stackTrace) => [],
                    loading: () => [const CircularProgressIndicator()],
                  )),
        )
      ],
    );
  }
}
