import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:scrappler_modified/bloc/image_details/image_details_cubit.dart';
import 'package:scrappler_modified/model/image.dart';

class ImageDetailsScreen extends StatefulWidget {
  final ImageModel image;

  const ImageDetailsScreen({super.key, required this.image});

  @override
  State<ImageDetailsScreen> createState() => _ImageDetailsScreenState();
}

class _ImageDetailsScreenState extends State<ImageDetailsScreen> {
  late bool isFavorite;
  late ImageDetailsCubit bloc;
  late ImageModel image;

  getImageOriginalData(ImageModel imageModel) async {
    final originalData = await bloc.getModelItem(imageModel);
    if (originalData.url.isNotEmpty) {
      setState(() {
        image = originalData;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<ImageDetailsCubit>(context);
    image = widget.image;
    getImageOriginalData(image);
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    isFavorite = widget.image.isFavorite ?? false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            ((image.url).isNotEmpty)
                ? BlocBuilder<ImageDetailsCubit, ImageDetailsState>(
                    builder: (context, state) {
                      if (state is ImageDetailsLoaded) {
                        return PhotoView(
                            disableGestures: false,
                            enableRotation: false,
                            initialScale: PhotoViewComputedScale.contained,
                            minScale: PhotoViewComputedScale.contained * 0.8,
                            maxScale: PhotoViewComputedScale.covered * 1.8,
                            filterQuality: FilterQuality.high,
                            backgroundDecoration:
                                const BoxDecoration(color: Colors.transparent),
                            imageProvider: NetworkImage(
                              image.url[0],
                              headers: image.header,
                            ),
                            wantKeepAlive: true,
                            loadingBuilder: (context, event) => event != null
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                    value: (event.cumulativeBytesLoaded
                                            .toDouble()) /
                                        (event.expectedTotalBytes ?? 2))
                                : const SizedBox());
                      } else if (state is ImageErrorLoading) {
                        return const Center(
                            child: Icon(
                          Icons.error,
                          color: Colors.white,
                          size: 30,
                        ));
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      }
                    },
                  )
                : BlocBuilder<ImageDetailsCubit, ImageDetailsState>(
                    builder: (context, state) {
                      if (state is ImageDetailsLoaded) {
                        return PhotoView(
                            disableGestures: false,
                            enableRotation: false,
                            initialScale: PhotoViewComputedScale.contained,
                            minScale: PhotoViewComputedScale.contained * 0.8,
                            maxScale: PhotoViewComputedScale.covered * 1.8,
                            filterQuality: FilterQuality.high,
                            backgroundDecoration:
                                const BoxDecoration(color: Colors.transparent),
                            imageProvider: NetworkImage(
                              image.url[0],
                              headers: image.header,
                            ),
                            wantKeepAlive: true,
                            loadingBuilder: (context, event) => event != null
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                    value: (event.cumulativeBytesLoaded
                                            .toDouble()) /
                                        (event.expectedTotalBytes ?? 2))
                                : const SizedBox());
                      } else if (state is ImageErrorLoading) {
                        return const Center(
                            child: Icon(
                          Icons.error,
                          color: Colors.white,
                          size: 30,
                        ));
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      }
                    },
                  ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Column(
                      children: [
                        Text(
                          image.title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // ignore: prefer_const_constructors
                            InkWell(
                              // onTap: () =>
                              //     viewModel.downloadData(args!.modelItem),
                              child: const Icon(
                                Icons.get_app,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            // if (downloading != null &&
                            //     downloading! > 0 &&
                            //     downloading! < 100)
                            //   Padding(
                            //       padding:
                            //       const EdgeInsets.symmetric(vertical: 2.0),
                            //       child: Text(
                            //         "${downloading!.toInt()}%",
                            //         style: const TextStyle(
                            //             color: Colors.white,
                            //             fontSize: 18,
                            //             fontWeight: FontWeight.bold),
                            //       ))
                            // else
                            //   const SizedBox(),
                            InkWell(
                              onTap: () => setState(() {
                                isFavorite = !isFavorite;
                                // viewModel.manageFavoriteList(
                                //     args!.modelItem, isFavorite);
                              }),
                              child: Icon(
                                !isFavorite
                                    ? Icons.favorite_border
                                    : Icons.favorite,
                                color: Colors.white,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
