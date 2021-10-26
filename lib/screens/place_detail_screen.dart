import '../widgets/site_item.dart';
import 'package:flutter/material.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail-screen';

  @override
  Widget build(BuildContext context) {
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
                'Peten',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'La casa del gran jaguar',
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
                  itemBuilder: (ctx, i) => SiteItem(),
                  itemCount: 5,
                ),
              )
            ],
          ),
        ));
  }
}
