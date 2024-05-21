import 'dart:math';

import '../../../domain/entities/movie_detail.dart';
import '../../../domain/entities/transaction.dart';
import '../../extensions/build_context_extension.dart';
import '../../misc/constants.dart';
import '../../misc/methods.dart';
import 'methods/legends.dart';
import 'methods/movie_screen.dart';
import 'methods/seat_sections.dart';
import '../../providers/router/router_prov.dart';
import '../../widgets/back_nav.dart';
import '../../widgets/seat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeatBookPage extends ConsumerStatefulWidget {
  final (MovieDetail, Transaction) transactionDetail;
  const SeatBookPage({required this.transactionDetail, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SeatBookPageState();
}

class _SeatBookPageState extends ConsumerState<SeatBookPage> {
  List<int> selectedSeats = [];
  List<int> reservedSeats = [];

  @override
  void initState() {
    super.initState();

    Random random = Random();
    int reservedNumber = random.nextInt(36) + 1;

    while (reservedSeats.length < 8) {
      if (!reservedSeats.contains(reservedNumber)) {
        reservedSeats.add(reservedNumber);
      }
      reservedNumber = random.nextInt(36) + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final (movieDetail, transaction) = widget.transactionDetail;
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              BackNav(
                movieDetail.title,
                onTap: () => ref.read(routerProvider).pop(),
              ),
              // MovieScreen
              movieScreen(),
              // seats (2 sections)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  seatSection(
                    seatNumbers: List.generate(18, (index) => index + 1),
                    onTap: onSeatTap,
                    seatStatusChecker: seatStatusChecker,
                  ),
                  horizontalSpaces(30),
                  seatSection(
                    seatNumbers: List.generate(18, (index) => index + 19),
                    onTap: onSeatTap,
                    seatStatusChecker: seatStatusChecker,
                  )
                ],
              ),
              verticalSpace(20),
              // legend
              legend(),
              verticalSpace(40),
              // number of selected seats
              Text(
                '${selectedSeats.length} seats Selected',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              verticalSpace(40),
              // button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if (selectedSeats.isEmpty) {
                        context.showSnackbar('Please select at least one seat');
                      } else {
                        var updatedTransaction = transaction.copyWith(
                          seats:
                              (selectedSeats..sort()).map((e) => '$e').toList(),
                          ticketAmount: selectedSeats.length,
                          ticketPrice: 25000,
                        );
                        ref.read(routerProvider).pushNamed('book-confirm',
                            extra: (movieDetail, updatedTransaction));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: bgColor,
                        backgroundColor: saffron,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text('Next')),
              )
            ],
          ),
        )
      ],
    ));
  }

  void onSeatTap(seatNumber) {
    if (!selectedSeats.contains(seatNumber)) {
      setState(() {
        selectedSeats.add(seatNumber);
      });
    } else {
      setState(() {
        selectedSeats.remove(seatNumber);
      });
    }
  }

  SeatStatus seatStatusChecker(seatNumber) => reservedSeats.contains(seatNumber)
      ? SeatStatus.reserved
      : selectedSeats.contains(seatNumber)
          ? SeatStatus.selected
          : SeatStatus.available;
}

