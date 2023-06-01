import 'dart:convert';
import 'package:alldogsapp/models/breed.dart';
import 'package:alldogsapp/models/dog_breeds.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DogsController extends ChangeNotifier {
  DogBreeds? dogs;
  Breed? breed;
  List<String> favoriteBreeds = [];

  Future<DogBreeds?> getAllDogBreeds() async {
    final response =
        await http.get(Uri.parse('https://dog.ceo/api/breeds/list/all'));

    dogs = DogBreeds(
        breeds: List.from(
            Map<String, dynamic>.from(json.decode(response.body)['message'])
                .keys
                .toList()));

    notifyListeners();
    return dogs;
  }

  Future<List<String>> getBreedImages(String choseBreed) async {
    final response = await http
        .get(Uri.parse('https://dog.ceo/api/breed/$choseBreed/images'));

    List<String> breedImages =
        List<String>.from(json.decode(response.body)['message']);

    return breedImages;
  }

  bool isFavorite(String breed) {
    return favoriteBreeds.contains(breed);
  }

  void toggleFavorite(String breed) {
    if (isFavorite(breed)) {
      favoriteBreeds.remove(breed);
    } else {
      favoriteBreeds.add(breed);
    }
  }

  void clearFavorite() {
    favoriteBreeds = [];
  }
}
