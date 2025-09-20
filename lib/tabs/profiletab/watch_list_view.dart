import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/app_theme.dart';
import 'package:movies/cubit/watchlist_cubit.dart';
import 'package:movies/models/movie_model.dart';

class WatchListView extends StatelessWidget {
  const WatchListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistCubit, List<MovieModel>>(
      builder: (context, watchlist) {
        if (watchlist.isEmpty) {
          return Center(child: Image.asset('assets/images/empty.png'));
        }

        return ListView.builder(
          itemCount: watchlist.length,
          itemBuilder: (context, index) {
            final movie = watchlist[index];
            return ListTile(
              leading: Image.network(movie.image, fit: BoxFit.cover),
              title: Text(
                movie.title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              trailing: const Icon(Icons.bookmark, color: AppTheme.primary),
            );
          },
        );
      },
    );
  }
}
