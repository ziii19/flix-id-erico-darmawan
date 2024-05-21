import 'dart:io';

import '../../pages/privacy_page/pp.dart';
import '../../pages/update_profile_page/edit_profile.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/entities/movie_detail.dart';
import '../../../domain/entities/transaction.dart';
import '../../pages/booking_confirmation_page.dart/book_confirm_page.dart';
import '../../pages/detail_page/detail_page.dart';
import '../../pages/register_page/register_page.dart';
import '../../pages/time_booking_page/time_booking_page.dart';
import '../../pages/seat_booking_page/seat_booking_page.dart';
import '../../pages/wallet_page/wallet_page.dart';

import '../../pages/login_page/login_page.dart';
import '../../pages/main_page/main_page.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_prov.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouter> router(RouterRef ref) => GoRouter(routes: [
      GoRoute(
        path: '/main',
        name: 'main',
        builder: (context, state) => MainPage(
          imgFile: state.extra != null ? state.extra as File : null,
        ),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
          path: '/detail',
          name: 'detail',
          builder: (context, state) => DetailPage(movie: state.extra as Movie)),
      GoRoute(
        path: '/time-booking',
        name: 'time-booking',
        builder: (context, state) =>
            TimeBookingPage(state.extra as MovieDetail),
      ),
      GoRoute(
        path: '/seat-booking',
        name: 'seat-booking',
        builder: (context, state) => SeatBookPage(
            transactionDetail: state.extra as (MovieDetail, Transaction)),
      ),
      GoRoute(
        path: '/book-confirm',
        name: 'book-confirm',
        builder: (context, state) => BookingConfirmationPage(
            transactionDetail: state.extra as (MovieDetail, Transaction)),
      ),
      GoRoute(
        path: '/wallet',
        name: 'wallet',
        builder: (context, state) => const WalletPage(),
      ),
      GoRoute(
        path: '/privacy',
        name: 'privacy',
        builder: (context, state) => const PrivacyPolicy(),
      ),
      GoRoute(
        path: '/edit-profile',
        name: 'edit-profile',
        builder: (context, state) => const EditProfile(),
      ),
    ], initialLocation: '/login', debugLogDiagnostics: false);
