import 'package:app_cinema/features/home/presentation/bloc/home_bloc.dart';
import 'package:app_cinema/features/home/presentation/home_route.dart';
import 'package:app_cinema/features/home/presentation/views/home_page.dart';
import 'package:app_cinema/features/login/presentation/bloc/login_bloc.dart';
import 'package:app_cinema/features/login/presentation/login_route.dart';
import 'package:app_cinema/features/login/presentation/views/login_page.dart';
import 'package:app_cinema/features/movie_detail/presentation/bloc/movie_detail_bloc.dart';
import 'package:app_cinema/features/movie_detail/presentation/movie_detail_route.dart';
import 'package:app_cinema/features/movie_detail/presentation/views/movie_detail_screen.dart';
import 'package:app_cinema/features/profile/presentation/profile_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/movie_detail/domain/usecases/movie_detail_usecase.impl.dart';
import '../../features/profile/presentation/views/profile_page.dart';

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
      case LoginRoute.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(),
              child: const LoginPage(),
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
            return const ProfilePage();
          },
        );

      default:
    }
    return null;
  }
}
