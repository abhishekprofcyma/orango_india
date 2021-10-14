import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanam_social/data/cubit/post_list/post_list_cubit.dart';
import 'package:vanam_social/data/cubit/post_list/post_list_state.dart';
import 'package:vanam_social/data/remote/model/post/post_list_response.dart';
import 'package:vanam_social/screens/home/home/component/post_item_view.dart';

enum PostMediaType { Image, Video }

class PostMedia {
  final PostMediaType type;
  final String url;

  PostMedia(this.type, this.url);
}

class HomeTabPostsView extends StatefulWidget {
  @override
  _HomeTabPostsViewState createState() => _HomeTabPostsViewState();
}

class _HomeTabPostsViewState extends State<HomeTabPostsView> {
  late PostListCubit _cubit;
  PostListResponse? _postListResponse;
  List<PostListResponseDataPostListData?>? postList = [];
  ScrollController? _scrollController;
  double? _scrollPosition;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController?.position.pixels;
      if (_scrollController?.position.pixels ==
          _scrollController?.position.maxScrollExtent) {
        if ((_postListResponse?.data?.postList?.lastPage ?? 0) >
            (_postListResponse?.data?.postList?.currentPage ?? 0)) {
          _cubit.postList(context,(_postListResponse?.data?.postList?.currentPage ?? 1) + 1,0);

        }
      }
    });
  }

  @override
  void initState() {
    _cubit = BlocProvider.of<PostListCubit>(context, listen: false);
    super.initState();
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollListener);
    _cubit.postList(context,1,0);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: postList?.length,
              physics: AlwaysScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                PostListResponseDataPostListData? post = postList?[index];

                return PostItemView(post: post,);
              }),
          BlocConsumer<PostListCubit,PostListState>(
              builder: (context, state) {
                return Container();
              },
              listener: (context, state) {
                if(state is PostListLoaded){
                  postList?.addAll(state.response.data!.postList!.data!);
                  _postListResponse = state.response;
                  setState(() {
                  });
                }
              })
        ],
      ),
    );
  }
}
