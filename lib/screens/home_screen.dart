import 'package:flutter/material.dart';
import 'package:movies/providers/movies_provider.dart';
import 'package:movies/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home screen'),
        actions: const [
          IconButton(
              onPressed: null, icon: Icon(Icons.search, color: Colors.white))
        ],
      ),
      body: Stack(
        children: [
          const Background(),
          SingleChildScrollView(
            child: Column(
              children: [
                CardSwiper(movies: moviesProvider.onDisplayMovies),
                CustomSlider(
                  movies: moviesProvider.popularMovies,
                  title: "Popular",
                  onNextPage: moviesProvider.getPopularMovies,
                ),
                CustomSlider(
                  movies: moviesProvider.topRatedMovies,
                  title: "Top rated",
                  onNextPage: moviesProvider.getTopRatedMovies,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
