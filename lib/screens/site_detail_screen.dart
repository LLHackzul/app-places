import 'package:app_places/providers/site.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sites_provider.dart';
import './maps_screen.dart';
import '../helpers/locations_helper.dart';
import '../providers/auth.dart';

class SiteDetailScreen extends StatefulWidget {
  static const routeName = '/site-detail-screen';

  @override
  State<SiteDetailScreen> createState() => _SiteDetailScreenState();
}

class _SiteDetailScreenState extends State<SiteDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final siteId = ModalRoute.of(context)!.settings.arguments as String;
    final site = Provider.of<Sites>(context).findById(siteId);
    final authData = Provider.of<Auth>(context);
    final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(
      lattitude: site.location!.lattitude,
      longitude: site.location!.longitude,
    );
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      child: Text(
                        site.title,
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    if (authData.isAuth)
                      IconButton(
                        icon: Icon(site.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border),
                        onPressed: () {
                          site.toggleFavoriteStatus(authData.userId);
                          setState(() {
                            
                          });
                        },
                      ),

                  ],
                ),
                Divider(
                  color: Colors.black87,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/img/placeholder.png'),
                    image: NetworkImage(site.image),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 240,
                  ),
                ),
                Divider(
                  color: Colors.black87,
                ),
                Container(
                  child: SingleChildScrollView(
                    child: Text(
                      site.history,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                Text(
                  'Localización',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey)),
                  height: 170,
                  width: double.infinity,
                  child: staticMapImageUrl == null
                      ? Text(
                          'Error al cargar',
                          textAlign: TextAlign.center,
                        )
                      : Image.network(
                          staticMapImageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                ),
                Text(
                  site.location!.address as String,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          fullscreenDialog: true,
                          builder: (ctx) => MapScreen(
                                initialLocation: site.location as SiteLocation,
                                isSelecting: false,
                              )));
                    },
                    child: Text('Ver en el mapa')),
              ],
            ),
          ),
        ));
  }
}
