import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scrappler_modified/bloc/home/bloc/images_bloc.dart';
import '../../Drawable/customtextfield/CustomTextField.dart';
import '../../Drawable/imageview/image_view.dart';
import '../../model/image.dart';
import '../../utils/consts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String homeScreenRoute = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ImageModel> images = [];
  String search = "";
  int gridViewOption = 1;
  late ImagesBloc bloc;
  bool loadMore = false;

  getImagesData(String search) async {
    loadMore = true;
    bloc.add(ImagesRequestedWithQuery(query: search));
  }

  @override
  void initState() {
    super.initState();
    bloc = context.read<ImagesBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImagesBloc, ImagesState>(
      listener: (context, state) {
        if (state is ImagesError) {
          Fluttertoast.showToast(msg: state.err);
        }
        if (state is ImagesLoaded) {
          images = state.images;
          loadMore = false;
        }
      },
      builder: (context, state) => Scaffold(
        body: Container(
          color: Theme.of(context).colorScheme.background,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Search",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      InkWell(
                          onTap: () =>
                              Navigator.of(context).pushNamed("/profile"),
                          child: Icon(
                            Icons.person,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 30,
                          )),
                    ],
                  ),
                  PrimaryTextFieldWithHeader(
                      isObscure: false,
                      hintText: "What are you looking for",
                      onChangedValue: (value) {
                        if (value != search) {
                          bloc.add(ImagesClearRequested());
                        }
                        search = value;
                        getImagesData(search);
                      },
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      isEditable: true,
                      isRequired: true,
                      inputType: InputType.email),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () => setState(() {
                                  if (gridViewOption == 3) {
                                    gridViewOption = 1;
                                  } else {
                                    gridViewOption++;
                                  }
                                }),
                            child: Icon(
                              Icons.grid_view,
                              color: Theme.of(context).colorScheme.secondary,
                            )),
                        state is ImagesLoading
                            ? const Center(
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ]),
                  Expanded(
                    child: Center(
                        child: images.isNotEmpty
                            ? DynamicHeightGridView(
                                controller:
                                    ScrollController(keepScrollOffset: true),
                                shrinkWrap: true,
                                mainAxisSpacing: 0,
                                builder: (context, index) {
                                  if (index == images.length - 1 && !loadMore) {
                                    getImagesData(search);
                                  }
                                  return Stack(
                                    textDirection: TextDirection.rtl,
                                    children: [
                                      ImageViewWithShimmerLoading(
                                        isFavoriteScreen: false,
                                        onTap: () => Navigator.pushNamed(
                                            context, '/image_details',
                                            arguments: images[index]),
                                        modelItem: images[index],
                                        isImageMemory: isImagesMemory,
                                        rowItemCount: gridViewOption,
                                      ),
                                      if (images[index].subImagesSize > 1)
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Material(
                                            color:
                                                Colors.black.withOpacity(0.9),
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                images[index]
                                                    .subImagesSize
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                        )
                                    ],
                                  );
                                },
                                itemCount: images.length,
                                crossAxisCount: gridViewOption,
                              )
                            : Text(
                                "What are you searching for",
                                style: Theme.of(context).textTheme.bodyMedium,
                                textAlign: TextAlign.center,
                              )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
