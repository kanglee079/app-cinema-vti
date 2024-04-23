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
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ThemeData _themeData;
  TextTheme get _textTheme => _themeData.textTheme;
  ColorScheme get _colorScheme => _themeData.colorScheme;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Fetch movies when the page is initialized
    context.read<HomeBloc>().add(GetUpcomingMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: Transform.scale(
          scale: 1.6,
          child: Container(
            margin: const EdgeInsets.only(left: 12),
            child: Image.asset('assets/icon/Logo.png'),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Image.asset("assets/icon/Location.png"),
                Text(
                  "Nur-Sultan",
                  style: _textTheme.titleMedium?.copyWith(),
                ),
              ],
            ),
            Row(
              children: [
                Image.asset("assets/icon/Language.png"),
                Text(
                  "Eng",
                  style: _textTheme.titleMedium?.copyWith(),
                ),
              ],
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                ProfileRoute.routeName,
              );
            },
            child: Container(
              width: 70,
              height: 40,
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: _colorScheme.primary,
              ),
              child: Center(
                child: Text(
                  "Profile",
                  style: _textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is LoadingHomeState) {
              return const CircularProgressIndicator();
            } else if (state is LoadedHomeState) {
              return buildHomePageBody(state.movies);
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

  Widget buildHomePageBody(List<Movie> movies) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Upcoming",
            style: _textTheme.titleLarge?.copyWith(),
          ),
          const SizedBox(height: 25),
          CarouselSlider(
            options: CarouselOptions(
              height: 350,
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
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: movies.map((movie) {
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
                              child: Container(
                                color: Colors.white,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
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
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Now in cinemas",
                style: _textTheme.titleLarge?.copyWith(),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  size: 30,
                  color: _colorScheme.primaryContainer,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          GridView.builder(
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
              return GestureDetector(
                onTap: () {
                  print("Movie ID: ${movies[index].id}");
                  Navigator.pushNamed(
                    context,
                    MovideDetailRoute.routeName,
                    arguments: [movies[index].id],
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: movie.posterUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  color: Colors.white,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              width: 40,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: _colorScheme.primary,
                              ),
                              child: Center(
                                child: Text(
                                  movie.voteAverage?.toStringAsFixed(1) ?? "0",
                                  style: _textTheme.bodyMedium?.copyWith(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      movie.title ?? "Movie Title",
                      style: _textTheme.titleMedium?.copyWith(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      movie.genre ?? "Genre",
                      style: _textTheme.bodySmall?.copyWith(
                        color: _colorScheme.primaryContainer,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
