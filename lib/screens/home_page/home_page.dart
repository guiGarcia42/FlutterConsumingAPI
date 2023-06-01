import 'package:alldogsapp/screens/breed_images/breed_images.dart';
import 'package:alldogsapp/screens/favorite_breeds/favorite_breeds.dart';
import 'package:alldogsapp/utils/data.dart';
import 'package:alldogsapp/utils/favorite_breeds_provider.dart';
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
    final provider = Provider.of<FavoriteBreedsProvider>(context);
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
          future: dogsBreeds(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            List? breedsList = snapshot.data;
            if (breedsList == null) return const Text("Something went wrong");
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListView.builder(
                itemCount: breedsList.length,
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
                              breed: breedsList.elementAt(index),
                            ),
                          ),
                        );
                      },
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
                            trailing: IconButton(
                              onPressed: () {
                                provider.toggleFavorite(
                                    breedsList.elementAt(index));
                              },
                              icon: provider
                                      .isFavorite(breedsList.elementAt(index))
                                  ? Icon(Icons.favorite)
                                  : Icon(Icons.favorite_border),
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
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FavoriteBreeds(),
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
