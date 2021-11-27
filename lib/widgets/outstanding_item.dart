import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../screens/site_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/site.dart';
import '../providers/places_provider.dart';
class OutstandingItem extends StatelessWidget {
  Site site;

  OutstandingItem({Key? key,required this.site}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final place= Provider.of<Places>(context).findById(site.placeId);
    return InkWell(
      onTap: (){
         Navigator.of(context).pushNamed(SiteDetailScreen.routeName);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)),
              child: GestureDetector(
                onTap: () {},
                child:Container(
                  height: 200,
                  width: double.infinity,
                  child: FadeInImage(
                    placeholder: AssetImage('assets/img/placeholder.png'),
                    image: NetworkImage(site.image),
                    fit: BoxFit.cover,
                  ),
                ), 
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                      site.title,
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    site.description,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 15,),
                  FittedBox(
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Colors.blue,
                        ),
                        Text(
                          place.title,
                          style: TextStyle(color: Colors.blue, fontSize: 18),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



/* ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {},
          child: Image.network(
            'https://firebasestorage.googleapis.com/v0/b/example-89004.appspot.com/o/yaxha.jpg?alt=media&token=7c658869-8351-4f52-9962-a13e3db392c2',
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
          title: FittedBox(
            child: Text(
              'Yaxhá',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    ) */