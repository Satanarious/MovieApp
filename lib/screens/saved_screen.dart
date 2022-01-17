import 'package:flutter/material.dart';
import 'package:movie_app/models/all_media.dart';
import 'package:movie_app/widgets/media_grid.dart';
import 'package:provider/provider.dart';

class SavedScreen extends StatelessWidget {
  static const routeName = '/saved_screen';
  const SavedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final saved = Provider.of<AllMedia>(context).getSaved();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Saved"),
        ),
        body: saved.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/nomedia.png',
                      width: 200,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "No Media Found !",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              )
            : MediaGrid(saved));
  }
}
