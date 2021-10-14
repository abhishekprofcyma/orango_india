import 'dart:async';
import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vanam_social/data/cubit/post_list/post_list_cubit.dart';
import 'package:vanam_social/data/cubit/post_list/post_list_state.dart';
import 'package:vanam_social/data/local/shared_pref.dart';
import 'package:vanam_social/data/remote/model/post/post_list_response.dart';
import 'package:vanam_social/main.dart';
import 'package:vanam_social/screens/components/vanam_icon_view.dart';
import 'package:vanam_social/screens/home/components/drawer_view.dart';
import 'package:vanam_social/screens/home/components/fab_menu_view.dart';
import 'package:vanam_social/screens/home/components/vanam_app_bar_view.dart';
import 'package:vanam_social/screens/home/home/component/home_tab_moments_view.dart';
import 'package:vanam_social/screens/home/home/component/post_item_view.dart';
import 'package:vanam_social/screens/home/home_screen.dart';
import 'package:vanam_social/screens/login/login_screen.dart';
import 'package:vanam_social/screens/profile/profile_screen.dart';
import 'package:vanam_social/screens/vendor/vendor_list/vendor_zone_screen.dart';

class HomeTabView extends StatefulWidget {
  @override
  _HomeTabViewState createState() => _HomeTabViewState();
}

class _HomeTabViewState extends State<HomeTabView> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late PostListCubit _cubit;
  PostListResponse? _postListResponse;
  List<PostListResponseDataPostListData?>? postList = [];
  ScrollController? _scrollController;
  double? _scrollPosition;
  DatabaseReference? reference;
  StreamSubscription<Event>? refrenceListner;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController?.position.pixels;
      if (_scrollController?.position.pixels ==
          _scrollController?.position.maxScrollExtent) {
        if ((_postListResponse?.data?.postList?.lastPage ?? 0) >
            (_postListResponse?.data?.postList?.currentPage ?? 0)) {
          _cubit.postList(context,
              (_postListResponse?.data?.postList?.currentPage ?? 1) + 1, 0);
        }
      }
    });
  }

  @override
  void initState() {
    _cubit = BlocProvider.of<PostListCubit>(context, listen: false);
    super.initState();
    init();
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollListener);
    _cubit.postList(context, 1, 0);
  }

  init() async {
    String userId = (await getUserId())!;
    String deviceID = await getDeviceId();
    reference =
        FirebaseDatabase.instance.reference().child("login").child(userId);
    List<bool> loginDevice = [];
    try {
      refrenceListner = reference?.onChildAdded.listen((event) {
        print("event add listner");

        LinkedHashMap<Object?, Object?> data = event.snapshot.value;
        print("device id ${data['device_id']}");
        if (data['device_id'] == deviceID) {
          loginDevice.add(true);
        } else if (data['device_id'] != deviceID) {
          loginDevice.add(false);
        }
        setState(() {});
      });
    } catch (e) {}
    Timer(Duration(seconds: 2), () async {
      if (loginDevice.contains(true)) {
      } else {
        Fluttertoast.showToast(msg: "Logout");
        saveToken("");
        saveLogin(false);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }

  Future<void> _pullRefresh() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _pullRefresh,
          child: ListView(
            controller: _scrollController,
            children: [
              VanamIconView(),
              VanamAppBarView(
                isHomePage: true,
                onMenuTap: () {
                  _key.currentState!.openDrawer();
                },
              ),
              HomeTabMomentsView(),
              Stack(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: postList?.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        PostListResponseDataPostListData? post =
                            postList?[index];

                        return PostItemView(
                          post: post,
                        );
                      }),
                  BlocConsumer<PostListCubit, PostListState>(
                      builder: (context, state) {
                    return Container();
                  }, listener: (context, state) {
                    if (state is PostListLoaded) {
                      postList?.addAll(state.response.data!.postList!.data!);
                      _postListResponse = state.response;
                      setState(() {});
                    }
                  })
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              opaque: false, // set to false
              pageBuilder: (_, __, ___) => FabMenuView(),
            ),
          );

        },
        child:  Container(
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(4),
          child: SvgPicture.asset("assets/images/ic_vanam.svg",width: 24,height: 24,),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [Color(0xffFFEC3B), Color(0xffFFCC00)])
          ),
        ),
      ),
      drawer: DrawerView(),
    );
  }
}




