import 'package:flutter/material.dart';
import 'package:movies/models/models.dart';

class CustomSlider extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const CustomSlider(
      {Key? key, required this.movies, required this.onNextPage, this.title})
      : super(
          key: key,
        );

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(widget.title!,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 21, fontWeight: FontWeight.w500)),
            ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, int index) {
                return Container(
                  width: 120,
                  height: 180,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, "details",
                            arguments: widget.movies[index]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: FadeInImage(
                              image: NetworkImage(
                                  widget.movies[index].fullPosterImg),
                              placeholder:
                                  const AssetImage("assets/no-image.jpg"),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(
                            widget.movies[index].title,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ))
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
