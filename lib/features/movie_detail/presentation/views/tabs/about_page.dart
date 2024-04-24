import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../../widgets/item_tile_about_page.dart';
import '../../../domain/entities/movie_detail_entity.dart';
import '../../bloc/movie_detail_bloc.dart';
import '../../bloc/movie_detail_state.dart';

class AboutTab extends StatefulWidget {
  final MovieDetailEntity? movieDetail;

  const AboutTab({super.key, this.movieDetail});

  @override
  _AboutTabState createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> {
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    _initializeYoutubeController();
  }

  @override
  void dispose() {
    _youtubeController.pause();
    Future.delayed(const Duration(milliseconds: 40))
        .then((value) => _youtubeController.dispose());
    super.dispose();
  }

  void _initializeYoutubeController() {
    final videoId = widget.movieDetail?.youtubeUrl == null
        ? ''
        : YoutubePlayer.convertUrlToId(widget.movieDetail!.youtubeUrl!);
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId ?? "",
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void didUpdateWidget(covariant AboutTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.movieDetail?.youtubeUrl != oldWidget.movieDetail?.youtubeUrl) {
      _initializeYoutubeController();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final textTheme = themeData.textTheme;
    final colorScheme = themeData.colorScheme;

    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      builder: (context, state) {
        final movieDetail = state.movieDetail ?? widget.movieDetail;
        if (movieDetail == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              if (movieDetail.youtubeUrl != null)
                YoutubePlayer(
                    controller: _youtubeController,
                    showVideoProgressIndicator: true),
              _buildRatingSection(movieDetail, colorScheme),
              _buildMovieDetails(movieDetail, textTheme, colorScheme),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRatingSection(
      MovieDetailEntity movieDetail, ColorScheme colorScheme) {
    return Container(
      color: colorScheme.surface,
      child: Row(
        children: [
          _buildRatingItem(movieDetail.voteAverage?.toStringAsFixed(1), 'IMDB'),
          Container(
            width: 1,
            height: 70,
            color: colorScheme.onSurface.withOpacity(0.12),
          ),
          _buildRatingItem(movieDetail.voteCount?.toString(), 'Votes'),
        ],
      ),
    );
  }

  Widget _buildMovieDetails(MovieDetailEntity movieDetail, TextTheme textTheme,
      ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(movieDetail.title ?? 'No title available',
              style: textTheme.titleLarge),
          Text(movieDetail.description ?? 'No description available',
              style: textTheme.bodyLarge),
          const SizedBox(height: 20),
          ItemTileAboutPage(
              textTheme: textTheme,
              colorScheme: colorScheme,
              title: 'Director',
              content: movieDetail.director ?? 'N/A'),
          ItemTileAboutPage(
              textTheme: textTheme,
              colorScheme: colorScheme,
              title: 'Cast',
              content: movieDetail.cast?.join(', ') ?? 'N/A'),
          ItemTileAboutPage(
              textTheme: textTheme,
              colorScheme: colorScheme,
              title: 'Runtime',
              content: '${movieDetail.runtime ?? 0} minutes'),
          ItemTileAboutPage(
              textTheme: textTheme,
              colorScheme: colorScheme,
              title: 'Release Year',
              content: movieDetail.releaseDate?.year.toString() ?? 'N/A'),
          ItemTileAboutPage(
              textTheme: textTheme,
              colorScheme: colorScheme,
              title: 'Genre',
              content: movieDetail.genre ?? 'N/A'),
        ],
      ),
    );
  }

  Expanded _buildRatingItem(String? value, String? unit) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(value ?? '',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(unit ?? '',
                style: const TextStyle(fontSize: 14, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
