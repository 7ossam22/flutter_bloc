import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import '../../model/image.dart';
import '../../utils/consts.dart';

// ignore: must_be_immutable
class ImageViewWithShimmerLoading extends StatefulWidget {
  final ImageModel modelItem;
  final bool? isImageMemory;
  final int? rowItemCount;
  bool? isFavoriteScreen;
  final void Function() onTap;

  ImageViewWithShimmerLoading({
    Key? key,
    required this.modelItem,
    this.isImageMemory,
    this.rowItemCount,
    this.isFavoriteScreen,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ImageViewWithShimmerLoading> createState() =>
      _ImageViewWithShimmerLoadingState();
}

class _ImageViewWithShimmerLoadingState
    extends State<ImageViewWithShimmerLoading> {
  Uint8List? memoryImage;
  bool multiSelect = false;
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    if (isImagesMemory) {
      widget.modelItem
          .getUrlUInt8list(widget.modelItem.url[0])
          .then((value) => setState(() async {
                memoryImage = value;
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.hardEdge,
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          child: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
            if (widget.isImageMemory != null && widget.isImageMemory!)
              if (memoryImage != null)
                Image(
                  image: MemoryImage(memoryImage!),
                )
              else
                Center(
                    child: Shimmer.fromColors(
                  baseColor: Colors.white70,
                  highlightColor: Colors.grey,
                  enabled: true,
                  child: Container(
                    width: double.infinity,
                    height: 350 / (widget.rowItemCount ?? 1),
                    color: Colors.white70,
                  ),
                ))
            else if (widget.isFavoriteScreen!)
              CachedNetworkImage(
                httpHeaders: widget.modelItem.header,
                imageUrl:
                    widget.modelItem.getUrlString(widget.modelItem.url[0]),
                progressIndicatorBuilder: (context, url, progress) {
                  // ignore: unnecessary_null_comparison
                  if (progress != null) {
                    return Center(
                        child: Shimmer.fromColors(
                      baseColor: Colors.white70,
                      highlightColor: Colors.grey,
                      enabled: true,
                      child: Container(
                        width: double.infinity,
                        height: 350 / (widget.rowItemCount ?? 1),
                        color: Colors.white70,
                      ),
                    ));
                  } else {
                    return context.widget;
                  }
                },
              )
            else
              Image.network(
                widget.modelItem.getUrlString(widget.modelItem.url[0]),
                headers: widget.modelItem.header,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return Center(
                        child: Shimmer.fromColors(
                      baseColor: Colors.white70,
                      highlightColor: Colors.grey,
                      enabled: true,
                      child: Container(
                        width: double.infinity,
                        height: 350 / (widget.rowItemCount ?? 1),
                        color: Colors.white70,
                      ),
                    ));
                  } else {
                    return child;
                  }
                },
              ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Container(
                width: double.infinity,
                color: Colors.black54,
                child: Center(
                  child: Text(
                    widget.modelItem.title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}
