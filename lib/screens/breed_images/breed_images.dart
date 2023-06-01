import 'package:alldogsapp/controllers/dogs_controller.dart';
import 'package:flutter/material.dart';

class BreedImages extends StatelessWidget {
  final String breed;
  const BreedImages({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    final dogsController = DogsController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "All $breed Images",
          style: const TextStyle(fontSize: 25),
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
          future: dogsController.getBreedImages(breed),
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            List? imagesList = snapshot.data;
            if (imagesList == null) return const Text("Something went wrong");
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: imagesList.length,
              itemBuilder: (_, index) {
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
      ),
    );
  }
}
