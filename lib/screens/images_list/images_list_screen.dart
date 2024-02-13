import 'package:flutter/material.dart';

class ImagesListScreen extends StatefulWidget {
  final List<String> images;

  const ImagesListScreen({super.key, required this.images});

  static const String imageListScreenRoute = '/images_list';

  @override
  State<ImagesListScreen> createState() => _ImagesListScreenState();
}

class _ImagesListScreenState extends State<ImagesListScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
