import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanam_social/constants.dart';
import 'package:vanam_social/data/cubit/connection/connection_cubit.dart';
import 'package:vanam_social/data/cubit/connection/connection_state.dart';
import 'package:vanam_social/data/cubit/group/group_cubit.dart';
import 'package:vanam_social/data/cubit/group/group_state.dart';
import 'package:vanam_social/data/remote/model/connection/connection_accept_list_response.dart';
import 'package:vanam_social/data/remote/model/group/group_invite_acccept_list_response.dart';
import 'package:vanam_social/screens/components/loading_view.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';
import 'package:vanam_social/screens/friend/friend_screen.dart';
import 'package:vanam_social/screens/group/group/group_screen.dart';
import 'package:vanam_social/screens/home/components/drawer_view.dart';
import 'package:vanam_social/screens/home/components/vanam_app_bar_view.dart';

class NotificationTabView extends StatefulWidget {
  @override
  _NotificationTabViewState createState() => _NotificationTabViewState();
}

class _NotificationTabViewState extends State<NotificationTabView> {
  late ConnectionCubit _cubit;
  late GroupCubit _cubitGroup;
  ConnectionAcceptListResponse? _connectionAcceptListResponse;
  List<ConnectionAcceptListResponseDataUserListData?>? connectionAcceptList =
      [];
  ScrollController? _scrollController;
  double? _scrollPosition;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  GroupInviteAccceptListResponse? _groupInviteAccceptListResponse;
  List<GroupInviteAccceptListResponseDataGroupInviteData?>? groupAcceptList =
      [];

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController?.position.pixels;
      if (_scrollController?.position.pixels ==
          _scrollController?.position.maxScrollExtent) {
        if ((_connectionAcceptListResponse?.data?.userList?.lastPage ?? 0) >
            (_connectionAcceptListResponse?.data?.userList?.currentPage ?? 0)) {
          _cubit.connectionAcceptList(
              context,
              (_connectionAcceptListResponse?.data?.userList?.currentPage ??
                      1) +
                  1);
        }
      }
    });
  }

  @override
  void initState() {
    _cubit = BlocProvider.of<ConnectionCubit>(context, listen: false);
    _cubitGroup = BlocProvider.of<GroupCubit>(context, listen: false);
    super.initState();
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollListener);
    _cubit.connectionAcceptList(context, 1);
    _cubitGroup.groupInviteAcceptList(context, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: DrawerView(),
      body: Stack(
        children: [
          SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: VanamAppBarView(
                    isSliverAppBar: false,
                    onMenuTap: () {
                      _key.currentState!.openDrawer();
                    },
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: connectionAcceptList?.length,
                    itemBuilder: (context, index) {
                      ConnectionAcceptListResponseDataUserListData? connReq =
                          connectionAcceptList?[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xff000000).withOpacity(0.1),
                                  offset: Offset(0.3, 1.6),
                                  spreadRadius: 1,
                                  blurRadius: 2)
                            ]),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FriendScreen(
                                        friendId: connReq?.user?.id ?? 0)));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "$ImageBaseUrl${connReq?.user?.image}"), //TODO image on accept request
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
                                    "${connReq?.user?.name}",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Text(
                                    "Approve or ignore request",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        ?.copyWith(
                                            color: Color(0xff676767),
                                            fontWeight: FontWeight.w400),
                                  ),
                                  Row(
                                    children: [
                                      PrimaryButton(
                                        press: () {
                                          _cubit.connectionAccept(
                                              context, connReq?.id ?? 0);
                                        },
                                        text: "Accept",
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      SecondaryButton(
                                        press: () {
                                          _cubit.connectionDeny(
                                              context, connReq?.id ?? 0);
                                        },
                                        text: 'Decline',
                                      )
                                    ],
                                  )
                                ],
                              )),
                              // IconButton(
                              //     onPressed: () {},
                              //     icon: Icon(Icons.more_horiz))
                            ],
                          ),
                        ),
                      );
                    }),
                BlocConsumer<GroupCubit, GroupState>(builder: (context, state) {
                  if (state is GroupInviteAcceptLoading) {
                    return LoadingView();
                  } else if (state is GroupInviteAcceptAdded &&
                      state.response.data?.groupInvite?.data?.length == 0) {
                    return Center(
                      child: Text(
                        "Notification list is empty",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: groupAcceptList?.length,
                        itemBuilder: (context, index) {
                          GroupInviteAccceptListResponseDataGroupInviteData?
                              groupAccept = groupAcceptList?[index];
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xff000000).withOpacity(0.1),
                                      offset: Offset(0.3, 1.6),
                                      spreadRadius: 1,
                                      blurRadius: 2)
                                ]),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GroupScreen(
                                              groupId:
                                                  groupAccept?.group?.id ?? 0,
                                            )));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "$ImageBaseUrl${groupAccept?.user?.image}"), //TODO image on accept request
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
                                        "${groupAccept?.user?.name} send you group ${groupAccept?.group?.name} ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      Text(
                                        "Approve or ignore request",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            ?.copyWith(
                                                color: Color(0xff676767),
                                                fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  )),
                                  // IconButton(
                                  //     onPressed: () {},
                                  //     icon: Icon(Icons.more_horiz))
                                ],
                              ),
                            ),
                          );
                        });
                  }
                  return Container();
                }, listener: (context, state) {
                  if (state is GroupInviteAcceptAdded) {
                    groupAcceptList
                        ?.addAll(state.response.data!.groupInvite!.data!);
                    setState(() {});
                  } else if (state is ConnectionAcceptLoaded ||
                      state is ConnectionDenyLoaded) {
                    connectionAcceptList = [];
                    setState(() {});
                    _cubit.connectionAcceptList(context, 1);
                  }
                })

                // Padding(
                //   padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                //   child: Text(
                //     "New",
                //     style: Theme.of(context).textTheme.headline6,
                //   ),
                // ),
                // ListView.builder(
                //     shrinkWrap: true,
                //     physics: NeverScrollableScrollPhysics(),
                //     itemCount: 1,
                //     itemBuilder: (context, index) {
                //       return Container(
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 8, vertical: 8),
                //         margin: const EdgeInsets.all(8),
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(12),
                //             color: Colors.white,
                //             boxShadow: [
                //               BoxShadow(
                //                   color: Color(0xff000000).withOpacity(0.1),
                //                   offset: Offset(0.3, -.07),
                //                   spreadRadius: 1)
                //             ]),
                //         child: Row(
                //           children: [
                //             CircleAvatar(
                //               backgroundImage: NetworkImage(
                //                   "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80"),
                //             ),
                //             SizedBox(
                //               width: 8,
                //             ),
                //             Expanded(
                //                 child: Row(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   "Teri dactlyl ",
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .subtitle1
                //                       ?.copyWith(
                //                           color: Colors.black,
                //                           fontWeight: FontWeight.w500),
                //                 ),
                //                 Text(
                //                   "is now connect with you",
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .subtitle2
                //                       ?.copyWith(
                //                           color: Color(0xff676767),
                //                           fontWeight: FontWeight.w400),
                //                 ),
                //               ],
                //             )),
                //             IconButton(
                //                 onPressed: () {},
                //                 icon: Icon(Icons.more_horiz))
                //           ],
                //         ),
                //       );
                //     }),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                //   child: Text(
                //     "Suggestions",
                //     style: Theme.of(context).textTheme.headline6,
                //   ),
                // ),
                // ListView.builder(
                //     shrinkWrap: true,
                //     physics: NeverScrollableScrollPhysics(),
                //     itemCount: 4,
                //     itemBuilder: (context, index) {
                //       return Container(
                //         padding: const EdgeInsets.symmetric(
                //             horizontal: 8, vertical: 8),
                //         margin: const EdgeInsets.all(8),
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(12),
                //             color: Colors.white,
                //             boxShadow: [
                //               BoxShadow(
                //                   color: Color(0xff000000).withOpacity(0.1),
                //                   offset: Offset(0.3, -.07),
                //                   spreadRadius: 1)
                //             ]),
                //         child: Row(
                //           children: [
                //             CircleAvatar(
                //               backgroundImage: NetworkImage(
                //                   "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80"),
                //               radius: 30,
                //             ),
                //             SizedBox(
                //               width: 8,
                //             ),
                //             Expanded(
                //                 child: Column(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 Text(
                //                   "Liz Erd",
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .subtitle1
                //                       ?.copyWith(fontWeight: FontWeight.w500),
                //                 ),
                //                 Row(
                //                   children: [
                //                     PrimaryButton(
                //                       press: () {},
                //                       text: "Add Connect",
                //                     ),
                //                     SizedBox(
                //                       width: 8,
                //                     ),
                //                     SecondaryButton(
                //                       press: () {},
                //                       text: 'Remove',
                //                     )
                //                   ],
                //                 )
                //               ],
                //             )),
                //           ],
                //         ),
                //       );
                //     }),
              ],
            ),
          ),
          BlocConsumer<ConnectionCubit, ConnectionsState>(
              builder: (context, state) {
            if (state is ConnectionAcceptListLoading ||
                state is ConnectionAcceptLoading ||
                state is ConnectionDenyLoading) {
              return LoadingView();
            } else if (state is ConnectionAcceptListLoaded &&
                state.response.data?.userList?.data?.length == 0) {
              return Center(
                child: Text(
                  "Notification list is empty",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              );
            }
            return Container();
          }, listener: (context, state) {
            if (state is ConnectionAcceptListLoaded) {
              connectionAcceptList
                  ?.addAll(state.response.data!.userList!.data!);
              setState(() {});
            } else if (state is ConnectionAcceptLoaded ||
                state is ConnectionDenyLoaded) {
              connectionAcceptList = [];
              setState(() {});
              _cubit.connectionAcceptList(context, 1);
            }
          })
        ],
      ),
    );
  }
}
