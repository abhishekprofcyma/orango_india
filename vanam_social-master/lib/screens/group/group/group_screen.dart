import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vanam_social/constants.dart';
import 'package:vanam_social/data/cubit/group/group_cubit.dart';
import 'package:vanam_social/data/cubit/group/group_state.dart';
import 'package:vanam_social/data/cubit/post_list/post_list_cubit.dart';
import 'package:vanam_social/data/cubit/post_list/post_list_state.dart';
import 'package:vanam_social/data/local/shared_pref.dart';
import 'package:vanam_social/data/remote/model/group/group_details_response.dart';
import 'package:vanam_social/data/remote/model/post/PostShareWithResponse.dart';
import 'package:vanam_social/data/remote/model/post/post_list_response.dart';
import 'package:vanam_social/screens/components/IconButtonVerticalView.dart';
import 'package:vanam_social/screens/components/VanamTextButtonView.dart';
import 'package:vanam_social/screens/components/loading_view.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';
import 'package:vanam_social/screens/group/invite/group_invite_screen.dart';
import 'package:vanam_social/screens/group/member/group_member_screen.dart';
import 'package:vanam_social/screens/group/photo/group_photos_screen.dart';
import 'package:vanam_social/screens/home/home/component/post_item_view.dart';
import 'package:vanam_social/screens/messenger/chat_screen.dart';

import '../../../main.dart';

class GroupScreen extends StatefulWidget {
  final int groupId;

  const GroupScreen({Key? key, required this.groupId}) : super(key: key);

  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  late GroupCubit _cubit;
  late PostListCubit _cubitPost;
  PostListResponse? _postListResponse;
  List<PostListResponseDataPostListData?>? postList = [];
  ScrollController? _scrollController;
  double? _scrollPosition;
  GroupDetailsResponseDataGroup? groupDetail;
  bool isPostFocus = true;
  String postContent = "";
  int shareWithSelected = -1;
  PostShareWithResponse? shareWith;
  List<PlatformFile>? imagesPost = [];
  int userId = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController?.position.pixels;
      if (_scrollController?.position.pixels ==
          _scrollController?.position.maxScrollExtent) {
        if ((_postListResponse?.data?.postList?.lastPage ?? 0) >
            (_postListResponse?.data?.postList?.currentPage ?? 0)) {
          _cubitPost.groupPostList(
              context,
              (_postListResponse?.data?.postList?.currentPage ?? 1) + 1,
              widget.groupId);
        }
      }
    });
  }

  @override
  void initState() {
    _cubit = BlocProvider.of(context, listen: false);
    _cubitPost = BlocProvider.of<PostListCubit>(context, listen: false);
    super.initState();
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollListener);
    _cubit.groupDetails(context, widget.groupId);
    _cubitPost.groupPostList(context, 1, widget.groupId);
    _cubitPost.fetchPostWithList(context);
    init();
  }

  init() async {
    String? tId = await getUserId();
    setState(() {
      userId = int.parse(tId ?? "");
    });
  }

  Future<FilePickerResult?> pickFilePost() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        imagesPost!.addAll(result.files);
      });
      PlatformFile file = result.files.first;

      List<File> files = [];
      imagesPost?.forEach((element) {
        files.add(File(element.path ?? ""));
      });

      return result;
    } else {
      // User canceled the picker
    }
  }

  Future<void> _pullRefresh() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => GroupScreen(groupId: widget.groupId)),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocConsumer<GroupCubit, GroupState>(builder: (context, state) {
        return Stack(
          children: [
            RefreshIndicator(
              onRefresh: _pullRefresh,
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width * 0.8,
                    child: Stack(
                      children: [
                        Positioned(
                          top: -MediaQuery.of(context).size.width * 0.5,
                          left: -MediaQuery.of(context).size.width * 0.1,
                          right: -MediaQuery.of(context).size.width * 0.1,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 1.2,
                            height: MediaQuery.of(context).size.width * 1.2,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                    colors: [
                                      Color(0xffFFCC00),
                                      Color(0xffFFEC3B)
                                    ],
                                    begin: FractionalOffset.topCenter,
                                    end: FractionalOffset.bottomCenter,
                                    stops: [0.0, 1.0],
                                    tileMode: TileMode.repeated),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xff000000).withOpacity(.11),
                                      spreadRadius: 2,
                                      blurRadius: 7)
                                ]),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.width * 0.5,
                          left: MediaQuery.of(context).size.width * 0.35,
                          right: MediaQuery.of(context).size.width * 0.35,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5,
                                    color: Colors.black.withOpacity(0.25),
                                    spreadRadius: 1)
                              ],
                            ),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                "$ImageBaseUrl${groupDetail?.url}",
                              ),
                              radius: 56,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                        ),
                      ],
                    ),
                  ),
                  Center(
                      child: Text(
                    "${groupDetail?.name ?? ""}",
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  )),
                  Center(
                      child: Text(
                    "crated by ${groupDetail?.user?.name ?? ""}",
                    style: Theme.of(context).textTheme.caption?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w600),
                  )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: PrimaryButton(
                        text: "Message",
                        press: () {
                          if (groupDetail != null &&
                              groupDetail?.groupJoin != null) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                          friendId: widget.groupId,
                                          friendName: groupDetail?.name ?? "",
                                          friendImage: "${groupDetail?.url}",
                                          isGroupChat: true,
                                        )));
                          } else {
                            Fluttertoast.showToast(
                                msg: "You have not permission to send message");
                          }
                        }),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (groupDetail?.groupJoin == null) ...[
                        IconButtonVerticalView(
                            icon: "ic_group_joined",
                            title: "Join",
                            onClick: () {
                              _cubit.groupJoin(context, widget.groupId);
                            }),
                      ],
                      if (groupDetail?.groupJoin != null) ...[
                        IconButtonVerticalView(
                            icon: "ic_group_joined",
                            title: "Un-Join",
                            onClick: () {
                              _cubit.groupUnJoin(context, widget.groupId);
                            }),
                      ],
                      IconButtonVerticalView(
                          icon: "ic_group_invite",
                          title: "Invite",
                          onClick: () {
                            if (groupDetail != null &&
                                groupDetail?.user?.id == userId) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GroupInviteScreen(
                                            groupId: widget.groupId,
                                          )));
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      "You have not permission to Invite People");
                            }
                          }),
                      IconButtonVerticalView(
                          icon: "ic_group_more",
                          title: "More",
                          onClick: () {
                            showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (BuildContext context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Center(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 90,
                                        height: 6,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: Color(0xffBEBEBE)),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    VanamTextButtonView(
                                        title: "Share group link",
                                        onClick: () {}),
                                    VanamTextButtonView(
                                        title: "Turn off notification",
                                        onClick: () {}),
                                    VanamTextButtonView(
                                      title: "Report group",
                                      onClick: () {},
                                      textColor: Color(0xffFF0000),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                  ],
                                );
                              },
                            );
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButtonVerticalView(
                        icon: "ic_group_photos",
                        title: "Group Photos",
                        onClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GroupPhotosScreen(
                                        groupId: widget.groupId,
                                      )));
                        },
                        isCircularBg: true,
                      ),
                      IconButtonVerticalView(
                        icon: "ic_group_member",
                        title: "Group Members",
                        onClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GroupMemberScreen(
                                        groupId: groupDetail?.id ?? 0,
                                      )));
                        },
                        isCircularBg: true,
                      ),
                    ],
                  ),
                  if (groupDetail != null && groupDetail?.groupJoin != null) ...[
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Focus(
                              onFocusChange: (hasFocus) {
                                setState(() {
                                  isPostFocus = hasFocus;
                                });
                              },
                              child: TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    postContent = value;
                                  });
                                },
                                decoration: InputDecoration(
                                    hintText: "Write something here",
                                    isDense: true,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 12),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                          color: Color(0xffFFCC00), width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(
                                        color: Color(0xffFFCC00),
                                        width: 1.0,
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          if (shareWithSelected == -1) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Please select share with");
                                          } else {
                                            List<File> files = [];
                                            imagesPost?.forEach((element) {
                                              files.add(File(element.path!));
                                            });
                                            showLoaderDialog(context);
                                            BlocProvider.of<PostListCubit>(
                                                    context,
                                                    listen: false)
                                                .fetchPostWithImageAdd(
                                                    context,
                                                    shareWithSelected
                                                        .toString(),
                                                    postContent,
                                                    files,
                                                    widget.groupId.toString());
                                          }
                                        },
                                        icon: Stack(
                                          children: [
                                            SvgPicture.asset(
                                                "assets/images/ic_chat_circle_button_bg.svg"),
                                            Align(
                                                alignment: Alignment.center,
                                                child: SvgPicture.asset(
                                                    "assets/images/ic_chat_arrow_up.svg")),
                                          ],
                                        ))),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          )
                        ],
                      ),
                    ),
                    if (isPostFocus) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    pickFilePost();
                                  },
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            BlocConsumer<PostListCubit, PostListState>(
                                builder: (context, state) {
                              return Container(
                                width: double.infinity,
                                height: 110,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        shareWith?.data?.shareWith.length ?? 0,
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      return PostShareWithItem(
                                          shareWith!.data!.shareWith[index]);
                                    }),
                              );
                            }, listener: (context, state) {
                              if (state is PostShareWithCompleted) {
                                setState(() {
                                  shareWith = state.postCommentResponse;
                                });
                              }
                            })
                          ],
                        ),
                      )
                    ],
                    Stack(
                      children: [
                        ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: postList?.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              PostListResponseDataPostListData? post =
                                  postList?[index];
                              return PostItemView(post: post);
                            }),
                        BlocConsumer<PostListCubit, PostListState>(
                            builder: (context, state) {
                          return Container();
                        }, listener: (context, state) {
                          if (state is PostListLoaded) {
                            postList
                                ?.addAll(state.response.data!.postList!.data!);
                            _postListResponse = state.response;
                            setState(() {});
                          } else if (state is PostCompleted) {
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        GroupScreen(groupId: widget.groupId)));
                          }else if(state is PostError){
                            Navigator.pop(context);
                          }
                        })
                      ],
                    )
                  ]
                ],
              ),
            ),
            if (state is GroupJoinLoading || state is GroupUnJoinLoading)
              Center(
                child: LoadingView(),
              ),
          ],
        );
      }, listener: (context, state) {
        if (state is GroupJoined) {
          Fluttertoast.showToast(msg: "Group Joined Successfully");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => GroupScreen(groupId: widget.groupId)));
        } else if (state is GroupUnJoined) {
          Fluttertoast.showToast(msg: "Group Un-Joined Successfully");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => GroupScreen(groupId: widget.groupId)));
        } else if (state is GroupDetailLoaded) {
          groupDetail = state.response.data?.group;
        }
      }),
    );
  }

  Widget PostShareWithItem(ShareWith shareWith) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            shareWithSelected == shareWith.id
                ? Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : Icon(Icons.circle),
            SizedBox(
              width: 8,
            ),
            Text(
              "${shareWith.name}",
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
      ),
      onTap: () {
        setState(() {
          shareWithSelected = shareWith.id!;
        });
      },
    );
  }
}
