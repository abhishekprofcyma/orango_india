import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vanam_social/data/cubit/friend/friend_cubit.dart';
import 'package:vanam_social/data/cubit/friend/friend_state.dart';
import 'package:vanam_social/data/remote/model/friend/friend_block_list_response.dart';
import 'package:vanam_social/screens/components/loading_view.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';

import '../../../constants.dart';

class BlockedAccountScreen extends StatefulWidget {
  @override
  _BlockedAccountScreenState createState() => _BlockedAccountScreenState();
}

class _BlockedAccountScreenState extends State<BlockedAccountScreen> {
  late FriendCubit _cubit;
  FriendBlockListResponse? _blockListResponse;
  List<FriendBlockListResponseDataUserListData?>? blockList = [];
  ScrollController? _scrollController;
  double? _scrollPosition;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController?.position.pixels;
      if (_scrollController?.position.pixels ==
          _scrollController?.position.maxScrollExtent) {
        if ((_blockListResponse?.data?.userList?.lastPage ?? 0) >
            (_blockListResponse?.data?.userList?.currentPage ?? 0)) {
          _cubit.friendBlockList(context,
              (_blockListResponse?.data?.userList?.currentPage ?? 1) + 1);
        }
      }
    });
  }

  @override
  void initState() {
    _cubit = BlocProvider.of(context, listen: false);
    super.initState();
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollListener);
    _cubit.friendBlockList(context, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kPrimaryColor),
        leading: IconButton(
          icon: SvgPicture.asset("assets/images/ic_back_arrow_green.svg"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocConsumer<FriendCubit, FriendState>(builder: (context, state) {
        return Stack(
          children: [
            SafeArea(
              child: ListView(
                controller: _scrollController,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Blocked accounts",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: blockList?.length,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        FriendBlockListResponseDataUserListData? blockUser =
                            blockList?[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xff000000).withOpacity(0.08),
                                    offset: Offset(0.3, -.7),
                                    blurRadius: 2,
                                    spreadRadius: 1)
                              ]),
                          child: Row(
                            children: [
                              blockUser?.friend?.image == null ? SvgPicture.asset("assets/images/user.svg",height: 32,width: 32,):CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "$ImageBaseUrl${blockUser?.friend?.image}"),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                  child: Text(
                                "${blockUser?.friend?.name}",
                                style: Theme.of(context).textTheme.subtitle1,
                              )),
                              OutlinedButton(
                                onPressed: () {
                                  _cubit.friendUnBlock(
                                      context, blockUser?.friend?.id ?? 0);
                                },
                                child: Text(
                                  "unblock",
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                      width: 0.5, color: Color(0xffFFCC00)),
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                ],
              ),
            ),
            if (state is FriendBlockListLoading ||
                state is FriendUnBlockLoading)
              Center(
                child: LoadingView(),
              )
          ],
        );
      }, listener: (context, state) {
        if (state is FriendBlockListLoaded) {
          blockList?.addAll(state.response.data!.userList!.data!);
          _blockListResponse = state.response;
          setState(() {});
        } else if (state is FriendUnBlockDone) {
          Fluttertoast.showToast(msg: "Account Un-Blocked successfully");
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => BlockedAccountScreen()));
        }
      }),
    );
  }
}
