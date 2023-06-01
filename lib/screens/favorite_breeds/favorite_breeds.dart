import 'dart:math';

import 'package:alldogsapp/utils/data.dart';
import 'package:alldogsapp/utils/favorite_breeds_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteBreeds extends StatelessWidget {
  const FavoriteBreeds({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoriteBreedsProvider>(context);
    final breedsList = provider.breeds;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Favorite Dog Breeds",
          style: TextStyle(fontSize: 25),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.black, Colors.green],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView.builder(
          itemCount: breedsList.length,
          itemBuilder: (_, index) {
            return Card(
              color: Colors.lightGreen,
              clipBehavior: Clip.hardEdge,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    title: Text(
                      breedsList.elementAt(index),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      "Images:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        provider.toggleFavorite(breedsList.elementAt(index));
                      },
                      icon: provider.isFavorite(breedsList.elementAt(index))
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_border),
                    ),
                  ),
                  FutureBuilder(
                    future: imagesByDogsBreed(breedsList[index]),
                    builder: (context, AsyncSnapshot<List> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      List? imagesList = snapshot.data;
                      if (imagesList == null) {
                        return const Text("Something went wrong");
                      }
                      int gridSize = 5;
                      if (imagesList.length < gridSize) {
                        gridSize = imagesList.length;
                      }
                      return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemCount: gridSize,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(6),
                            margin: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(imagesList[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
