import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/movie_detail_bloc.dart';
import '../../bloc/movie_detail_event.dart';

class SortSessionItem extends StatefulWidget {
  const SortSessionItem({
    super.key,
  });

  @override
  State<SortSessionItem> createState() => _SortSessionItemState();
}

class _SortSessionItemState extends State<SortSessionItem> {
  bool isAscending = true;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        setState(() {
          isAscending = !isAscending;
        });
        BlocProvider.of<MovieDetailBloc>(context).add(
          SortMovieSessionsByTimeEvent(isAscending: isAscending),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.sort,
            color: Colors.white,
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            isAscending ? "Time ↑" : "Time ↓",
            style: textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
