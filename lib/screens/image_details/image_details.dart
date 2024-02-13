import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_view/photo_view.dart';
import 'package:scrappler_modified/model/image.dart';

import '../../bloc/image_details/bloc/image_details_bloc.dart';

class ImageDetailsScreen extends StatefulWidget {
  final ImageModel image;

  const ImageDetailsScreen({super.key, required this.image});

  static const String imageDetailsScreenRoute = '/image_details';

  @override
  State<ImageDetailsScreen> createState() => _ImageDetailsScreenState();
}

class _ImageDetailsScreenState extends State<ImageDetailsScreen> {
  late bool isFavorite;
  late ImageDetailsBloc bloc;
  late ImageModel image;

  // getImageOriginalData(ImageModel imageModel) async {
  //   final originalData = await bloc.getModelItem(imageModel);
  //   if (originalData.url.isNotEmpty) {
  //     setState(() {
  //       image = originalData;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    bloc = context.read<ImageDetailsBloc>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    image = widget.image;
    bloc.add(ImageOriginalDataRequested(imageModel: widget.image));
    // getImageOriginalData(image);
  }

  @override
  void dispose() {
    // bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    isFavorite = widget.image.isFavorite ?? false;
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black12,
        ),
        backgroundColor: Colors.black,
        body: BlocConsumer<ImageDetailsBloc, ImageDetailsState>(
          listener: (context, state) {
            if (state is ImageDataBase) {
              isFavorite = state.isAdded;
            }
            if (state is ImageDataBase) {
              Fluttertoast.showToast(msg: state.msg);
            }
          },
          builder: (context, state) {
            return Center(
              child: state is ImageDetailsLoaded
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        PhotoView(
                            disableGestures: false,
                            enableRotation: false,
                            initialScale: PhotoViewComputedScale.contained,
                            minScale: PhotoViewComputedScale.contained * 0.8,
                            maxScale: PhotoViewComputedScale.covered * 1.8,
                            filterQuality: FilterQuality.high,
                            backgroundDecoration:
                                const BoxDecoration(color: Colors.transparent),
                            imageProvider: NetworkImage(
                              state.image.url[0],
                              headers: image.header,
                            ),
                            wantKeepAlive: true,
                            loadingBuilder: (context, event) => event != null
                                ? Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.white,
                                        value: (event.cumulativeBytesLoaded
                                                .toDouble()) /
                                            (event.expectedTotalBytes ?? 2)),
                                  )
                                : const SizedBox()),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
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
                                          onTap: () => bloc.add(
                                              ImageAddOrRemoveToDataBaseRequested(
                                                  imageModel: state.image)),
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
                    )
                  : state is ImageError
                      ? const Center(
                          child: Icon(
                          Icons.error,
                          color: Colors.white,
                          size: 30,
                        ))
                      : const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
            );
          },
        ),
      ),
    );
  }
}



// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:photo_view/photo_view.dart';
// import 'package:scrappler_modified/model/image.dart';
//
// import '../../bloc/image_details/bloc/image_details_bloc.dart';
//
// class ImageDetailsScreen extends StatefulWidget {
//   final ImageModel image;
//
//   const ImageDetailsScreen({super.key, required this.image});
//
//   @override
//   State<ImageDetailsScreen> createState() => _ImageDetailsScreenState();
// }
//
// class _ImageDetailsScreenState extends State<ImageDetailsScreen> {
//   late bool isFavorite;
//   late ImageDetailsBloc bloc;
//   late ImageModel image;
//
//   // getImageOriginalData(ImageModel imageModel) async {
//   //   final originalData = await bloc.getModelItem(imageModel);
//   //   if (originalData.url.isNotEmpty) {
//   //     setState(() {
//   //       image = originalData;
//   //     });
//   //   }
//   // }
//
//   @override
//   void initState() {
//     super.initState();
//     bloc = context.read<ImageDetailsBloc>();
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     image = widget.image;
//     bloc.add(ImageOriginalDataRequested(imageModel: widget.image));
//     // getImageOriginalData(image);
//   }
//
//   @override
//   void dispose() {
//     // bloc.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     isFavorite = widget.image.isFavorite ?? false;
//     return BlocProvider(
//       create: (context) => bloc,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.black12,
//         ),
//         backgroundColor: Colors.black,
//         body: BlocConsumer<ImageDetailsBloc, ImageDetailsState>(
//           listener: (context, state) {
//             if (state is ImageDataBase) {
//               isFavorite = state.isAdded;
//             }
//             if (state is ImageDataBase) {
//               Fluttertoast.showToast(msg: state.msg);
//             }
//           },
//           builder: (context, state) {
//             return Center(
//               child: state is ImageDetailsLoaded
//                   ? CarouselSlider.builder(
//                 itemBuilder:
//                     (BuildContext context, int index, int realIndex) =>
//                     Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         PhotoView(
//                             disableGestures: false,
//                             enableRotation: false,
//                             initialScale: PhotoViewComputedScale.contained,
//                             minScale: PhotoViewComputedScale.contained * 0.8,
//                             maxScale: PhotoViewComputedScale.covered * 1.8,
//                             filterQuality: FilterQuality.high,
//                             backgroundDecoration: const BoxDecoration(
//                                 color: Colors.transparent),
//                             imageProvider: NetworkImage(
//                               state.image.url[index],
//                               headers: image.header,
//                             ),
//                             wantKeepAlive: true,
//                             loadingBuilder: (context, event) => event != null
//                                 ? Center(
//                               child: CircularProgressIndicator(
//                                   color: Colors.white,
//                                   value: (event.cumulativeBytesLoaded
//                                       .toDouble()) /
//                                       (event.expectedTotalBytes ?? 2)),
//                             )
//                                 : const SizedBox()),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const SizedBox(),
//                             Container(
//                               decoration: const BoxDecoration(
//                                 color: Colors.black54,
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 15.0),
//                                 child: Column(
//                                   children: [
//                                     Text(
//                                       image.title,
//                                       style: const TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceEvenly,
//                                       children: [
//                                         // ignore: prefer_const_constructors
//                                         InkWell(
//                                           // onTap: () =>
//                                           //     viewModel.downloadData(args!.modelItem),
//                                           child: const Icon(
//                                             Icons.get_app,
//                                             color: Colors.white,
//                                             size: 30,
//                                           ),
//                                         ),
//                                         // if (downloading != null &&
//                                         //     downloading! > 0 &&
//                                         //     downloading! < 100)
//                                         //   Padding(
//                                         //       padding:
//                                         //       const EdgeInsets.symmetric(vertical: 2.0),
//                                         //       child: Text(
//                                         //         "${downloading!.toInt()}%",
//                                         //         style: const TextStyle(
//                                         //             color: Colors.white,
//                                         //             fontSize: 18,
//                                         //             fontWeight: FontWeight.bold),
//                                         //       ))
//                                         // else
//                                         //   const SizedBox(),
//                                         InkWell(
//                                           onTap: () => bloc.add(
//                                               ImageAddOrRemoveToDataBaseRequested(
//                                                   imageModel: state.image)),
//                                           child: Icon(
//                                             !isFavorite
//                                                 ? Icons.favorite_border
//                                                 : Icons.favorite,
//                                             color: Colors.white,
//                                             size: 30,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                 itemCount: state.image.url.length,
//                 options: CarouselOptions(
//                   scrollDirection: Axis.horizontal,
//                   enlargeCenterPage: true,
//                   enableInfiniteScroll: false,
//                   height: double.infinity,
//                 ),
//               )
//                   : state is ImageError
//                   ? const Center(
//                   child: Icon(
//                     Icons.error,
//                     color: Colors.white,
//                     size: 30,
//                   ))
//                   : const Center(
//                 child: CircularProgressIndicator(
//                   color: Colors.white,
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

