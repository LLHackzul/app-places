import 'package:flutter/material.dart';
import '../widgets/places_item.dart';
import 'package:provider/provider.dart';
import '../providers/places_provider.dart';

class PlacesGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final placesData = Provider.of<Places>(context);
    print(placesData.places.length);
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: placesData.places[i],
        child: PlacesItem(),
      ),
      itemCount: placesData.places.length,
    );
  }
}
