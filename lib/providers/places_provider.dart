import 'package:flutter/material.dart';
import '../models/place.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Places with ChangeNotifier {
  List<Place> _placesList = [];

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

  void addPlace(Place place) {
    /*   final url = Uri.parse(
        'https://example-89004-default-rtdb.firebaseio.com/places.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': place.title,
          'description': place.description,
          'img': place.img,
        }),
      ); */

    final newPlace = Place(
        id: DateTime.now().toString(),
        title: place.title,
        description: place.description,
        img: place.img);
    _placesList.add(newPlace);
    notifyListeners();
    /*  } catch (e) {
      throw e;
    } */
  }

  void updatePlace(String id, Place newPlace) async {
    final placeIndex = _placesList.indexWhere((place) => place.id == id);
    /*  if (placeIndex >= 0) {
      final url = Uri.parse(
          'https://example-89004-default-rtdb.firebaseio.com/places/$id.json'); */
    /*   await http.patch(url,
          body: json.encode({
            'title': newPlace.title,
            'description': newPlace.description,
            'img': newPlace.img,
          })); */
    _placesList[placeIndex] = newPlace;
    notifyListeners();
    /* } */
  }

  void deletePlace(String id) {
    /*   final url = Uri.parse(
        'https://example-89004-default-rtdb.firebaseio.com/places/$id.json'); */
    final existingPlaceIndex =
        _placesList.indexWhere((place) => place.id == id);
    /* Place? existingPlace = _placesList[existingPlaceIndex]; */
    _placesList.removeAt(existingPlaceIndex);
    notifyListeners();
    /*   final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _placesList.insert(existingPlaceIndex, existingPlace);
      notifyListeners();
      throw HttpException('No se pudo eliminar el lugar');
    }

    existingPlace = null; */
  }
}
