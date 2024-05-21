import '../misc/constants.dart';
import 'package:flutter/material.dart';

enum SeatStatus { available, reserved, selected }

class Seat extends StatelessWidget {
  final int? number;
  final SeatStatus status;
  final double size;
  final VoidCallback? onTap;
  const Seat(
      {super.key,
      this.number,
      this.status = SeatStatus.available,
      this.size = 30,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: status == SeatStatus.available
                ? Colors.white
                : status == SeatStatus.reserved
                    ? Colors.grey
                    : saffron,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              number?.toString() ?? '',
              style:
                  const TextStyle(color: bgColor, fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
