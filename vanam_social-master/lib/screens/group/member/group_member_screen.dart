import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vanam_social/data/cubit/group/group_cubit.dart';
import 'package:vanam_social/data/cubit/group/group_state.dart';
import 'package:vanam_social/data/remote/model/group/group_member_list_response.dart';
import 'package:vanam_social/screens/components/loading_view.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';
import 'package:vanam_social/screens/friend/friend_screen.dart';

import '../../../constants.dart';

class GroupMemberScreen extends StatefulWidget {
  final int groupId;

  const GroupMemberScreen({Key? key,required this.groupId}) : super(key: key);
  @override
  _GroupMemberScreenState createState() => _GroupMemberScreenState();
}

class _GroupMemberScreenState extends State<GroupMemberScreen> {
  late GroupCubit _cubit;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  GroupMemberListResponse? groupMemberListResponse;
  List<GroupMemberListResponseDataGroupMemberData?>?  memberList = [];
  ScrollController? _scrollController;
  double? _scrollPosition;
  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController?.position.pixels;
      if (_scrollController?.position.pixels ==
          _scrollController?.position.maxScrollExtent) {
        if ((groupMemberListResponse?.data?.groupMember?.lastPage ?? 0) >
            (groupMemberListResponse?.data?.groupMember?.currentPage ?? 0)) {
          _cubit.groupMembers(context,(groupMemberListResponse?.data?.groupMember?.currentPage ?? 1) + 1,widget.groupId);

        }
      }
    });
  }
  @override
  void initState() {
    _cubit = BlocProvider.of(context,listen: false);
    super.initState();
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollListener);
    _cubit.groupMembers(context,1,widget.groupId);
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
      body: BlocConsumer<GroupCubit,GroupState>(builder: (context,state){
        return Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: ListView(
                 controller: _scrollController,
                  children: [
                    Text(
                      "Group Members",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: memberList?.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          GroupMemberListResponseDataGroupMemberData? member = memberList?[index];
                          return InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>FriendScreen(friendId: member?.user?.id??0)));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color(0xff000000).withOpacity(0.08),
                                        spreadRadius: 2,
                                        blurRadius: 1)
                                  ]),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "$ImageBaseUrl${member?.user?.image}"),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                      child: Text(
                                        "${member?.user?.name}",
                                        style: Theme.of(context).textTheme.subtitle1,
                                      )),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.more_horiz)),
                                ],
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
            if(state is GroupMemberListLoading)Center(child: LoadingView(),),

          ],
        );
      }, listener: (context,state){
        if(state is GroupMemberListLoaded){
          memberList?.addAll(state.response.data!.groupMember!.data!);
          groupMemberListResponse= state.response;
          setState(() {
          });
        }
      }),
    );
  }
}
