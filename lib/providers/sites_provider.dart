import 'package:app_places/helpers/locations_helper.dart';
import 'package:flutter/material.dart';
import './site.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Sites with ChangeNotifier {
  List<Site> _items = [];
  final String userId;

  Sites(this._items, this.userId);
  List<Site> get items {
    return [..._items];
  }

  Future<List<Site>> get randomList async{
    List<Site> randomList= _items;
    randomList.shuffle();
    return randomList;
  }

  List<Site> sitesByPlace(String id) {
    return _items.where((item) => item.placeId == id).toList();
  }

  Site findById(String id) {
    return _items.firstWhere((site) => site.id == id);
  }

  int sitesLength(String id) {
    return sitesByPlace(id).length;
  }

   List<Site> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  Future<void> fetchAndSetSites() async {
    var url = Uri.parse(
        'https://example-89004-default-rtdb.firebaseio.com/sites.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      url = Uri.parse(
          'https://example-89004-default-rtdb.firebaseio.com/userFavorites/$userId.json');
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);

      final List<Site> loadedSites = [];
      extractedData.forEach((siteId, siteData) {
        loadedSites.add(Site(
          id: siteId,
          title: siteData['title'],
          description: siteData['description'],
          history: siteData['history'],
          location: SiteLocation(
            lattitude: siteData['loc_lat'],
            longitude: siteData['loc_lng'],
            address: siteData['adress'] as String,
          ),
          image: siteData['image'],
          placeId: siteData['placeId'],
          isFavorite:
              favoriteData == null ? false : favoriteData[siteId] ?? false,
        ));
      });
      _items = loadedSites;
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> addSite(Site site) async {
    final url = Uri.parse(
        'https://example-89004-default-rtdb.firebaseio.com/sites.json');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': site.title,
          'description': site.description,
          'history': site.history,
          'location': null,
          'image': site.image,
          'placeId': site.placeId,
        }),
      );
      print(json.decode(response.body));
      final newSite = Site(
        id: json.decode(response.body)['name'],
        title: site.title,
        description: site.description,
        history: site.history,
        image: site.image,
        placeId: site.placeId,
      );
      _items.add(newSite);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> updateSite(
      String id, Site newSite, SiteLocation pickedLocation) async {
    final siteIndex = _items.indexWhere((site) => site.id == id);
    final adress = await LocationHelper.getPlaceAddress(
        pickedLocation.lattitude, pickedLocation.longitude);
    if (siteIndex >= 0) {
      final url = Uri.parse(
          'https://example-89004-default-rtdb.firebaseio.com/sites/$id.json');
      await http.put(url,
          body: json.encode({
            'title': newSite.title,
            'description': newSite.description,
            'history': newSite.history,
            'loc_lat': pickedLocation.lattitude,
            'loc_lng': pickedLocation.longitude,
            'adress': adress,
            'image': newSite.image,
            'placeId': newSite.placeId,
          }));
      _items[siteIndex] = newSite;
      notifyListeners();
    } else {}
  }
}
