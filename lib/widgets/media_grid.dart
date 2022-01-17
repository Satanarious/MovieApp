import 'package:flutter/material.dart';
import 'package:movie_app/screens/media_description.dart';
import '../models/media.dart';

class MediaGrid extends StatelessWidget {
  final List<Media> items;

  const MediaGrid(this.items, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.62,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        children: items
            .map(
              (media) => InkWell(
                onTap: () => Navigator.of(context)
                    .pushNamed(MediaDescription.routeName, arguments: media.id),
                child: Card(
                  elevation: 5,
                  child: SizedBox(
                    child: Column(
                      children: [
                        Hero(
                          tag: media.id,
                          child: Image.network(
                              "http://image.tmdb.org/t/p/w500" +
                                  media.posterPath,
                              fit: BoxFit.fill),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 3),
                          child: Text(
                            media.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
            .toList());
  }
}
