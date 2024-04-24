import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/movie_detail_bloc.dart';
import '../../bloc/movie_detail_event.dart';

class ByCinemaSessionItem extends StatefulWidget {
  const ByCinemaSessionItem({
    super.key,
  });

  @override
  State<ByCinemaSessionItem> createState() => _ByCinemaSessionItemState();
}

class _ByCinemaSessionItemState extends State<ByCinemaSessionItem> {
  DateTime selectedDate = DateTime.now();
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Transform.scale(
            scale: 0.8,
            child: Switch(
              value: switchValue,
              onChanged: (value) {
                setState(() {
                  switchValue = value;
                });
                BlocProvider.of<MovieDetailBloc>(context).add(
                  SortMovieSessionsByCinemaEvent(isAscending: value),
                );
              },
            ),
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Text(
          "By Cinema",
          style: textTheme.titleMedium,
        ),
      ],
    );
  }
}
