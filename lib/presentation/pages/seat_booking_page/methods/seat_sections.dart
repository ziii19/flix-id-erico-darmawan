import '../../../widgets/seat.dart';
import 'package:flutter/material.dart';

Widget seatSection(
        {required List<int> seatNumbers,
        required void Function(int seatNumber) onTap,
        required SeatStatus Function(int seatNumber) seatStatusChecker}) =>
    SizedBox(
      height: 240,
      width: 110,
      child: Wrap(
        spacing: 10,
        runAlignment: WrapAlignment.spaceBetween,
        direction: Axis.horizontal,
        children: seatNumbers
            .map((e) => Seat(
                  number: e,
                  status: seatStatusChecker(e),
                  onTap: () => onTap(e),
                ))
            .toList(),
      ),
    );
