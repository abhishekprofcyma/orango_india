import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vanam_social/constants.dart';
import 'package:vanam_social/data/cubit/connection/connection_cubit.dart';
import 'package:vanam_social/data/cubit/connection/connection_state.dart';
import 'package:vanam_social/data/remote/model/connection/connection_response.dart';
import 'package:vanam_social/screens/components/loading_view.dart';
import 'package:vanam_social/screens/friend/friend_screen.dart';
import 'package:vanam_social/screens/home/components/drawer_view.dart';
import 'package:vanam_social/screens/home/components/vanam_app_bar_view.dart';

class ConnectTabView extends StatefulWidget {
  @override
  _ConnectTabViewState createState() => _ConnectTabViewState();
}

class _ConnectTabViewState extends State<ConnectTabView> {
  late ConnectionCubit _cubit;
  List<ConnectionResponseDataUserListData?>? _connectionList = [];
  ConnectionResponse? _connectionResponse;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  ScrollController? _scrollController;
  double? _scrollPosition;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController?.position.pixels;
      if (_scrollController?.position.pixels ==
          _scrollController?.position.maxScrollExtent) {
        if ((_connectionResponse?.data?.userList?.lastPage ?? 0) >
            (_connectionResponse?.data?.userList?.currentPage ?? 0)) {
          _cubit.connectionList(context,
              (_connectionResponse?.data?.userList?.currentPage ?? 1) + 1);
        }
      }
    });
  }

  @override
  void initState() {
    _cubit = BlocProvider.of<ConnectionCubit>(context, listen: false);
    super.initState();
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollListener);
    _cubit.connectionList(context, 1);
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
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: VanamAppBarView(onMenuTap: () {
                    _key.currentState!.openDrawer();
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Meet Vanam users. Send friend request to people you know.",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: _connectionList?.length,
                      itemBuilder: (context, index) {
                        ConnectionResponseDataUserListData? connection =
                            _connectionList?[index];
                        print("image ${connection?.image}");
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FriendScreen(
                                          friendId: connection?.id ?? 0,
                                          isAccountPrivate: true,
                                        )));
                          },
                          child: Container(
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
                            child: Row(
                              children: [
                                connection?.image == null
                                    ? SvgPicture.asset("assets/images/user.svg",height: 36,width: 36,)
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "$ImageBaseUrl${connection?.image}"),
                                      ),
                                SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                    child: Text(
                                  "${connection?.name}",
                                  style: Theme.of(context).textTheme.subtitle1,
                                )),
                                IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 16,
                                                  ),
                                                  Center(
                                                    child: Column(
                                                      children: [
                                                        connection?.image == null? SvgPicture.asset("assets/images/user.svg",height: 46,width: 46,) :CircleAvatar(
                                                          radius: 30,
                                                          backgroundImage:
                                                              NetworkImage(
                                                            "$ImageBaseUrl${connection?.image}",
                                                          ),
                                                        ),
                                                        Text(
                                                          "${connection?.name}",
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .headline6,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  TextButton.icon(
                                                      onPressed: () {
                                                        _cubit
                                                            .connectionReqSend(
                                                                context,
                                                                connection
                                                                        ?.id ??
                                                                    0);
                                                      },
                                                      icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .userPlus),
                                                      label: Text(
                                                          "Send Connection request")),
                                                  TextButton.icon(
                                                      onPressed: () {},
                                                      icon: FaIcon(
                                                          FontAwesomeIcons.ban),
                                                      label: Text(
                                                          "Block ${connection?.name ?? ""}")),
                                                  TextButton.icon(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .timesCircle),
                                                      label: Text("Dismiss")),
                                                  SizedBox(
                                                    height: 16,
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    icon: SvgPicture.asset(
                                        "assets/images/ic_menu_horizontal.svg"))
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
          BlocConsumer<ConnectionCubit, ConnectionsState>(
              builder: (context, state) {
            if (state is ConnectionLoading ||
                state is ConnectionRequestLoading) {
              return LoadingView();
            } else if (state is ConnectionLoaded &&
                state.response.data?.userList?.data?.length == 0) {
              return Expanded(
                  child: Center(
                child: Text(
                  "You have already sent friend request to all users.",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ));
            }
            return Container();
          }, listener: (context, state) {
            if (state is ConnectionLoaded) {
              _connectionList?.addAll(state.response.data!.userList!.data!);
              _connectionResponse = state.response;
              setState(() {});
            } else if (state is ConnectionRequestLoaded) {
              Fluttertoast.showToast(
                  msg: "Connection request send successfully");
              _connectionList = [];
              setState(() {});
              _cubit.connectionList(context, 1);
            } else if (state is ConnectionRequestError) {
              Fluttertoast.showToast(msg: "Connection request failed to send");
            }
          })
        ],
      ),
    );
  }
}
