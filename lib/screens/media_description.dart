import 'package:flutter/material.dart';
import 'package:movie_app/models/all_media.dart';
import 'package:provider/provider.dart';

class MediaDescription extends StatefulWidget {
  static const routeName = '/media_description';
  const MediaDescription({Key? key}) : super(key: key);

  @override
  State<MediaDescription> createState() => _MediaDescriptionState();
}

class _MediaDescriptionState extends State<MediaDescription> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AllMedia>(context, listen: false);
    final id = ModalRoute.of(context)!.settings.arguments as int;
    final media = provider.getItemById(id);
    final isSaved = media.saved;
    return Scaffold(
        body: FutureBuilder(
            future: media.fetchMediaDetails(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      actions: [
                        IconButton(
                            onPressed: () {
                              media.saved = !media.saved;
                              if (media.saved == true) {
                                provider.addFavourite(media);
                              } else {
                                provider.removeFavourite(id);
                              }
                              setState(() {});
                            },
                            icon:
                                Icon(isSaved ? Icons.star : Icons.star_border))
                      ],
                      expandedHeight: 158,
                      pinned: true,
                      flexibleSpace: Image.network(
                        "http://image.tmdb.org/t/p/w500/" + media.backdropPath,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SliverList(
                        delegate: SliverChildListDelegate([
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Hero(
                              tag: media.id,
                              child: Image.network(
                                "http://image.tmdb.org/t/p/w500" +
                                    media.posterPath,
                                fit: BoxFit.fill,
                                height: 150,
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            SizedBox(
                              height: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      media.title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: (snapshot.data as Map)['genres'] ==
                                            null
                                        ? null
                                        : Text(
                                            ((snapshot.data as Map)['genres']
                                                    as List)
                                                .map((genre) => genre['name'])
                                                .join(', '),
                                          ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Divider(
                          color: Colors.black,
                          height: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(media.overview),
                      ),
                      const SizedBox(
                        height: 800,
                      ),
                    ])),
                  ],
                );
              }
            }));
  }
}
