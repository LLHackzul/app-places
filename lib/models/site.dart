import 'package:flutter/material.dart';
import 'dart:io';

class SiteLocation {
  final double lattitude;
  final double longitude;
  final String? address;
  SiteLocation(
      {required this.lattitude, required this.longitude, this.address});
}

class Site {
  final String id;
  final String title;
  final String description;
  final String history;
  final String? phone; 
  final String? email;
  final SiteLocation? location;
  final List<String>? imageArray;

  Site(
      {required this.id,
      required this.title,
      required this.description,
      required this.history,
      this.phone,
      this.email,
      this.location,
      this.imageArray});
}
