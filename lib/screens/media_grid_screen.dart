import 'package:flutter/material.dart';
import 'package:movie_app/models/all_media.dart';
import 'package:movie_app/screens/saved_screen.dart';
import 'package:movie_app/widgets/media_grid.dart';
import 'package:provider/provider.dart';

class MovieGridScreen extends StatelessWidget {
  const MovieGridScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AllMedia>(context, listen: false);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.star),
              onPressed: () =>
                  Navigator.of(context).pushNamed(SavedScreen.routeName),
            )
          ],
          title: const Text("MovieDB"),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  "Movies",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Tab(
                child: Text(
                  "TV",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
        body: FutureBuilder(
            future: provider.fetchAndConvertMedia(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasError) {
                  return const Text("An Error Occured");
                } else {
                  return TabBarView(
                    children: [
                      MediaGrid(provider.getMovies()),
                      MediaGrid(provider.getTv()),
                    ],
                  );
                }
              }
            }),
      ),
    );
  }
}
