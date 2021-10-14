import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanam_social/constants.dart';
import 'package:vanam_social/data/cubit/group/group_cubit.dart';
import 'package:vanam_social/data/cubit/group/group_state.dart';
import 'package:vanam_social/data/remote/model/group/group_joined_list_response.dart';
import 'package:vanam_social/data/remote/model/group/group_list_response.dart';
import 'package:vanam_social/data/remote/model/group/popular_group_response.dart';
import 'package:vanam_social/screens/components/loading_view.dart';
import 'package:vanam_social/screens/group/group/group_screen.dart';
import 'package:vanam_social/screens/group/popular_group/popular_group_screen.dart';
import 'package:vanam_social/screens/home/components/drawer_view.dart';
import 'package:vanam_social/screens/home/components/vanam_app_bar_view.dart';

class GroupsJoinedScreen extends StatefulWidget {
  @override
  _GroupsJoinedScreenState createState() => _GroupsJoinedScreenState();
}

class _GroupsJoinedScreenState extends State<GroupsJoinedScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late GroupCubit _cubit;
  GroupJoinedListResponse? _groupListResponse;
  List<GroupJoinedListResponseDataGroupData?>? groupList = [];
  ScrollController? _scrollController;
  double? _scrollPosition;
  List<PopularGroupResponseDataGroupData?>? popularGroupList = [];

  List<String> imageList = [
    'https://cdn.pixabay.com/photo/2019/03/15/09/49/girl-4056684_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg',
    'https://cdn.pixabay.com/photo/2020/09/18/19/31/laptop-5582775_960_720.jpg',
    'https://media.istockphoto.com/photos/woman-kayaking-in-fjord-in-norway-picture-id1059380230?b=1&k=6&m=1059380230&s=170667a&w=0&h=kA_A_XrhZJjw2bo5jIJ7089-VktFK0h0I4OWDqaac0c=',
    'https://cdn.pixabay.com/photo/2019/11/05/00/53/cellular-4602489_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/02/12/10/29/christmas-2059698_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/11/22/17/28/cat-5767334_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/13/16/22/snow-5828736_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/09/09/27/women-5816861_960_720.jpg',
  ];

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController?.position.pixels;
      if (_scrollController?.position.pixels ==
          _scrollController?.position.maxScrollExtent) {
        if ((_groupListResponse?.data?.group?.lastPage ?? 0) >
            (_groupListResponse?.data?.group?.currentPage ?? 0)) {
          _cubit.groupJoinedList(
              context, (_groupListResponse?.data?.group?.currentPage ?? 1) + 1);
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
    _cubit.groupJoinedList(context, 1);
    _cubit.popularGroupList(context, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocConsumer<GroupCubit, GroupState>(builder: (context, state) {
        return Stack(
          children: [
            SafeArea(
              child: ListView(
                controller: _scrollController,
                children: [
                  VanamAppBarView(
                    onMenuTap: () {
                      _key.currentState!.openDrawer();
                    },
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Joined Groups",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  if (state is GroupListAdded &&
                      groupList?.length == 0)
                    Center(
                      child: Text("You joined group list is empty"),
                    ),
                  ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: groupList?.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        GroupJoinedListResponseDataGroupData? group =
                            groupList?[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GroupScreen(
                                          groupId: group?.group?.id ?? 0,
                                        )));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            margin: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color:
                                          Color(0xff000000).withOpacity(0.08),
                                      spreadRadius: 2,
                                      blurRadius: 1)
                                ]),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "${ImageBaseUrl}${group?.group?.url}"),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${group?.group?.name}",
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.circle,
                                          size: 10,
                                          color: Color(0xff3B3B3B),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                  if (popularGroupList?.length != 0) popularGroupView(),
                  //groupTopView()
                ],
              ),
            ),
            if (state is GroupListLoading)
              Center(
                child: LoadingView(),
              ),
          ],
        );
      }, listener: (context, state) {
        if (state is GroupJoinedListAdded) {
          groupList?.addAll(state.response.data!.group!.data!);
          _groupListResponse = state.response;
          setState(() {});
        } else if (state is GroupPopularListAdded) {
          popularGroupList?.addAll(state.response.data!.group!.data!);
          setState(() {});
        }
      }),
      drawer: DrawerView(),
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
              Text(
                "Popular groups near you",
                style: Theme.of(context).textTheme.subtitle2,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PopularGroupScreen()));
                  },
                  child: Text(
                    "See all",
                    style: TextStyle(color: Color(0xff007F00)),
                  ))
            ],
          ),
          SizedBox(
            height: 160,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: popularGroupList?.length,
                scrollDirection: Axis.horizontal,
                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  PopularGroupResponseDataGroupData? popularGroup =
                      popularGroupList?[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  GroupScreen(groupId: popularGroup?.id ?? 0)));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Stack(
                        children: [
                          if (popularGroup?.url != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                "$ImageBaseUrl${popularGroup?.url}",
                                fit: BoxFit.cover,
                                width: 160,
                              ),
                            ),
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.0),
                                      Colors.black.withOpacity(0.25),
                                      Colors.black
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter)),
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
                }),
          )
        ],
      ),
    );
  }

  Widget groupTopView() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                "https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg",
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              )),
          Container(
            height: 180,
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xffFFFFFF).withOpacity(0), Color(0xff000000)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Travelling Group",
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
