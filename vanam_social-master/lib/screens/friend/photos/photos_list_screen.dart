import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vanam_social/data/cubit/gallery/gallery_cubit.dart';
import 'package:vanam_social/data/cubit/gallery/gallery_state.dart';
import 'package:vanam_social/data/remote/model/gallery/GalleryImageResponse.dart';
import 'package:vanam_social/data/remote/model/gallery/GalleryVideoResponse.dart';
import 'package:vanam_social/screens/home/components/vanam_image_viewer.dart';

import '../../../constants.dart';

class PhotosListScreen extends StatefulWidget {
  final int friendId;

  const PhotosListScreen({Key? key, this.friendId = 0}) : super(key: key);

  @override
  _PhotosListScreenState createState() => _PhotosListScreenState();
}

class _PhotosListScreenState extends State<PhotosListScreen> {
  late GalleryCubit _cubit;
  List<GalleryImageItem>? images = [];
  List<GalleryVideoItem>? videos = [];

  @override
  void initState() {
    _cubit = BlocProvider.of(context, listen: false);
    super.initState();
    if (widget.friendId != 0) {
      _cubit.galleryImage(context, widget.friendId);
      _cubit.galleryVideo(context, widget.friendId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kPrimaryColor),
        leading: IconButton(
          icon: SvgPicture.asset("assets/images/ic_back_arrow_green.svg"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Photos",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: BlocConsumer<GalleryCubit,GalleryState>(builder: (context, state) {
        return Stack(
          children: [
            SafeArea(
              child: Container(
                margin: EdgeInsets.all(12),
                child: StaggeredGridView.countBuilder(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                    itemCount: images?.length,
                    itemBuilder: (context, index) {
                      GalleryImageItem? imageItem = images?[index];
                      return InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      VanamImageViewer(
                                        url:
                                        "$ImageBaseUrl${imageItem?.url}",
                                      )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: Image.network("$ImageBaseUrl${imageItem?.url}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                    staggeredTileBuilder: (index) {
                      return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
                    }),
              ),
            ),
            if(state is GalleryImageCompleted && images?.length == 0 )Center(child: Text("Photo list is empty"),)
          ],
        );
      }, listener: (context, state) {
        if (state is GalleryImageCompleted) {
          images?.addAll(state.response.data!.postImageList!.data!);
        }
      }),
    );
  }
}
