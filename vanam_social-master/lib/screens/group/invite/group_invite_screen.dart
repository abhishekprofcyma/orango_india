import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vanam_social/data/cubit/group/group_cubit.dart';
import 'package:vanam_social/data/cubit/group/group_state.dart';
import 'package:vanam_social/data/remote/model/group/group_invite_list_response.dart';
import 'package:vanam_social/screens/components/loading_view.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';

import '../../../constants.dart';

class GroupInviteScreen extends StatefulWidget {
  final int groupId;

  const GroupInviteScreen({Key? key,required this.groupId}) : super(key: key);
  @override
  _GroupInviteScreenState createState() => _GroupInviteScreenState();
}

class _GroupInviteScreenState extends State<GroupInviteScreen> {
  late GroupCubit _cubit;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  GroupInviteListResponse? groupInviteListResponse;
  List<GroupInviteListResponseDataGroupInviteData?>? inviteList = [];
  ScrollController? _scrollController;
  double? _scrollPosition;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController?.position.pixels;
      if (_scrollController?.position.pixels ==
          _scrollController?.position.maxScrollExtent) {
        if ((groupInviteListResponse?.data?.groupInvite?.lastPage ?? 0) >
            (groupInviteListResponse?.data?.groupInvite?.currentPage ?? 0)) {
          _cubit.groupInviteList(
              context,
              (groupInviteListResponse?.data?.groupInvite?.currentPage ?? 1) +
                  1,widget.groupId);
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
    _cubit.groupInviteList(context, 1,widget.groupId);
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
      body: BlocConsumer<GroupCubit, GroupState>(builder: (context, state) {
        return Stack(
          children: [
            SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: ListView(
                  controller: _scrollController,
                  children: [
                    Text(
                      "Invite",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: inviteList?.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          GroupInviteListResponseDataGroupInviteData? invite = inviteList?[index];
                          return InkWell(
                            onTap: () {},
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
                                        color: Color(0xff000000)
                                            .withOpacity(0.08),
                                        spreadRadius: 2,
                                        blurRadius: 1)
                                  ]),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "$ImageBaseUrl${invite?.image}"),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                      child: Text(
                                    "${invite?.name}",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  )),
                                 if(invite?.groupInvite == null )...[
                                   PrimaryButton(text: "Invite", press: () {
                                     _cubit.groupInvitationAdd(context, widget.groupId, invite?.id??0);
                                   })
                                 ],
                                  if(invite?.groupInvite != null)...[
                                    SecondaryButton(text: "Remove", press: (){
                                      _cubit.groupInvitationRemove(context, widget.groupId,invite?.id??0, invite?.groupInvite?.id??0);
                                    })
                                  ]
                                ],
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
            if (state is GroupInviteListLoading)
              Center(
                child: LoadingView(),
              ),
          ],
        );
      }, listener: (context, state) {
        if (state is GroupInviteListLoaded) {
          inviteList?.addAll(state.response.data!.groupInvite!.data!);
          groupInviteListResponse = state.response;
          setState(() {});
        }else if(state is GroupInviteAddLoaded){
          Fluttertoast.showToast(msg: "Invitation link send successfully to user");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GroupInviteScreen(groupId:widget.groupId)));
        }else if(state is GroupInviteRemoveLoaded){
          Fluttertoast.showToast(msg: "Invitation link removed");
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GroupInviteScreen(groupId:widget.groupId)));
        }
      }),
    );
  }
}
