import 'package:app_cinema/features/home/data/model/movie.dart';
import 'package:app_cinema/features/home/presentation/bloc/home_bloc.dart';
import 'package:app_cinema/features/home/presentation/bloc/home_event.dart';
import 'package:app_cinema/features/home/presentation/bloc/home_state.dart';
import 'package:app_cinema/features/movie_detail/presentation/movie_detail_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../profile/presentation/profile_route.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late ThemeData _themeData;
  ColorScheme get _colorScheme => _themeData.colorScheme;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetUpcomingMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    return Scaffold(
      appBar: buildAppBar(context, _themeData),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is LoadingHomeState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LoadedHomeState) {
              return buildHomePageBody(state.movies, _themeData);
            } else if (state is ErrorHomeState) {
              return Text(
                state.message,
                style: const TextStyle(color: Colors.red, fontSize: 18),
              );
            }
            return const Text('Something went wrong!');
          },
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, ThemeData themeData) {
    return AppBar(
      toolbarHeight: 70,
      leading: Transform.scale(
        scale: 1.6,
        child: Container(
          margin: const EdgeInsets.only(left: 12),
          child: Image.asset('assets/icon/Logo.png'),
        ),
      ),
      title: buildTitleRow(themeData),
      actions: [
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, ProfileRoute.routeName),
          child: Container(
            width: 70,
            height: 40,
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: themeData.colorScheme.primary,
            ),
            child: Center(
              child: Text(
                "Profile",
                style: themeData.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildTitleRow(ThemeData themeData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Image.asset("assets/icon/Location.png"),
            Text(
              "Nur-Sultan",
              style: themeData.textTheme.titleMedium?.copyWith(),
            ),
          ],
        ),
        Row(
          children: [
            Image.asset("assets/icon/Language.png"),
            Text(
              "Eng",
              style: themeData.textTheme.titleMedium?.copyWith(),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildHomePageBody(List<Movie> movies, ThemeData themeData) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upcoming",
            style: themeData.textTheme.titleLarge?.copyWith(),
          ),
          const SizedBox(height: 25),
          buildCarouselSlider(movies, themeData),
          const SizedBox(height: 15),
          Center(
            child: AnimatedSmoothIndicator(
              activeIndex: _currentIndex,
              count: movies.length,
              effect: ExpandingDotsEffect(
                dotWidth: 10,
                dotHeight: 10,
                activeDotColor: _colorScheme.primary,
                dotColor: _colorScheme.primaryContainer,
              ),
            ),
          ),
          const SizedBox(height: 20),
          buildNowInCinemasSection(movies, themeData),
        ],
      ),
    );
  }

  CarouselSlider buildCarouselSlider(List<Movie> movies, ThemeData themeData) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 330,
        viewportFraction: 0.65,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index, reason) {
          setState(() => _currentIndex = index);
        },
      ),
      items: movies.map((movie) => buildMovieItem(movie, themeData)).toList(),
    );
  }

  Widget buildMovieItem(Movie movie, ThemeData themeData) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white,
                  ),
                ),
                CachedNetworkImage(
                  imageUrl: movie.posterUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(color: Colors.white),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildNowInCinemasSection(List<Movie> movies, ThemeData themeData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Now in cinemas",
              style: themeData.textTheme.titleLarge?.copyWith(),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                size: 30,
                color: themeData.colorScheme.primaryContainer,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        buildMovieGrid(movies, themeData),
      ],
    );
  }

  Widget buildMovieGrid(List<Movie> movies, ThemeData themeData) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: movies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 9 / 16,
        crossAxisSpacing: 15,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final movie = movies[index];
        return buildMovieGridItem(movie, themeData);
      },
    );
  }

  Widget buildMovieGridItem(Movie movie, ThemeData themeData) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        MovideDetailRoute.routeName,
        arguments: [movie.id],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: movie.posterUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(color: Colors.white),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            movie.title ?? "Movie Title",
            style: themeData.textTheme.titleMedium?.copyWith(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),
          Text(
            movie.genre ?? "Genre",
            style: themeData.textTheme.titleSmall?.copyWith(
              color: themeData.colorScheme.primaryContainer,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
