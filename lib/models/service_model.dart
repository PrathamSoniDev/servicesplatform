import 'package:flutter/cupertino.dart';

class ServiceModel {
  final String name;
  final String description;
  final String fullDescription;
  final List<String> imageUrl;

  final List<String> features;
  final List<String> technologies;
  final String category;
  final String deliveryTime;
  final String scalability;
  final IconData icon;

  ServiceModel({
    required this.name,
    required this.description,
    required this.fullDescription,
    required this.imageUrl,
    required this.features,
    required this.technologies,
    required this.category,
    required this.deliveryTime,
    required this.scalability,
    required this.icon,
  });
}
