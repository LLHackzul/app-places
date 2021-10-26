/* import 'package:flutter/material.dart';
import '../models/site.dart';

class Sites with ChangeNotifier {
  List<Site> _items=[];

  List<Site> get items{
    return [..._items];
  }

  Site findById(String id){
    return _items.firstWhere((item) =>item.id==id );
  }

  void addSite(Site site){
    final newSite= Site(
      id: DateTime.now().toString(),
      title: site.title,
      description: site.description,

     );
  }
} */