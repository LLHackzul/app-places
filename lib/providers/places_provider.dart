import 'package:flutter/material.dart';
import '../models/place.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Places with ChangeNotifier {
  List<Place> _placesList = [
  ];

  List<Place> get places {
    return [..._placesList];
  }

  Place findById(String id) {
    return _placesList.firstWhere((place) => place.id == id);
  }

  Future<void> fetchAndSetPlaces() async {
    final url = Uri.parse(
        'https://example-89004-default-rtdb.firebaseio.com/places.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Place> loadedPlaces = [];
      extractedData.forEach((placeId, placeData) {
        loadedPlaces.add(Place(
          id: placeId,
          title: placeData['title'],
          description: placeData['description'],
          img: placeData['img'],
        ));
      });
      _placesList = loadedPlaces;
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> addPlace(Place place) async {
    final url = Uri.parse(
        'https://example-89004-default-rtdb.firebaseio.com/places.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': place.title,
          'description': place.description,
          'img': place.img,
        }),
      );

      final newPlace = Place(
          id: json.decode(response.body)['name'],
          title: place.title,
          description: place.description,
          img: place.img);
      _placesList.add(newPlace);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  

}
