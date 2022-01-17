import 'package:flutter/material.dart';
import 'package:movie_app/models/all_media.dart';
import 'package:movie_app/screens/media_description.dart';
import 'package:movie_app/screens/saved_screen.dart';
import 'package:provider/provider.dart';
import 'screens/media_grid_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => AllMedia(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Lato',
        ),
        home: const MovieGridScreen(),
        routes: {
          MediaDescription.routeName: (ctx) => const MediaDescription(),
          SavedScreen.routeName: (ctx) => const SavedScreen(),
        },
      ),
    );
  }
}
