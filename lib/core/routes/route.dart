import 'package:app_cinema/features/auths/presentation/auth_route.dart';
import 'package:app_cinema/features/auths/presentation/bloc/auth_bloc.dart';
import 'package:app_cinema/features/auths/presentation/views/login_page.dart';
import 'package:app_cinema/features/auths/presentation/views/register_page.dart';
import 'package:app_cinema/features/home/presentation/bloc/home_bloc.dart';
import 'package:app_cinema/features/home/presentation/home_route.dart';
import 'package:app_cinema/features/home/presentation/views/home_page.dart';
import 'package:app_cinema/features/movie_detail/presentation/bloc/movie_detail_bloc.dart';
import 'package:app_cinema/features/movie_detail/presentation/movie_detail_route.dart';
import 'package:app_cinema/features/movie_detail/presentation/views/movie_detail_screen.dart';
import 'package:app_cinema/features/profile/domain/usecase/profile_usecase.impl.dart';
import 'package:app_cinema/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:app_cinema/features/profile/presentation/profile_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/movie_detail/domain/usecases/movie_detail_usecase.impl.dart';
import '../../features/profile/presentation/views/profile_page.dart';
import '../../features/ticket/domain/usecase/seat_selection_usecase.impl.dart';
import '../../features/ticket/presentation/bloc/seat_selection_bloc.dart';
import '../../features/ticket/presentation/ticket_route.dart';
import '../../features/ticket/presentation/views/seat_selection_screen.dart';

class RouteGenerator {
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      case HomeRoute.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => HomeBloc(),
              child: const HomePage(),
            );
          },
        );
      case AuthRoute.loginRouteName:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(),
              child: const LoginPage(),
            );
          },
        );

      case AuthRoute.registerRouteName:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(),
              child: const RegisterPage(),
            );
          },
        );

      case MovideDetailRoute.routeName:
        final args = settings.arguments as List<dynamic>;
        final id = args.first;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<MovieDetailBloc>(
              create: (context) =>
                  MovieDetailBloc(MovieDetailUsecasesImplement()),
              child: MovieDetailPage(movieId: id),
            );
          },
        );

      case ProfileRoute.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) =>
                  ProfileBloc(profileUsecase: ProfileUsecaseImpl()),
              child: const ProfilePage(),
            );
          },
        );

      case SeatSelectionRoute.routeName:
        final SeatSelectionScreenArg args =
            settings.arguments as SeatSelectionScreenArg;
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => TicketBloc(
                seatSelectionUsecase: SeatSelectionUsecaseImpl(),
              ),
              child: SeatSelectionScreen(
                sessionModel: args.sessionModel,
                movieDetailEntity: args.movieDetailEntity,
              ),
            );
          },
        );

      default:
    }
    return null;
  }
}
