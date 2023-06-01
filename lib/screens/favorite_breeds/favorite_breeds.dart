import 'package:alldogsapp/controllers/dogs_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteBreeds extends StatefulWidget {
  const FavoriteBreeds({super.key});

  @override
  State<FavoriteBreeds> createState() => _FavoriteBreedsState();
}

class _FavoriteBreedsState extends State<FavoriteBreeds> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DogsController>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Favorite Dog Breeds",
          style: TextStyle(fontSize: 25),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.green,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListView.builder(
          itemCount: provider.favoriteBreeds.length,
          itemBuilder: (_, index) {
            return Card(
              color: Colors.lightGreen,
              clipBehavior: Clip.hardEdge,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    title: Text(
                      provider.favoriteBreeds[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: const Text(
                      "Images:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          provider
                              .toggleFavorite(provider.favoriteBreeds[index]);
                        });
                      },
                      icon: provider.isFavorite(provider.favoriteBreeds[index])
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border),
                    ),
                  ),
                  FutureBuilder(
                    future:
                        provider.getBreedImages(provider.favoriteBreeds[index]),
                    builder: (context, AsyncSnapshot<List<String>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      List<String>? imagesList = snapshot.data;
                      if (imagesList == null) {
                        return const Text("Something went wrong");
                      }
                      int gridSize = 5;
                      if (imagesList.length < gridSize) {
                        gridSize = imagesList.length;
                      }
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
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
