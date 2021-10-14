import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:vanam_social/constants.dart';
import 'package:vanam_social/data/cubit/post_list/post_list_cubit.dart';
import 'package:vanam_social/data/cubit/post_list/post_list_state.dart';
import 'package:vanam_social/data/cubit/profile/profile_cubit.dart';
import 'package:vanam_social/data/cubit/profile/profile_state.dart';
import 'package:vanam_social/data/remote/model/post/PostShareWithResponse.dart';
import 'package:vanam_social/data/remote/model/post/post_list_response.dart';
import 'package:vanam_social/data/remote/model/profile/user_details_response.dart';
import 'package:vanam_social/screens/components/IconButtonVerticalView.dart';
import 'package:vanam_social/screens/components/loading_view.dart';
import 'package:vanam_social/screens/components/video_player_view.dart';
import 'package:vanam_social/screens/friend/friend_screen.dart';
import 'package:vanam_social/screens/friend/photos/photos_list_screen.dart';
import 'package:vanam_social/screens/home/components/vanam_bottom_navigation_bar_view.dart';
import 'package:vanam_social/screens/home/components/vanam_image_viewer.dart';
import 'package:vanam_social/screens/home/home/component/comment/comment_view.dart';
import 'package:vanam_social/screens/home/home/component/home_tab_post_view.dart';
import 'package:vanam_social/screens/home/home/component/post_item_view.dart';
import 'package:vanam_social/screens/home/home_screen.dart';
import 'package:vanam_social/screens/profile/edit/profile_edit_screen.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vanam_social/screens/setting/connections/setting_connection_screen.dart';
import 'package:video_player/video_player.dart';

import '../../main.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileCubit _cubit;
  late PostListCubit _cubitPost;
  UserDetailResponse? _profile;
  PostListResponse? _postListResponse;
  List<PostListResponseDataPostListData?>? postList = [];
  ScrollController? _scrollController;
  double? _scrollPosition;
  List<PlatformFile>? images = [];
  List<PlatformFile>? imagesPost = [];
  String postContent = "";
  bool isPostFocus = true;
  int shareWithSelected = -1;
  PostShareWithResponse? shareWith;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  bool posting = false;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController?.position.pixels;
      if (_scrollController?.position.pixels ==
          _scrollController?.position.maxScrollExtent) {
        if ((_postListResponse?.data?.postList?.lastPage ?? 0) >
            (_postListResponse?.data?.postList?.currentPage ?? 0)) {
          _cubitPost.userPostList(context,
              (_postListResponse?.data?.postList?.currentPage ?? 1) + 1, "0");
        }
      }
    });
  }

  @override
  void initState() {
    _cubit = BlocProvider.of<ProfileCubit>(context, listen: false);
    _cubitPost = BlocProvider.of<PostListCubit>(context, listen: false);
    super.initState();
    _cubit.profileDetails(context);
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollListener);
    _cubitPost.userPostList(context, 1,"0");
    //_cubitPost.postList(context, 1,0);
    _cubitPost.fetchPostWithList(context);
  }

  Future<FilePickerResult?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        images!.addAll(result.files);
      });
      PlatformFile file = result.files.first;

      List<File> files = [];
      images?.forEach((element) {
        files.add(File(element.path ?? ""));
      });
      _cubit.profileImageUpload(context, files);

      return result;
    } else {
      // User canceled the picker
    }
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
      setState(() {});
      return result;
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocConsumer<ProfileCubit, ProfileState>(builder: (context, state) {
        return Stack(
          children: [
            ListView(
              controller: _scrollController,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.8,
                  width: double.infinity,
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
                          top: 46,
                          left: 16,
                          child: Text(
                            "My Profile",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(fontSize: 18),
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.width * 0.5,
                        left: MediaQuery.of(context).size.width * 0.35,
                        right: MediaQuery.of(context).size.width * 0.35,
                        child: Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VanamImageViewer(
                                              url:
                                                  "$ImageBaseUrl${_profile?.data?.userBasicInfo?.image}",
                                            )));
                              },
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
                                child:
                                    _profile?.data?.userBasicInfo?.image == null
                                        ? SvgPicture.asset(
                                            "assets/images/user.svg",
                                            width: 110,
                                            height: 110,
                                          )
                                        : CircleAvatar(
                                            backgroundImage: NetworkImage(
                                              "$ImageBaseUrl${_profile?.data?.userBasicInfo?.image}",
                                            ),
                                            radius: 56,
                                          ),
                              ),
                            ),
                            Positioned(
                                bottom: 6,
                                right: 6,
                                child: InkWell(
                                  onTap: () {
                                    pickFile();
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color(0xff000000)
                                                    .withOpacity(0.16))
                                          ]),
                                      child: Icon(
                                        Icons.camera_alt,
                                        size: 18,
                                      )),
                                ))
                          ],
                        ),
                      ),
                      Positioned(
                          top: 32,
                          right: 16,
                          child: FloatingActionButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileEditScreen()));
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            mini: true,
                            backgroundColor: Colors.white,
                          )),
                    ],
                  ),
                ),
                Center(
                    child: Text(
                  "${_profile?.data?.name ?? ""}",
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w600),
                )),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButtonVerticalView(
                        icon: "ic_profile_photos",
                        title: "Photos",
                        onClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PhotosListScreen(
                                        friendId: _profile?.data?.id ?? 0,
                                      )));
                        }),
                    IconButtonVerticalView(
                        icon: "ic_profile_connects",
                        title: "Connects",
                        onClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SettingConnectionScreen()));
                        }),
                    // IconButtonVerticalView(
                    //     icon: "ic_profile_live",
                    //     title: "Go Live",
                    //     onClick: () {})
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
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
                                            msg: "Please select share with");
                                      } else {
                                        List<File> files = [];
                                        imagesPost?.forEach((element) {
                                          files.add(File(element.path!));
                                        });
                                        setState(() {
                                          posting = true;
                                        });
                                        showLoaderDialog(context);
                                        BlocProvider.of<PostListCubit>(context,
                                                listen: false)
                                            .fetchPostWithImageAdd(
                                                context,
                                                shareWithSelected.toString(),
                                                postContent,
                                                files,
                                                "");
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            pickFilePost();
                          },
                          icon: Icon(
                            Icons.photo,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          height: imagesPost!.isNotEmpty ? 90 : 0,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: imagesPost!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 110,
                                  padding:
                                      const EdgeInsets.fromLTRB(4, 4, 4, 4),
                                  child: Stack(
                                    children: [
                                      VIDEO_EXTENSION_ALLOW.contains(
                                              imagesPost![index].extension!)
                                          ? Card(
                                              child: Container(
                                                width: 160,
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      Icons.play_circle_fill,
                                                      size: 32,
                                                    ),
                                                    Text(
                                                      "${imagesPost![index].name}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Image.file(
                                              File(imagesPost![index].path!),
                                              height: 90,
                                            ),
                                      Positioned(
                                          top: 0,
                                          right: 0,
                                          child: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  imagesPost!.remove(
                                                      imagesPost![index]);
                                                });
                                              },
                                              child: Icon(Icons.close)))
                                    ],
                                  ),
                                );
                              }),
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
                          }else if(state is PostListLoaded){
                            print("post list loaded");
                            postList?.addAll(state.response.data!.postList!.data!);
                            _postListResponse = state.response;
                          }
                        })
                      ],
                    ),
                  )
                ],
                SizedBox(
                  height: 16,
                ),
                userExtraDetailItem("ic_user_city.svg",
                    "${_profile?.data?.userBasicInfo?.homeCity ?? "Current City"}"),
                userExtraDetailItem("ic_user_workspace.svg",
                    "${_profile?.data?.userBasicInfo?.currentCity ?? "Workplace"}"),
                userExtraDetailItem("ic_user_relation.svg",
                    "${_profile?.data?.userBasicInfo?.relationship ?? "Relationship status"}"),
                userExtraDetailItem("ic_user_location.svg",
                    " ${_profile?.data?.userBasicInfo?.currentCity ?? "Hometown"}"),
                userExtraDetailItem("ic_user_languages.svg",
                    "${_profile?.data?.userBasicInfo?.language ?? "Languages"}"),
                userExtraDetailItem("ic_user_interest.svg",
                    "${_profile?.data?.userBasicInfo?.interests ?? "Interests"}"),
                // userExtraDetailItem("ic_user_connections.svg",
                //     "Connect with 200 peoples"),
                SizedBox(
                  height: 16,
                ),
                // Stack(
                //   children: [
                //     ListView.builder(
                //         shrinkWrap: true,
                //         scrollDirection: Axis.vertical,
                //         itemCount: postList?.length,
                //         physics: NeverScrollableScrollPhysics(),
                //         itemBuilder: (context, index) {
                //           PostListResponseDataPostListData? post =
                //           postList?[index];
                //           return PostItemView(post: post);
                //           //return Text("1$index");
                //         }),
                //     BlocConsumer<PostListCubit, PostListState>(
                //         builder: (context, state) {
                //       return Container();
                //     }, listener: (context, state) {
                //       if (state is PostListLoaded) {
                //         print("post list loaded");
                //         postList?.addAll(state.response.data!.postList!.data!);
                //         print("post list loaded ${postList?.length}");
                //         _postListResponse = state.response;
                //         setState(() {});
                //       } else if (state is PostCompleted) {
                //         setState(() {
                //           posting = false;
                //         });
                //         Navigator.pop(context);
                //         Navigator.pushReplacement(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => ProfileScreen()));
                //       }
                //     })
                //   ],
                // ),

                ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: postList?.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      PostListResponseDataPostListData? post = postList?[index];
                      print("post id $index");
                      return PostItemView(post: post,);
                    })

              ],
            ),
            if (state is ProfileLoading)
              Center(
                child: LoadingView(),
              ),
          ],
        );
      }, listener: (context, state) {
        if (state is ProfileCompleted) {
          _profile = state.userDetailResponse;
        } else if (state is ProfileUploadCompleted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => ProfileScreen()));
        } else if (state is PostCompleted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => ProfileScreen()));
        }
      }),
      bottomNavigationBar: VanamBottomNavigationBarView(
        onClick: (index) {
          print("HomeScreen index $index");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        index: index,
                      )));
        },
        index: 0,
      ),
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
              style: Theme.of(context).textTheme.subtitle2,
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

  Widget userExtraDetailItem(String icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/images/$icon",
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          )
        ],
      ),
    );
  }
}
