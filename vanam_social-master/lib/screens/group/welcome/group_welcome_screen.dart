import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vanam_social/constants.dart';
import 'package:vanam_social/data/cubit/group/group_cubit.dart';
import 'package:vanam_social/data/cubit/group/group_state.dart';
import 'package:vanam_social/data/remote/model/group/group_list_response.dart';
import 'package:vanam_social/data/remote/model/group/popular_group_response.dart';
import 'package:vanam_social/screens/components/loading_view.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';
import 'package:vanam_social/screens/group/create/group_create_screen.dart';
import 'package:vanam_social/screens/group/group/group_screen.dart';
import 'package:vanam_social/screens/group/groups/groups_joined_screen.dart';
import 'package:vanam_social/screens/group/groups/groups_screen.dart';
import 'package:vanam_social/screens/group/popular_group/popular_group_screen.dart';
import 'package:vanam_social/screens/home/components/drawer_view.dart';
import 'package:vanam_social/screens/home/components/vanam_app_bar_view.dart';
import 'package:vanam_social/screens/home/components/vanam_bottom_navigation_bar_view.dart';
import 'package:vanam_social/screens/home/home_screen.dart';

class GroupWelcomeScreen extends StatefulWidget {
  @override
  _GroupWelcomeScreenState createState() => _GroupWelcomeScreenState();
}

class _GroupWelcomeScreenState extends State<GroupWelcomeScreen> {
  late GroupCubit _cubit;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  GroupListResponse? groupListResponse;
  List<PopularGroupResponseDataGroupData?>? popularGroupList = [];

  @override
  void initState() {
    _cubit = BlocProvider.of(context,listen: false);
    super.initState();
    _cubit.groupList(context,1);
    _cubit.popularGroupList(context, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocConsumer<GroupCubit,GroupState>(builder: (context,state){
        return Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    VanamAppBarView(
                      onMenuTap: () {
                        _key.currentState!.openDrawer();
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupCreateScreen()));
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            child: Stack(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/ic_chat_circle_button_bg.svg",
                                  width: 56,
                                  height: 56,
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      "assets/images/ic_group_create.svg",
                                      color: Colors.black,
                                      width: 32,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          PrimaryButton(text: "Create Group",press: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupCreateScreen()));
                          },)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        "Groups are spaces for focusing and sharing right contents with right people!",
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(height: 16,),
                    if(popularGroupList?.length != 0) popularGroupView(),
                    SizedBox(height: 8,),
                    Container(
                      alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text("See your",style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold),textAlign: TextAlign.start,)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PrimaryButton(text: "Created Groups",press: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupsScreen()));
                        },),
                        PrimaryButton(text: "Joined Groups",press: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupsJoinedScreen()));
                        },)
                      ],
                    )
                  ],
                ),
              ),
            ),
            if(state is GroupListLoading) Center(child: LoadingView(),),
          ],
        );
      }, listener: (context,state){
        if(state is GroupListAdded){
          groupListResponse = state.response;
        }else if(state is GroupPopularListAdded){
          popularGroupList=[];
          popularGroupList?.addAll(state.response.data!.group!.data!);
          setState(() {
          });
        }
      }),
      drawer: DrawerView(),
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

  Widget popularGroupView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Popular groups near you",style: Theme.of(context).textTheme.subtitle2?.copyWith(fontWeight: FontWeight.bold),),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupsScreen()));
              }, child: Text("See all",style: TextStyle(color: Color(0xff007F00)),))
            ],
          ),
          SizedBox(height: 160,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: popularGroupList?.length,
                scrollDirection: Axis.horizontal,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  PopularGroupResponseDataGroupData? popularGroup = popularGroupList?[index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupScreen(groupId: popularGroup?.id??0)));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Stack(
                        children: [
                          if(popularGroup?.url != null)ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network("$ImageBaseUrl${popularGroup?.url}",fit: BoxFit.cover,width: 160,),
                          ),
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                gradient: LinearGradient(colors: [
                                  Colors.black.withOpacity(0.0),
                                  Colors.black.withOpacity(0.25),
                                  Colors.black
                                ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter)
                            ),
                          ),
                          Container(
                            width: 160,
                            height: 160,
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${popularGroup?.name}",style: TextStyle(color: Colors.white),softWrap: true,overflow: TextOverflow.ellipsis,),
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                }),)
        ],
      ),
    );
  }

  Widget groupTopView(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
              child: Image.network("https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg",width: double.infinity,height: 180,fit: BoxFit.cover,)),
          Container(
            height: 180,
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffFFFFFF).withOpacity(0),
                  Color(0xff000000)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Travelling Group",style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }

}
