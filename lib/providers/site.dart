import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
class SiteLocation {
  final double lattitude;
  final double longitude;
  final String? address;
  const SiteLocation(
      {required this.lattitude, required this.longitude, this.address});
}

class Site with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String history;
  final SiteLocation? location;
  final String image;

  final String placeId;

  bool isFavorite;

  Site(
      {required this.id,
      required this.title,
      required this.description,
      required this.history,
      required this.image,
      required this.placeId,
      this.location,
      this.isFavorite= false});

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
    }
  
    Future<void> toggleFavoriteStatus(String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = Uri.parse(
        'https://example-89004-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json');
    try {
      final response = await http.put(url,
          body: json.encode(
            isFavorite
          ));
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (e) {
      _setFavValue(oldStatus);
    }
  }
}
