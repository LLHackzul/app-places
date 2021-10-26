import 'package:flutter/material.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName= '/place-detail-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Peten', style: TextStyle(color: Colors.black87),),
            Text('La casa del gran jaguar', style: TextStyle(color: Colors.grey),),
          ],
        ),
      ),
      body: ListView.builder(itemBuilder: (ctx,i)=>Card( elevation: 8,child: ListTile(title: Text('Parque nacional de tikal'), leading: CircleAvatar(child: Icon(Icons.home),),)), itemCount: 5,),
    );
  }
}