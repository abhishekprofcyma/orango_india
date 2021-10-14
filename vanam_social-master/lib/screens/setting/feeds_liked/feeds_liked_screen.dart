import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vanam_social/data/cubit/post_list/post_list_cubit.dart';
import 'package:vanam_social/data/cubit/post_list/post_list_state.dart';
import 'package:vanam_social/data/remote/model/post/image_like_list_response.dart';
import 'package:vanam_social/screens/home/components/vanam_image_viewer.dart';

import '../../../constants.dart';

class FeedsLikedScreen extends StatefulWidget {
  @override
  _FeedsLikedScreenState createState() => _FeedsLikedScreenState();
}

class _FeedsLikedScreenState extends State<FeedsLikedScreen> {
  late PostListCubit _cubit;
  ImageLikeListResponse? _imageLikeListResponse;
  List<ImageLikeListResponseDataPostImageListData?>? imageList = [];
  ScrollController? _scrollController;
  double? _scrollPosition;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController?.position.pixels;
      if (_scrollController?.position.pixels ==
          _scrollController?.position.maxScrollExtent) {
        if ((_imageLikeListResponse?.data?.postImageList?.lastPage ?? 0) >
            (_imageLikeListResponse?.data?.postImageList?.currentPage ?? 0)) {
          _cubit.postList(context,(_imageLikeListResponse?.data?.postImageList?.currentPage ?? 1) + 1,0);

        }
      }
    });
  }

  @override
  void initState() {
    _cubit = BlocProvider.of<PostListCubit>(context,listen: false);
    super.initState();
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollListener);
    _cubit.imageLikeList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kPrimaryColor),
        leading: IconButton(
          icon: SvgPicture.asset("assets/images/ic_back_arrow_green.svg"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Likes",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: BlocConsumer<PostListCubit,PostListState>(builder: (context,state){
        return SafeArea(
          child: Container(
            margin: EdgeInsets.all(12),
            child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                itemCount: imageList?.length,
                itemBuilder: (context, index) {
                  ImageLikeListResponseDataPostImageListData? image = imageList?[index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>VanamImageViewer(url: "$ImageBaseUrl${image?.url}",)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: Image.network("$ImageBaseUrl${image?.url}",
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
        );
      }, listener: (context,state){
        if(state is PostLikeListAdded){
          imageList?.addAll(state.response.data!.postImageList!.data!);
          _imageLikeListResponse = state.response;
          setState(() {
          });
        }
      }),
    );
  }
}
