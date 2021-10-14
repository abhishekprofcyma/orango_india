import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vanam_social/data/cubit/post_list/post_list_cubit.dart';
import 'package:vanam_social/data/cubit/post_list/post_list_state.dart';
import 'package:vanam_social/data/remote/model/post/PostCommentListResponse.dart';
import 'package:vanam_social/data/remote/model/post/post_list_response.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../main.dart';


class RecommentAddView extends StatefulWidget {
  final PostListResponseDataPostListData post;
  final CommentItem comment;

  const RecommentAddView({Key? key, required this.post, required this.comment})
      : super(key: key);

  @override
  _RecommentAddViewState createState() => _RecommentAddViewState();
}

class _RecommentAddViewState extends State<RecommentAddView> {
  PostListResponseDataPostListData? post;
  CommentItem? comment;
  TextEditingController recommet = TextEditingController();
  PostListCubit? _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = BlocProvider.of<PostListCubit>(context, listen: false);
    setState(() {
      post = widget.post;
      comment = widget.comment;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Re-Comments",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: new Container(
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0))),
          child: Column(
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      child: Text(comment!.user!.name!
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            comment!.user!.name!,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                          Text(
                            comment!.comment!,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Row(
                            children: [
                              Text(
                                timeago.format(stringToDateTime1(
                                    comment!.createdAt.toString()).add(Duration( hours: 6))),
                                style: TextStyle(color: Colors.grey),
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
                                "Replay ${comment!.recomment!.length}",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          // ListView.builder(
                          //     itemCount: comment!.recomment!.length,
                          //     shrinkWrap: true,
                          //     itemBuilder: (context, index) {
                          //       return Container(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 8, vertical: 8),
                          //         child: Row(
                          //           children: [
                          //             CircleAvatar(
                          //               child: Text(comment!
                          //                   .recomment![index].user!.name!
                          //                   .substring(0, 1)
                          //                   .toString()
                          //                   .toUpperCase()),
                          //               radius: 14,
                          //             ),
                          //             SizedBox(
                          //               width: 8,
                          //             ),
                          //             Column(
                          //               children: [
                          //                 Text(
                          //                   comment!.user!.name!,
                          //                   style: Theme.of(context)
                          //                       .textTheme
                          //                       .caption
                          //                       ?.copyWith(
                          //                       fontWeight: FontWeight.bold,
                          //                       color: Colors.black),
                          //                   textAlign: TextAlign.left,
                          //                   overflow: TextOverflow.ellipsis,
                          //                   softWrap: true,
                          //                 ),
                          //                 Text(
                          //                   comment!.comment!,
                          //                   style: Theme.of(context)
                          //                       .textTheme
                          //                       .caption,
                          //                 ),
                          //               ],
                          //             )
                          //           ],
                          //         ),
                          //       );
                          //     })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
                          controller: recommet,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Replay a Comment",
                              hintStyle: TextStyle(color: Color(0xffACACAC))),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print("on comment tap");
                          _bloc?.postRecommentAdd(context,post!.id.toString(),
                              comment!.id.toString(), recommet.text.trim());
                        },
                        child: Icon(Icons.send),
                      )
                    ],
                  ),
                );
              }, listener: (context, state) {
                if (state is PostRecommentAdded) {
                  Fluttertoast.showToast(msg: "Recomment Added");
                  Navigator.pop(context, true);
                }
              }),
            ],
          )),
    );
  }
}
