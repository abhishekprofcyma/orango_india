import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:vanam_social/data/cubit/post_list/post_list_cubit.dart';
import 'package:vanam_social/data/cubit/post_list/post_list_state.dart';
import 'package:vanam_social/data/local/shared_pref.dart';
import 'package:vanam_social/data/remote/model/post/post_list_response.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';
import 'package:vanam_social/screens/components/video_player_view.dart';
import 'package:vanam_social/screens/friend/friend_screen.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vanam_social/screens/group/group/group_screen.dart';
import 'package:vanam_social/screens/home/components/vanam_image_viewer.dart';
import 'package:vanam_social/screens/home/home/component/post_share_view.dart';
import 'package:vanam_social/screens/home/home_screen.dart';
import 'package:vanam_social/screens/profile/profile_screen.dart';
import 'package:video_player/video_player.dart';
import 'dart:ui' as ui;
import '../../../../constants.dart';
import '../../../../main.dart';
import 'comment/comment_view.dart';
import 'home_tab_post_view.dart';

class PostItemView extends StatefulWidget {
  final PostListResponseDataPostListData? post;

  const PostItemView({Key? key, required this.post}) : super(key: key);

  @override
  _PostItemViewState createState() => _PostItemViewState();
}

class _PostItemViewState extends State<PostItemView> {
  late PostListCubit _cubit;
  PostListResponseDataPostListData? post;
  List<PostMedia>? postMedia = [];
  String userName = "";
  String userImage = "";
  String userId = "";

  init() async {
    userName = await getUserName();
    userImage = await getUserImage();
    userId = (await getUserId())!;
    setState(() {});
  }

  @override
  void initState() {
    _cubit = BlocProvider.of<PostListCubit>(context, listen: false);
    super.initState();
    init();

    setState(() {
      post = widget.post;
      if (post?.postCount == null) {
        post?.postCount = PostListResponseDataPostListDataPostCount(
            id: 0,
            like: 0,
            favoirate: 0,
            comment: 0,
            postId: post?.id,
            share: 0);
      }
      if (post?.postUserCount == null) {
        post?.postUserCount = PostListResponseDataPostListDataPostUserCount(
          id: 0,
          postId: post?.id,
          favoirate: 0,
          like: 0,
          userId: 0,
        );
      }
      post?.postImage?.forEach((element) {
        postMedia?.add(PostMedia(PostMediaType.Image, element?.url ?? ""));
      });
      post?.postVideo?.forEach((element) {
        postMedia?.add(PostMedia(PostMediaType.Video, element?.url ?? ""));
      });
    });
    print("post item ---- ${post.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostListCubit, PostListState>(
        builder: (context, state) {
      return Container(
        margin: post?.sharePost != null ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8) : const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        decoration:post?.sharePost != null ?  BoxDecoration(
          // border: Border.all(color: Color(0xff078F10).withOpacity(0.4),width: 0.5),
            color: Theme.of(context).backgroundColor,
            boxShadow: [
              BoxShadow(
                  color: Color(0xffD8EDD9),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0.3, 1.6))
            ],
            borderRadius: BorderRadius.circular(12)):null,
        child: Column(
          children: [
            if (post?.sharePost != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        post?.sharePost?.shareBy?.image == null
                            ? SvgPicture.asset(
                          "assets/images/user.svg",
                          height: 32,
                          width: 32,
                        )
                            : CircleAvatar(
                          backgroundImage: NetworkImage(
                              "$ImageBaseUrl${post?.sharePost?.shareBy?.image}"),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${post?.sharePost?.shareBy?.name} Shared a new Post",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              "${timeago.format(stringToDateTime(post?.sharePost?.createdAt ?? "").add(Duration(hours: 6)))}",
                              style: Theme.of(context).textTheme.caption,
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 6,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${post?.sharePost?.name}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(color: Colors.black),
                          maxLines: 4,
                          softWrap: true,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            Container(
              //padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                  // border: Border.all(color: Color(0xff078F10).withOpacity(0.4),width: 0.5),
                  color: Theme.of(context).backgroundColor,
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xffD8EDD9),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0.3, 1.6))
                  ],
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      if (post?.group != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GroupScreen(
                                    groupId: int.parse("${post?.groupId ?? ""}"))));
                      } else if (userId == "${post?.user?.id}") {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FriendScreen(
                                      friendId: post?.user?.id ?? 0,
                                    )));
                      }
                    },
                    leading: post?.user?.image == null
                        ? SvgPicture.asset(
                            "assets/images/user.svg",
                            height: 32,
                            width: 32,
                          )
                        : CircleAvatar(
                            backgroundImage:
                                NetworkImage("$ImageBaseUrl${post?.user?.image}"),
                          ),
                    // title: Text("${post?.user?.name}${post?.group != null ?  " on ${post?.group?.name}" : ""}"),
                    title: RichText(
                      text: TextSpan(
                        text: "${post?.user?.name} ",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(fontWeight: FontWeight.w600),
                        children: [
                          if (post?.group != null) ...[
                            TextSpan(
                              text: "posted on ",
                              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            TextSpan(
                              text:
                                  "${post?.group != null ? "${post?.group?.name}" : ""}",
                              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.underline),
                            ),
                          ]
                        ],
                      ),
                    ),
                    subtitle: Text(
                        "${timeago.format(stringToDateTime(post?.createdAt ?? "").add(Duration(hours: 6)))}"),
                    // trailing: IconButton(
                    //   icon: SvgPicture.asset(
                    //       "assets/images/ic_menu_horizontal.svg"),
                    //   onPressed: () {},
                    // ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        if(userId == "${post?.userId}")PopupMenuItem(
                          child: Text("Delete"),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: Text("Cancel"),
                          value: 2,
                        )
                      ],
                      onSelected: (index) {
                        if (index == 1) {
                          _cubit.postDelete(context, post?.id ?? 0);
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Text(
                          "${post?.content}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(color: Colors.black),
                          maxLines: 4,
                          softWrap: true,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  postMedia?.length != 0
                      ? Container(
                          height: 210,
                          padding:
                              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: PageIndicatorContainer(
                            child: PageView.builder(
                                itemCount: postMedia?.length,
                                itemBuilder: (context, index) {
                                  if (postMedia?[index].type == PostMediaType.Image) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VanamImageViewer(
                                                      url:
                                                          "${ImageBaseUrl}${post?.postImage?[index]?.url}",
                                                    )));
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Image.network(
                                          "$ImageBaseUrl${post?.postImage?[index]?.url}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  } else if (postMedia?[index].type ==
                                      PostMediaType.Video) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VanamVideoPlayerView(
                                                      autoplay: true,
                                                      looping: false,
                                                      videoPlayerController:
                                                          VideoPlayerController.network(
                                                              "${ImageBaseUrl}${postMedia?[index].url}"),
                                                    )));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          gradient: new LinearGradient(
                                              colors: [
                                                kPrimaryColor.withOpacity(0.2),
                                                kPrimaryColor.withOpacity(0.7),
                                              ],
                                              begin: const FractionalOffset(1.0, 0.0),
                                              end: const FractionalOffset(0.0, 0.9),
                                              tileMode: TileMode.clamp),
                                        ),
                                        child: Stack(
                                          children: [
                                            //TODO not work on emulator
                                            // VanamVideoPlayerView(
                                            //   autoplay: false,
                                            //   looping: false,
                                            //   videoPlayerController: VideoPlayerController.network(
                                            //       "${ImageBaseUrl}${postMedia?[index].url}"
                                            //   ),
                                            // )
                                            Center(
                                              child: Icon(
                                                Icons.play_circle_fill,
                                                size: 42,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                }),
                            length: postMedia?.length ?? 0,
                            align: IndicatorAlign.bottom,
                            indicatorSpace: 20.0,
                            padding: const EdgeInsets.all(10),
                            indicatorColor: Colors.white,
                            indicatorSelectorColor: kPrimaryColor,
                            shape: IndicatorShape.circle(size: 12),
                          ),
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: Stack(
                            children: [
                              //SvgPicture.asset("assets/images/ic_emoji_smile.svg",height: 18,width: 18,),
                              SvgPicture.asset(
                                "assets/images/ic_like.svg",
                                height: 18,
                                width: 18,
                              ),
                              Positioned(
                                left: 8,
                                child: Image.asset(
                                  "assets/images/ic_emoji_smile.png",
                                ),
                              ),
                              SizedBox(
                                width: 32,
                              )
                            ],
                          ),
                          label: Text(
                            "${post?.postCount?.like ?? 0}",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            alignment: Alignment.center,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: SvgPicture.asset("assets/images/ic_comment.svg"),
                          label: Text(
                            "${post?.postCount?.comment ?? 0}",
                            style: TextStyle(color: Colors.black),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            alignment: Alignment.center,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 1,
                    width: double.infinity,
                    color: Color(0xffCEE0FF),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          //print("Like status ${post?.postUserCount?.like}");
                          if ((post?.postUserCount?.like ?? 0) == 0) {
                            _cubit.postLike(context, post!.id.toString(), "1");
                            post?.postCount?.like = (post?.postCount?.like ?? 0) + 1;
                            post?.postUserCount?.like = 1;
                          } else if ((post?.postUserCount?.like ?? 0) == 1) {
                            _cubit.postLike(context, post!.id.toString(), "0");
                            post?.postCount?.like = (post?.postCount?.like ?? 0) - 1;
                            post?.postUserCount?.like = 0;
                          }
                          setState(() {});
                        },
                        icon: (post?.postUserCount?.like ?? 0) == 0
                            ? FaIcon(
                                FontAwesomeIcons.heart,
                                size: 20,
                                color: kPrimaryColor,
                              )
                            : FaIcon(
                                FontAwesomeIcons.solidHeart,
                                size: 20,
                                color: Colors.red,
                              ),
                        label: Text(
                          "Like",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CommentView(post: post!)));
                        },
                        icon: SvgPicture.asset(
                          "assets/images/ic_comment.svg",
                          height: 18,
                          width: 18,
                        ),
                        label: Text(
                          "Comment",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostShareView(
                                        post: post,
                                        postMedia: postMedia,
                                      )));
                        }, //showSharePost,
                        icon: SvgPicture.asset(
                          "assets/images/ic_share.svg",
                          height: 18,
                          width: 18,
                        ),
                        label: Text(
                          "Share",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }, listener: (context, state) {
      if (state is PostLiked) {
        // post?.postUserCount?.like = 0;
        // post?.postCount?.like = (post?.postCount?.like??0)+1;
      } else if (state is PostUnLiked) {
        // post?.postUserCount?.like = 1;
        // post?.postCount?.like = (post?.postCount?.like??0)-1;
      } else if (state is PostLikeError) {
      } else if (state is PostDeleted) {
        Fluttertoast.showToast(msg: "Post Deleted Successfully");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
      }
      setState(() {});
    });
  }

  void showSharePost() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return Container(
            color: Colors.transparent,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                ListTile(
                  // ignore: unnecessary_null_comparison
                  leading: userImage == null
                      ? SvgPicture.asset(
                          "assets/images/user.svg",
                          height: 32,
                          width: 32,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage("$ImageBaseUrl"),
                        ),
                  title: Text("$userName"),
                  subtitle: Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: 80,
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: Theme.of(context).accentColor)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Public",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(Icons.arrow_drop_down_outlined)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Say something about this...",
                    ),
                    minLines: 3,
                    maxLines: 8,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(4),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey)),
                  child: Column(
                    children: [
                      ListTile(
                        leading: post?.user?.image == null
                            ? SvgPicture.asset(
                                "assets/images/user.svg",
                                height: 32,
                                width: 32,
                              )
                            : CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "$ImageBaseUrl${post?.user?.image}"),
                              ),
                        title: Text("${post?.user?.name}"),
                        subtitle: Text(
                            "${timeago.format(stringToDateTime(post?.createdAt ?? ""))}"),
                        trailing: Icon(Icons.more_horiz),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(
                          "${post?.content}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(color: Colors.black),
                          maxLines: 4,
                          softWrap: true,
                          overflow: TextOverflow.clip,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      postMedia?.length != 0
                          ? Container(
                              height: 210,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: PageIndicatorContainer(
                                child: PageView.builder(
                                    itemCount: postMedia?.length,
                                    itemBuilder: (context, index) {
                                      if (postMedia?[index].type ==
                                          PostMediaType.Image) {
                                        return Image.network(
                                          "${ImageBaseUrl}${post?.postImage?[index]?.url}",
                                          fit: BoxFit.contain,
                                        );
                                      } else if (postMedia?[index].type ==
                                          PostMediaType.Video) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            gradient: new LinearGradient(
                                                colors: [
                                                  kPrimaryColor
                                                      .withOpacity(0.2),
                                                  kPrimaryColor
                                                      .withOpacity(0.7),
                                                ],
                                                begin: const FractionalOffset(
                                                    1.0, 0.0),
                                                end: const FractionalOffset(
                                                    0.0, 0.9),
                                                tileMode: TileMode.clamp),
                                          ),
                                          child: Stack(
                                            children: [
                                              Center(
                                                child: Icon(
                                                  Icons.play_circle_fill,
                                                  size: 42,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }),
                                length: postMedia?.length ?? 0,
                                align: IndicatorAlign.bottom,
                                indicatorSpace: 20.0,
                                padding: const EdgeInsets.all(10),
                                indicatorColor: Colors.white,
                                indicatorSelectorColor: kPrimaryColor,
                                shape: IndicatorShape.circle(size: 12),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: PrimaryButton(text: "Share Now", press: () {})),
                )
              ],
            ),
          );
        });
  }
}
