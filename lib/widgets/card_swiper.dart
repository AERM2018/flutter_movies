import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies/models/models.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (movies.isEmpty) {
      return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: SizedBox(
        height: 350,
        child: Swiper(
            itemCount: movies.length,
            itemWidth: size.width * 0.6,
            layout: SwiperLayout.STACK,
            itemHeight: size.height * 0.4,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, 'details', arguments: movie),
                child: ClipRRect(
                  child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/loading.gif'),
                      image: NetworkImage(movie.fullPosterImg)),
                ),
              );
            }),
      ),
    );
  }
}
