import 'package:flutter/material.dart';
import 'package:scrappler_modified/model/image.dart';

class ImagesListScreen extends StatefulWidget {
  final ImageModel images;

  const ImagesListScreen({super.key, required this.images});

  static const String imageListScreenRoute = '/images_list';

  @override
  State<ImagesListScreen> createState() => _ImagesListScreenState();
}

class _ImagesListScreenState extends State<ImagesListScreen> {
  List<String> imagesUrl = [];

  @override
  void didChangeDependencies() {
    imagesUrl = widget.images.url;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
