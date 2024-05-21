import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/transaction.dart';
import '../extensions/int_extension.dart';
import '../misc/methods.dart';

class TrxCard extends StatelessWidget {
  final Transaction transaction;
  const TrxCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: transaction.title != 'Top Up'
                            ? NetworkImage(
                                    'https://image.tmdb.org/t/p/w500${transaction.transactionImage}')
                                as ImageProvider
                            : const AssetImage('assets/topup.png'),
                        fit: BoxFit.cover),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    )),
              )),
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        DateFormat('EEEE, d MMMM y').format(
                            DateTime.fromMillisecondsSinceEpoch(
                                transaction.transactionTime!)),
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                    verticalSpace(5),
                    Text(
                      transaction.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      transaction.title == 'Top Up'
                          ? '+ ${(-transaction.total).toIDRCurrencyFormat()}'
                          : '- ${transaction.total.toIDRCurrencyFormat()}',
                      style: TextStyle(
                          color: transaction.title == "Top Up"
                              ? const Color.fromARGB(225, 107, 237, 90)
                              : Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
