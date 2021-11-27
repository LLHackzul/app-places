import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sites_provider.dart';
import '../widgets/site_item.dart';
import '../providers/site.dart';
class UserFavoritesScreen extends StatefulWidget {
  static const routeName = '/user-favorite-screen';

  @override
  _UserFavoritesScreenState createState() => _UserFavoritesScreenState();
}

class _UserFavoritesScreenState extends State<UserFavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final sitesData = Provider.of<Sites>(context);
    final sites= sitesData.favoriteItems;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tus lugares favoritos',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              const Divider(
                color: Colors.black87,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (ctx, i) => SiteItem(
                    site: sites[i] as Site,
                  ),
                  itemCount: sites.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
