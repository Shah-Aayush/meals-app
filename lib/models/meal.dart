// import 'package:flutter/foundation.dart';

enum Complexity {
  Simple,
  Challenging,
  Hard,
}

enum Affordability {
  Affordable,
  Pricey,
  Luxurious,
}

class Meal {
  final String id;
  final List<String>
      categories; //so that a meal can contain more than one categories.
  final String title;
  final String imageUrl; //network image url
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final Complexity complexity; //using custom Enum Complexity.
  final Affordability affordability; //using custom Enum Affordability.
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  const Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.complexity,
    required this.affordability,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
  });
}
