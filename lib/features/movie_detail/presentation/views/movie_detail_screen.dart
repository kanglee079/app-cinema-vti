import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movie_detail_bloc.dart';
import '../bloc/movie_detail_event.dart';
import '../bloc/movie_detail_state.dart';
import 'tabs/about_page.dart';
import 'tabs/session_page.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late ThemeData _themeData;
  TextTheme get _textTheme => _themeData.textTheme;
  ColorScheme get _colorScheme => _themeData.colorScheme;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MovieDetailBloc>(context)
        .add(GetMovieDetailEvent(movieId: widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                padding: const EdgeInsets.only(left: 15),
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: _themeData.colorScheme.primaryContainer,
                ),
              ),
              title: Text(
                state.movieDetail?.title ?? 'Loading...',
                style: _textTheme.titleLarge,
              ),
              bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: _themeData.colorScheme.primaryContainer,
                labelStyle: _textTheme.titleMedium,
                labelColor: _colorScheme.primary,
                tabs: const [
                  Tab(text: 'About'),
                  Tab(text: 'Sessions'),
                ],
              ),
            ),
            body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
              builder: (context, state) {
                if (state.status == BlocStatusState.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.status == BlocStatusState.success) {
                  return TabBarView(
                    children: [
                      AboutTab(movieDetail: state.movieDetail),
                      SessionTab(movieId: widget.movieId),
                    ],
                  );
                } else if (state.status == BlocStatusState.failed) {
                  return Center(
                    child: Text(
                      state.errorMessage ?? "An error occurred",
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  );
                }
                return const Center(child: Text('Something went wrong!'));
              },
            ),
            bottomNavigationBar: _buildBottomNavigationBar(),
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      width: double.infinity,
      height: 110,
      decoration: BoxDecoration(
        color: _colorScheme.surface,
      ),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(21),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: _colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                "Select session",
                style: _textTheme.titleMedium!.copyWith(
                  color: _colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
