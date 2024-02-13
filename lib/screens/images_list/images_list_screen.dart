import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:scrappler_modified/model/image.dart';

import '../../Drawable/imageview/image_view.dart';
import '../../utils/consts.dart';

class ImageViewScreenArgs {
  final ImageModel modelItem;

  ImageViewScreenArgs({required this.modelItem});
}

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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Favorites",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Container(
        width: double.infinity,
        color: Theme.of(context).colorScheme.background,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              children: [
                imagesUrl.isNotEmpty
                    ? Expanded(
                        child: DynamicHeightGridView(
                          shrinkWrap: true,
                          mainAxisSpacing: 0,
                          builder: (context, index) =>
                              ImageViewWithShimmerLoading(
                            isFavoriteScreen: true,
                            onTap: () => Navigator.of(context).pushNamed(
                              '/imageView',
                              arguments: ImageViewScreenArgs(
                                modelItem: ImageModel(
                                    id: widget.images.id,
                                    title: widget.images.title,
                                    url: [imagesUrl[index]],
                                    lastElementId: widget.images.lastElementId,
                                    isFavorite: widget.images.isFavorite,
                                    header: widget.images.header),
                              ),
                            ),
                            modelItem: ImageModel(
                                id: widget.images.id,
                                title: widget.images.title,
                                url: [imagesUrl[index]],
                                lastElementId: widget.images.lastElementId,
                                isFavorite: widget.images.isFavorite,
                                header: widget.images.header),
                            isImageMemory: isImagesMemory,
                            rowItemCount: 2,
                          ),
                          itemCount: imagesUrl.length,
                          crossAxisCount: 1,
                        ),
                      )
                    : Expanded(
                        child: Center(
                          child: Text(
                            "Your favorite list is empty",
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
