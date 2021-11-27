import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../helpers/locations_helper.dart';
import '../screens/maps_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;
  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    try {
      final locData = await Location().getLocation();
      final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
        lattitude: locData.latitude,
        longitude: locData.longitude,
      );
      setState(() {
        _previewImageUrl = staticMapImageUrl;
      });
      widget.onSelectPlace(locData.latitude, locData.longitude);
    } catch (e) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation =
        await Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (ctx) => MapScreen(
                  isSelecting: true,
                )));
    if (selectedLocation == null) {
      return;
    }
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      lattitude: selectedLocation.latitude,
      longitude: selectedLocation.longitude,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          height: 170,
          width: double.infinity,
          child: _previewImageUrl == null
              ? Text(
                  'Elige una localización',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text('Ubicacion actual'),
              textColor: Theme.of(context).primaryColor,
            ),
            FlatButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text('Seleccionar en mapa'),
              textColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ],
    );
  }
}
