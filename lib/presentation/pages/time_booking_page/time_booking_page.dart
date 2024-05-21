import '../../../domain/entities/movie_detail.dart';
import '../../../domain/entities/transaction.dart';
import '../../extensions/build_context_extension.dart';
import '../../misc/constants.dart';
import '../../misc/methods.dart';
import 'methods/options.dart';
import '../../providers/router/router_prov.dart';
import '../../providers/user_data/user_data_prov.dart';
import '../../widgets/back_nav.dart';
import '../../widgets/network_image_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TimeBookingPage extends ConsumerStatefulWidget {
  final MovieDetail movieDetail;
  const TimeBookingPage(this.movieDetail, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TimeBookingPageState();
}

class _TimeBookingPageState extends ConsumerState<TimeBookingPage> {
  final List<String> theaters = [
    'XXI The Park',
    'CGV Pakuwon Mall',
    'XXI Empire',
    'XXI The Batanica',
    'CGV Paris van Java'
  ];

  final List<DateTime> dates = List.generate(7, (index) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return date.add(Duration(days: index));
  });

  final List<int> hours = List.generate(8, (index) => index + 12);

  String? selectedTheater;
  DateTime? selectedDate;
  int? selectedHour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: BackNav(
                widget.movieDetail.title,
                onTap: () => ref.read(routerProvider).pop(),
              ),
            ),
            // backdrop
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: NetworkImageCard(
                width: MediaQuery.of(context).size.width - 48,
                height: (MediaQuery.of(context).size.width - 48) * 0.6,
                borderRadius: 15,
                imageUrl:
                    'https://image.tmdb.org/t/p/w500${widget.movieDetail.backgroundPath ?? widget.movieDetail.posterPath}',
                fit: BoxFit.cover,
              ),
            ),
            // Teahther options
            ...options(
              title: 'Select a teather',
              options: theaters,
              selectedItem: selectedTheater,
              onTap: (object) => setState(() {
                selectedTheater = object;
              }),
            ),
            verticalSpace(24),
            // Date options
            ...options(
              title: 'Select date',
              options: dates,
              selectedItem: selectedDate,
              converter: (date) => DateFormat('EEE, d MMMM y').format(date),
              onTap: (object) => setState(() {
                selectedDate = object;
              }),
            ),
            verticalSpace(24),
            // Time Options
            ...options(
              title: 'Select show time',
              options: hours,
              selectedItem: selectedHour,
              converter: (object) => '$object:00',
              isOptionEnable: (object) =>
                  selectedDate != null &&
                  DateTime(
                    selectedDate!.year,
                    selectedDate!.month,
                    selectedDate!.day,
                    object,
                  ).isAfter(DateTime.now()),
              onTap: (object) => setState(() {
                selectedHour = object;
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: bgColor,
                        backgroundColor: saffron,
                      ),
                      onPressed: () {
                        if (selectedDate == null ||
                            selectedHour == null ||
                            selectedTheater == null) {
                          context.showSnackbar('Please select all options!');
                        } else {
                          Transaction transaction = Transaction(
                              uid: ref.read(userDataProvider).value!.uid,
                              title: widget.movieDetail.title,
                              adminFee: 3000,
                              total: 0,
                              watchingTime: DateTime(
                                selectedDate!.year,
                                selectedDate!.month,
                                selectedDate!.day,
                                selectedHour!,
                              ).millisecondsSinceEpoch,
                              transactionImage: widget.movieDetail.posterPath,
                              theaterName: selectedTheater!);

                          ref.read(routerProvider).pushNamed('seat-booking',
                              extra: (widget.movieDetail, transaction));
                        }
                      },
                      child: const Text('Next'))),
            )
          ],
        )
      ],
    ));
  }
}
