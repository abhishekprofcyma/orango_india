import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vanam_social/constants.dart';
import 'package:vanam_social/data/cubit/connection/connection_cubit.dart';
import 'package:vanam_social/data/cubit/connection/connection_state.dart';
import 'package:vanam_social/data/cubit/friend/friend_cubit.dart';
import 'package:vanam_social/data/cubit/friend/friend_state.dart';
import 'package:vanam_social/data/cubit/post_list/post_list_cubit.dart';
import 'package:vanam_social/data/cubit/post_list/post_list_state.dart';
import 'package:vanam_social/data/remote/model/friend/friend_detail_response.dart';
import 'package:vanam_social/data/remote/model/post/post_list_response.dart';
import 'package:vanam_social/screens/components/loading_view.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';
import 'package:vanam_social/screens/friend/connections/friend_connections_screen.dart';
import 'package:vanam_social/screens/friend/photos/photos_list_screen.dart';
import 'package:vanam_social/screens/group/photo/group_photos_screen.dart';
import 'package:vanam_social/screens/home/components/vanam_bottom_navigation_bar_view.dart';
import 'package:vanam_social/screens/home/home/component/home_tab_post_view.dart';
import 'package:vanam_social/screens/home/home/component/post_item_view.dart';
import 'package:vanam_social/screens/home/home_screen.dart';
import 'package:vanam_social/screens/messenger/chat_screen.dart';
import 'package:vanam_social/screens/setting/connections/setting_connection_screen.dart';

class FriendScreen extends StatefulWidget {
  final bool isAccountPrivate;
  final bool isAccountBlocked;
  final int friendId;

  const FriendScreen(
      {Key? key,
      this.isAccountPrivate = false,
      this.isAccountBlocked = false,
      required this.friendId})
      : super(key: key);

  @override
  _FriendScreenState createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late FriendCubit _cubit;
  late ConnectionCubit _cubitConnect;
  FriendDetailResponse? _friend;
  late PostListCubit _cubitPost;
  PostListResponse? _postListResponse;
  List<PostListResponseDataPostListData?>? postList = [];
  ScrollController? _scrollController;
  double? _scrollPosition;
  bool isAccountPrivate = false;
  bool isAccountBlocked = false;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController?.position.pixels;
      if (_scrollController?.position.pixels ==
          _scrollController?.position.maxScrollExtent) {
        if ((_postListResponse?.data?.postList?.lastPage ?? 0) >
            (_postListResponse?.data?.postList?.currentPage ?? 0)) {
          _cubitPost.userPostList(
              context,
              (_postListResponse?.data?.postList?.currentPage ?? 1) + 1,
              widget.friendId.toString());
        }
      }
    });
  }

  @override
  void initState() {
    setState(() {
      isAccountBlocked = widget.isAccountBlocked;
      isAccountPrivate = widget.isAccountPrivate;
    });
    _cubit = BlocProvider.of<FriendCubit>(context, listen: false);
    _cubitConnect = BlocProvider.of<ConnectionCubit>(context, listen: false);
    _cubitPost = BlocProvider.of<PostListCubit>(context, listen: false);
    super.initState();
    _cubit.friendDetails(context, widget.friendId);
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollListener);
    _cubitPost.userPostList(context, 1, widget.friendId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      body: BlocConsumer<FriendCubit, FriendState>(builder: (context, state) {
        return Stack(
          children: [
            if (state is FriendProfileLoading || state is FriendBlockAddLoading)
              Center(
                child: LoadingView(),
              ),
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
                          child: _friend?.data?.user?.image == null
                              ? SvgPicture.asset(
                                  "assets/images/user.svg",
                                  width: 110,
                                  height: 110,
                                )
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    "$ImageBaseUrl${_friend?.data?.user?.image}",
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
                  "${_friend?.data?.user?.name ?? ""}",
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w600),
                )),
                if (isAccountPrivate == false &&
                    isAccountBlocked == false)Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.userCheck,size: 18,),
                        SizedBox(width: 8,),
                        Text(
                          "Friend with you",
                          style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                SizedBox(height: 8,),
                if (isAccountPrivate == true) isPrivateView(),
                if (isAccountBlocked == true) isBlockView(),
                if (isAccountPrivate == false &&
                    isAccountBlocked == false)
                  isFriendView(),
                SizedBox(
                  height: 16,
                ),
                userExtraDetailItem("ic_user_city.svg",
                    "${_friend?.data?.user?.userBasicInfo?.homeCity ?? "Current City"}"),
                userExtraDetailItem("ic_user_workspace.svg",
                    "${_friend?.data?.user?.userBasicInfo?.currentCity ?? "Workplace"}"),
                userExtraDetailItem("ic_user_relation.svg",
                    "${_friend?.data?.user?.userBasicInfo?.relationship ?? "Relationship status"}"),
                if (isAccountPrivate == true) accountPrivateView(),
                if (isAccountBlocked == true) accountBlockedView(),
                if (isAccountPrivate == false &&
                    isAccountBlocked == false) ...[
                  userExtraDetailItem("ic_user_location.svg",
                      "${_friend?.data?.user?.userBasicInfo?.currentCity ?? "Location"}"),
                  userExtraDetailItem("ic_user_languages.svg",
                      "${_friend?.data?.user?.userBasicInfo?.language ?? "Language"}"),
                  userExtraDetailItem("ic_user_interest.svg",
                      "${_friend?.data?.user?.userBasicInfo?.interests ?? "Interests"}"),
                  Stack(
                    children: [
                      postList?.length == 0 ? Column(
                        children: [
                          SizedBox(height: 16,),
                          Center(child: Text("User has no posts to show",style: Theme.of(context).textTheme.headline6,),),
                        ],
                      ) :ListView.builder(
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
                        }
                      })
                    ],
                  ),
                ]
              ],
            ),
          ],
        );
      }, listener: (context, state) {
        if (state is FriendProfileCompleted) {
          _friend = state.response;
          if (_friend?.data?.friendBlock == 1) {
            isAccountBlocked = true;
          }else{
            isAccountBlocked = false;
          }
          if (_friend?.data?.friend == 1) {
            isAccountPrivate = false;
          }else {
            isAccountPrivate = true;
          }
          print(" account status $isAccountPrivate $isAccountBlocked");
          setState(() {});
        } else if (state is FriendBlockAddDone) {
          Fluttertoast.showToast(msg: "Friend blocked successfully");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      FriendScreen(friendId: widget.friendId)));
        } else if (state is FriendUnBlockDone) {
          Fluttertoast.showToast(msg: "Friend un-blocked successfully");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      FriendScreen(friendId: widget.friendId)));
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

  Widget isBlockView() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: PrimaryButton(
            text: "Unblock",
            press: () {
              _cubit.friendUnBlock(context, _friend?.data?.user?.id ?? 0);
            }));
  }

  Widget isPrivateView() {
    return BlocConsumer<ConnectionCubit, ConnectionsState>(
        builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: PrimaryButton(
            text: "Connect",
            press: () {
              _cubitConnect.connectionReqSend(context, widget.friendId);
            }),
      );
    }, listener: (context, state) {
      if (state is ConnectionRequestLoaded) {
        Fluttertoast.showToast(msg: "Connection request send successfully");
        Navigator.pop(context);
      } else if (state is ConnectionRequestError) {
        Fluttertoast.showToast(msg: "Connection request failed to send");
      }
    });
  }

  Widget isFriendView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PrimaryButton(
            text: "Message",
            press: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen(
                            friendId: _friend?.data?.user?.id ?? 0,
                            friendName: _friend?.data?.user?.name ?? "",
                            friendImage: _friend?.data?.user?.image ?? "",
                          )));
            }),
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PhotosListScreen(
                            friendId: _friend!.data!.user!.id!,
                          )));
            },
            icon: Stack(
              children: [
                SvgPicture.asset("assets/images/ic_chat_circle_button_bg.svg"),
                Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      "assets/images/ic_user_gallery.svg",
                      color: Colors.black,
                      width: 14,
                    )),
              ],
            )),
        // IconButton(
        //     onPressed: () {
        //       Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingConnectionScreen()));
        //     },
        //     icon: Stack(
        //       children: [
        //         SvgPicture.asset(
        //             "assets/images/ic_chat_circle_button_bg.svg"),
        //         Align(
        //             alignment: Alignment.center,
        //             child: SvgPicture.asset(
        //               "assets/images/ic_user_connection.svg",
        //               color: Colors.black,
        //               width: 14,
        //             )),
        //       ],
        //     )),
        // IconButton(
        //     onPressed: () {},
        //     icon: Stack(
        //       children: [
        //         SvgPicture.asset(
        //             "assets/images/ic_chat_circle_button_bg.svg"),
        //         Align(
        //             alignment: Alignment.center,
        //             child: SvgPicture.asset(
        //               "assets/images/ic_user_more.svg",
        //               color: Colors.black,
        //               width: 14,
        //             )),
        //       ],
        //     )),
        PopupMenuButton(
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text("Block"),
              value: 1,
            ),
            PopupMenuItem(
              child: Text("Cancel"),
              value: 2,
            )
          ],
          onSelected: (index) {
            if (index == 1) {
              _cubit.friendBlock(context, _friend?.data?.user?.id ?? 0);
            }
          },
        )
      ],
    );
  }

  Widget userExtraDetailItem(String icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          SvgPicture.asset("assets/images/$icon"),
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

  Widget accountPrivateView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      color: Colors.white,
      child: Column(
        children: [
          SvgPicture.asset("assets/images/ic_account_private.svg"),
          SizedBox(
            height: 8,
          ),
          Text(
            "This account is private",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            "Connect with this account to see their photos and connects",
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }

  Widget accountBlockedView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      color: Colors.white,
      child: Column(
        children: [
          SvgPicture.asset("assets/images/ic_account_blocked.svg"),
          SizedBox(
            height: 8,
          ),
          Text(
            "This account is blocked",
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            "Unblock this account to see their photos and connects",
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
  }
}
