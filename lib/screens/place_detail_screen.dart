import '../widgets/site_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/places_provider.dart';
import '../providers/sites_provider.dart';
class PlaceDetailScreen extends StatefulWidget {
  static const routeName = '/place-detail-screen';

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final placeId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedPlace =
        Provider.of<Places>(context, listen: false).findById(placeId);
    final loadedSites= Provider.of<Sites>(context).sitesByPlace(placeId);
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          
                  Text(
                    loadedPlace.title,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                 
              Text(
                loadedPlace.description,
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Divider(
                color: Colors.black87,
              ),
               Expanded(
                child: ListView.builder(
                  itemBuilder: (ctx, i) => SiteItem(site: loadedSites[i],),
                  itemCount: loadedSites.length,
                ),
              )
            ],
          ),
        ));
  }
}
