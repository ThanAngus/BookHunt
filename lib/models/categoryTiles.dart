import 'package:flutter/material.dart';

class GenreModel {
  final String title;
  final String icon;

  GenreModel({
    required this.title,
    required this.icon,
  });
}

List<GenreModel> category = [
  GenreModel(
    title: "Fiction",
    icon: "assets/images/Fiction.svg",
  ),
  GenreModel(
    title: "Drama",
    icon: "assets/images/Drama.svg",
  ),
  GenreModel(
    title: "Humour",
    icon: "assets/images/Humour.svg",
  ),
  GenreModel(
    title: "Politics",
    icon: "assets/images/Politics.svg",
  ),
  GenreModel(
    title: "Philosophy",
    icon: "assets/images/Philosophy.svg",
  ),
  GenreModel(
    title: "History",
    icon: "assets/images/History.svg",
  ),
  GenreModel(
    title: "Adventure",
    icon: "assets/images/Adventure.svg",
  ),
];
