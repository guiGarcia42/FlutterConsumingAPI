import 'package:alldogsapp/models/dog_breeds.dart';
import 'package:alldogsapp/screens/breed_images/breed_images.dart';
import 'package:alldogsapp/screens/favorite_breeds/favorite_breeds.dart';
import 'package:alldogsapp/controllers/dogs_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DogsController>(context);
    final dogsController = DogsController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "All Dogs breeds",
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
      body: Center(
        child: FutureBuilder(
          future: dogsController.getAllDogBreeds(),
          builder: (context, AsyncSnapshot<DogBreeds?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            DogBreeds? breedsList = snapshot.data;
            if (breedsList == null) return const Text("Something went wrong");
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListView.builder(
                itemCount: breedsList.breeds.length,
                itemBuilder: (_, index) {
                  return Card(
                    color: Colors.lightGreen,
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      splashColor: Colors.green.withAlpha(200),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => BreedImages(
                              breed: breedsList.breeds.elementAt(index),
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ListTile(
                            title: Text(
                              breedsList.breeds.elementAt(index),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            trailing: StatefulBuilder(
                              builder: (context, setState) {
                                return IconButton(
                                  onPressed: () {
                                    setState(() => provider.toggleFavorite(
                                        breedsList.breeds.elementAt(index)));
                                  },
                                  icon: provider.isFavorite(
                                          breedsList.breeds.elementAt(index))
                                      ? const Icon(Icons.favorite)
                                      : const Icon(Icons.favorite_border),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => const FavoriteBreeds(),
              ))
              .then((value) => setState(
                    () {},
                  ));
        },
        backgroundColor: Colors.green[800],
        label: const Text(
          "Favorites",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
