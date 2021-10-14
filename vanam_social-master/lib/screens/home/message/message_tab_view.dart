import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vanam_social/constants.dart';
import 'package:vanam_social/data/cubit/friend/friend_cubit.dart';
import 'package:vanam_social/data/cubit/friend/friend_state.dart';
import 'package:vanam_social/data/local/shared_pref.dart';
import 'package:vanam_social/data/remote/model/friend/friend_list_response.dart';
import 'package:vanam_social/screens/components/loading_view.dart';
import 'package:vanam_social/screens/home/components/drawer_view.dart';
import 'package:vanam_social/screens/home/components/vanam_app_bar_view.dart';
import 'package:vanam_social/screens/messenger/chat_screen.dart';

class MessageTabView extends StatefulWidget {
  @override
  _MessageTabViewState createState() => _MessageTabViewState();
}

class _MessageTabViewState extends State<MessageTabView> {
  DatabaseReference? reference;
  late FriendCubit _cubit;
  FriendListResponse? _friendListResponse;
  List<FriendItem?>? friendList = [];
  ScrollController? _scrollController;
  double? _scrollPosition;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController?.position.pixels;
      if (_scrollController?.position.pixels ==
          _scrollController?.position.maxScrollExtent) {
        if ((_friendListResponse?.data?.userList?.lastPage ?? 0) >
            (_friendListResponse?.data?.userList?.currentPage ?? 0)) {
          _cubit.friendList(context,
              (_friendListResponse?.data?.userList?.currentPage ?? 1) + 1);
        }
      }
    });
  }

  @override
  void initState() {
    _cubit = BlocProvider.of<FriendCubit>(context, listen: false);
    super.initState();
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollListener);
    _cubit.friendList(context, 1);
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
                Expanded(
                  child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: friendList?.length,
                      itemBuilder: (context, index) {
                        FriendItem? friend = friendList?[index];

                        return MessageItemView(
                          friend: friend!,
                        );
                      }),
                )
              ],
            ),
          ),
          BlocConsumer<FriendCubit, FriendState>(builder: (context, state) {
            if (state is FriendLoading) {
              return LoadingView();
            } else if (state is FriendLoaded &&
                state.response.data?.userList?.data?.length == 0) {
              return Center(
                child: Text(
                  "Message list is empty",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              );
            }
            return Container();
          }, listener: (context, state) {
            if (state is FriendLoaded) {
              friendList?.addAll(state.response.data!.userList!.data!);
              setState(() {});
              friendList?.forEach((element) async {
                var chatId = await getChatId(element!);
                reference = FirebaseDatabase.instance
                    .reference()
                    .child("message")
                    .child(chatId.toString());
                try {
                  reference?.onValue.listen((event) async {
                    LinkedHashMap<Object?, Object?> data = event.snapshot.value;
                    data.forEach((key, value) {
                      LinkedHashMap<Object?, Object?> subData =
                          data as LinkedHashMap<Object?, Object?>;
                      LinkedHashMap<Object?, Object?> sub1Data = subData
                          .values.last as LinkedHashMap<Object?, Object?>;
                      setState(() {
                        // lastMessage = "${sub1Data['text']}";
                      });
                    });
                  });
                } catch (e) {}
              });
            }
          })
        ],
      ),
    );
  }

  Future<String> getChatId(FriendItem friend) async {
    var userId = await getUserId();
    if (friend.friend!.id! > int.parse("${userId ?? 0}")) {
      return "${friend.friend?.id}$userId";
    } else {
      return "$userId${friend.friend?.id}";
    }
    return "";
  }
}

class MessageItemView extends StatefulWidget {
  final FriendItem friend;

  const MessageItemView({Key? key, required this.friend}) : super(key: key);

  @override
  _MessageItemViewState createState() => _MessageItemViewState();
}

class _MessageItemViewState extends State<MessageItemView> {
  late FriendItem friend;
  DatabaseReference? reference;
  String? lastMessage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      friend = widget.friend;
    });
    init();
  }

  init() async {
    var chatId = await getChatId();
    print("chat Id $chatId");
    reference = FirebaseDatabase.instance
        .reference()
        .child("message")
        .child(chatId.toString());
    try {
      reference?.onValue.listen((event) async {
        LinkedHashMap<Object?, Object?> data = event.snapshot.value;
        data.forEach((key, value) {
          LinkedHashMap<Object?, Object?> subData =
              data as LinkedHashMap<Object?, Object?>;
          LinkedHashMap<Object?, Object?> sub1Data =
              subData.values.last as LinkedHashMap<Object?, Object?>;
          setState(() {
            lastMessage = "${sub1Data['text']}";
          });
        });
      });
    } catch (e) {}
  }

  Future<String> getChatId() async {
    var userId = await getUserId();
    if (widget.friend.friend!.id! > int.parse("${userId ?? 0}")) {
      return "${widget.friend.friend?.id}$userId";
    } else {
      return "$userId${widget.friend.friend?.id}";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatScreen(
                      friendId: friend.friend?.id ?? 0,
                      friendName: friend.friend?.name ?? "",
                      friendImage: friend.friend?.image ?? "",
                    )));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color(0xffEEEEEE),
                  offset: Offset(0.3, 1.6),
                  spreadRadius: 1,
                  blurRadius: 2)
            ]),
        child: Row(
          children: [
            friend.friend?.image == null
                ? SvgPicture.asset(
                    "assets/images/user.svg",
                    width: 46,
                    height: 46,
                  )
                : CircleAvatar(
                    backgroundImage:
                        NetworkImage("$ImageBaseUrl${friend.friend?.image}"),
                    radius: 24,
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
                  "${friend.friend?.name}",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(
                  "${lastMessage ?? ""}",
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.8)),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
