import 'package:flutter/material.dart';

class Place with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String img;

  Place(
      {required this.id,
      required this.title,
      required this.description,
      required this.img});
}
