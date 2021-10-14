import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vanam_social/data/cubit/post_list/post_list_cubit.dart';
import 'package:vanam_social/data/cubit/post_list/post_list_state.dart';
import 'package:vanam_social/data/remote/model/post/PostCommentListResponse.dart';
import 'package:vanam_social/data/remote/model/post/post_list_response.dart';
import 'package:vanam_social/screens/components/loading_view.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vanam_social/screens/home/home/component/comment/recommet_view.dart';

import '../../../../../main.dart';


class CommentView extends StatefulWidget {
  final PostListResponseDataPostListData post;

  const CommentView({Key? key, required this.post}) : super(key: key);

  @override
  _CommentViewState createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  PostListResponseDataPostListData? post;
  List<CommentItem> comments = [];
  late PostCommentListResponse postCommentListResponse;
  late PostListCubit _bloc;
  int expandRecommentIndex = -1;
  ScrollController? _scrollController;
  double? _scrollPosition;
  TextEditingController comment = TextEditingController();

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController?.position.pixels;
      if (_scrollController?.position.pixels ==
          _scrollController?.position.maxScrollExtent) {
        if ((postCommentListResponse.data?.postList?.lastPage ?? 0) >
            (postCommentListResponse.data?.postList?.currentPage ?? 0)) {
          _bloc.fetchCommentList(context,post?.id??0,(postCommentListResponse.data?.postList?.currentPage ?? 1) +  1);

        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = BlocProvider.of<PostListCubit>(context, listen: false);
    setState(() {
      post = widget.post;
    });
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollListener);
    _bloc.fetchCommentList(context, widget.post.id??0, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Comments",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: new Container(
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0))),
          child: ListView(
            controller: _scrollController,
            children: [
              //PostCard(post: post!, isDesktop: false),
              BlocConsumer<PostListCubit, PostListState>(builder: (context, state) {
                if (state is PostCommentListLoading) {
                  return Center(
                    child: LoadingView(),
                  );
                }
                return Container(
                  child: ListView.builder(
                      itemCount: comments.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var comment = comments[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                child: Text(comment.user!.name!
                                    .substring(0, 1)
                                    .toString()
                                    .toUpperCase()),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      comment.user!.name!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          ?.copyWith(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                    ),
                                    Text(
                                      comment.comment!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          timeago.format(stringToDateTime1(
                                              comment.createdAt.toString()).add(Duration( hours: 6))),
                                          style:
                                          TextStyle(color: Colors.grey),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Icon(
                                          Icons.circle,
                                          color: Colors.grey,
                                          size: 10,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "Replay ${comment.recomment!.length}",
                                          style:
                                          TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                    ListView.builder(
                                        itemCount:
                                        index == expandRecommentIndex
                                            ? comment.recomment!.length
                                            : 0,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, subindex) {
                                          return Container(
                                            padding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 8),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  child: Text(comment
                                                      .recomment![subindex]
                                                      .user!
                                                      .name!
                                                      .substring(0, 1)
                                                      .toString()
                                                      .toUpperCase()),
                                                  radius: 14,
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      comment
                                                          .recomment![
                                                      subindex]
                                                          .user!
                                                          .name!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption
                                                          ?.copyWith(
                                                          fontWeight:
                                                          FontWeight
                                                              .bold,
                                                          color: Colors
                                                              .black),
                                                      textAlign:
                                                      TextAlign.left,
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      softWrap: true,
                                                    ),
                                                    Text(
                                                      comment
                                                          .recomment![
                                                      subindex]
                                                          .comment
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .caption,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        }),
                                    index == expandRecommentIndex
                                        ? Container()
                                        : ((comment.recomment?.length ?? 0) !=
                                        0)
                                        ? TextButton(
                                        onPressed: () {
                                          setState(() {
                                            expandRecommentIndex =
                                                index;
                                          });
                                        },
                                        child: Text(" View Reply"))
                                        : Container()
                                  ],
                                ),
                              ),
                              TextButton(
                                  onPressed: () async {
                                    var result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RecommentAddView(
                                                  post: post!,
                                                  comment: comment,
                                                )));
                                    setState(() {
                                      comments = [];
                                    });
                                    _bloc.fetchCommentList(context,
                                        post!.id??0, 1);
                                  },
                                  child: Text("Reply"))
                            ],
                          ),
                        );
                      }),
                );
              }, listener: (context, state) {
                if (state is PostCommentListCompleted) {

                    print("current page ${state.postCommentListResponse.data?.postList?.currentPage}");
                    if(state.postCommentListResponse.data?.postList?.currentPage == 1){
                      comments = [];
                    }
                    comments.addAll(
                        state.postCommentListResponse.data!.postList!.data!);
                    postCommentListResponse = state.postCommentListResponse;
                    setState(() {
                    });
                }
              }),
              // TextButton(
              //     onPressed: () {
              //       _bloc.fetchCommentList(context,
              //           post!.id??0,
              //           postCommentListResponse.data!.postList!.currentPage! +
              //               1);
              //     },
              //     child: Text("More")),
              BlocConsumer<PostListCubit, PostListState>(builder: (context, state) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  height: 36,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      border: Border.all(color: Color(0xffACACAC))),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: comment,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Leave a Comment",
                              hintStyle: TextStyle(color: Color(0xffACACAC))),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print("on comment tap");
                          showLoaderDialog(context);
                          _bloc.fetchComment(context,
                              post!.id.toString(), comment.text.trim());
                        },
                        child: Icon(Icons.send),
                      )
                    ],
                  ),
                );
              }, listener: (context, state) {
                if (state is PostCommentCompleted) {
                  Navigator.pop(context);
                  comment.text = "";
                  _bloc.fetchCommentList(context,
                      post!.id??0,
                      1);
                  /*setState(() {
                    //commentExtra++;
                  });*/
                }
              }),
              SizedBox(
                height: 8,
              ),
            ],
          )),
    );
  }
}