import 'package:flutter/material.dart';

class SiteDetailScreen extends StatelessWidget {
  static const routeName = '/site-detail-screen';

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
                'Parque Nacional de Tikal',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              Divider(
                color: Colors.black87,
              ),
            ],
          ),
        ));
  }
}
