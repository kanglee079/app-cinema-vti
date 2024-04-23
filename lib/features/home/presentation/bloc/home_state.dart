import '../../data/model/movie.dart';

abstract class HomeState {}

class InitialHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class LoadedHomeState extends HomeState {
  final List<Movie> movies;

  LoadedHomeState(this.movies);
}

class ErrorHomeState extends HomeState {
  final String message;

  ErrorHomeState(this.message);
}
