import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List> dogsBreeds() async {
  final response =
      await http.get(Uri.parse('https://dog.ceo/api/breeds/list/all'));

  List<String> breedsList = List.from(
      Map<String, dynamic>.from(json.decode(response.body)['message'])
          .keys
          .toList());

  return breedsList;
}

Future<List<String>> imagesByDogsBreed(String breed) async {
  final response =
      await http.get(Uri.parse('https://dog.ceo/api/breed/$breed/images'));

  List<String> dogsImages =
      List<String>.from(json.decode(response.body)['message']);

  return dogsImages;
}
