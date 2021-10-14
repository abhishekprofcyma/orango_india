import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vanam_social/constants.dart';
import 'package:vanam_social/data/cubit/moment/moment_cubit.dart';
import 'package:vanam_social/data/cubit/moment/moment_state.dart';
import 'package:vanam_social/data/local/shared_pref.dart';
import 'package:vanam_social/data/remote/model/moment/MomentListResponse.dart';
import 'package:vanam_social/screens/components/CircleProgressPainter.dart';
import 'package:vanam_social/screens/components/dotted_circular_view.dart';
import 'package:vanam_social/screens/components/video_player_view.dart';
import 'package:vanam_social/screens/moment/moment_add_screen.dart';
import 'package:vanam_social/screens/moment/moment_preview_screen.dart';
import 'package:video_player/video_player.dart';

extension UtilListExtension on List {
  groupBy(String key) {
    try {
      List<Map<String, dynamic>> result = [];
      List<String> keys = [];

      this.forEach((f) => keys.add(f[key]));

      [...keys.toSet()].forEach((k) {
        List data = [...this.where((e) => e[key] == k)];
        result.add({k: data});
      });

      return result;
    } catch (e, s) {
      //printCatchNReport(e, s);
      return this;
    }
  }
}

class HomeTabMomentsView extends StatefulWidget {
  @override
  _HomeTabMomentsViewState createState() => _HomeTabMomentsViewState();
}

class _HomeTabMomentsViewState extends State<HomeTabMomentsView> {
  late MomentCubit _cubit;
  List<MomentItem>? moments = [];
  MomentListResponse? response;
  String userImage = "";

  @override
  void initState() {
    _cubit = BlocProvider.of<MomentCubit>(context, listen: false);
    super.initState();
    _cubit.momentList(context);
    init();
  }

  init()async{
    String tImage = await getUserImage();
    setState(() {
      userImage = tImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MomentCubit, MomentState>(builder: (context, state) {
      var groupByData =
          groupBy(moments!, (MomentItem obj) => obj.friend?.id.toString());
      print("data ${groupByData.values}");

      return Container(
        height: 120,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        child: Row(
          children: [
            addMoment(),
            state is MomentListAdded &&
                    state.momentListResponse.data?.momentList?.data?.length == 0
                ? Center(
                  child: Text(
                      "",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                )
                : ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: groupByData.length + 0,
                    itemBuilder: (context, index) {
                      // if (index == 0) {
                      //   return addMoment();
                      // }else {
                      var moment = groupByData.values.elementAt(index );
                      print("data ${moment}");
                      return storiesSingleAvatarView(
                          moment.first, moment, index , groupByData);
                      //}
                    }),
          ],
        ),
      );

      return Container();
    }, listener: (context, state) {
      if (state is MomentListAdded) {
        response = state.momentListResponse;
        moments = state.momentListResponse.data?.momentList?.data;
        setState(() {});
      }
    });
  }

  Widget addMoment() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 46,
                height: 46,
                margin: const EdgeInsets.all(2),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
                child:
                 CircleAvatar(
                  backgroundImage: response?.data?.myMomentList?.length != 0  ? (response?.data?.myMomentList?.first.url ?? "")
                      .toString()
                      .contains(".mp4")
                      ? NetworkImage(
                      "https://www.freeiconspng.com/thumbs/video-play-icon/video-play-icon-15.gif")
                      : NetworkImage("$ImageBaseUrl${response?.data?.myMomentList?.last.url ?? ""}")
                   : NetworkImage("$ImageBaseUrl$userImage"),

                ),
              ),
            ),
            InkWell(
              onTap: () {
                Map<String?, List<MomentItem>> data =
                    Map<String?, List<MomentItem>>();
                if (response?.data?.myMomentList?.length != 0) {
                  data['1'] = response!.data!.myMomentList!;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MomentPreview(
                                currentIndex: 0,
                                allMoments: data,
                              )));
                }
              },
              child: IntervalProgressBar(
                direction: IntervalProgressDirection.circle,
                max: response?.data?.myMomentList?.length??0,
                progress: 0,
                intervalSize: 10,
                size: Size(70, 70),
                highlightColor: kPrimaryColor,
                defaultColor: Colors.green,
                intervalColor: Colors.transparent,
                intervalHighlightColor: Colors.transparent,
                radius: 10,
                intervalDegrees: 10,
                strokeWith: 2,
              ),
            ),
            Positioned(
              bottom: 2,
              right: 2,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddMomentsView()));
                },
                child: Container(
                  width: 24,
                  height: 24,
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            offset: Offset(0.2, 1.3))
                      ]),
                  child: SvgPicture.asset(
                    "assets/images/ic_plus.svg",
                    width: 14,
                    height: 14,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget storiesSingleAvatarView(MomentItem? moment, List<MomentItem>? data,
      int index, Map<String?, List<MomentItem>> groupByData) {
    return InkWell(
      onTap: () {
        if ((moment?.url ?? "").contains(".mp4")) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VanamVideoPlayerView(
                        autoplay: true,
                        looping: false,
                        videoPlayerController: VideoPlayerController.network(
                            "${ImageBaseUrl}${moment?.url}"),
                      )));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MomentPreview(
                        currentIndex: index,
                        allMoments: groupByData,
                      )));
        }
      },
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                padding: const EdgeInsets.all(0),
                margin: EdgeInsets.all(6),
                child: IntervalProgressBar(
                  direction: IntervalProgressDirection.circle,
                  max: groupByData.values.elementAt(index).length,
                  progress: 0,
                  intervalSize: 10,
                  size: Size(70, 70),
                  highlightColor: kPrimaryColor,
                  defaultColor: Colors.grey,
                  intervalColor: Colors.transparent,
                  intervalHighlightColor: Colors.transparent,
                  radius: 10,
                  intervalDegrees: 10,
                  strokeWith: 3,
                ),
              ),
              Text(
                (moment?.friend?.user?.name ?? "").toString().toUpperCase(),
                style: TextStyle(
                    fontSize: 12,
                    color: Color(0xff3B3B3B),
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  padding: const EdgeInsets.all(5),
                  margin: EdgeInsets.all(6),
                  child: CircleAvatar(
                    backgroundImage: (moment?.url ?? "")
                            .toString()
                            .contains(".mp4")
                        ? NetworkImage(
                            "https://www.freeiconspng.com/thumbs/video-play-icon/video-play-icon-15.gif")
                        : NetworkImage("$ImageBaseUrl${moment?.url}"),
                  ),
                ),
                Text(
                  (moment?.friend?.user?.name ?? "").toString().toUpperCase(),
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff3B3B3B),
                      fontWeight: FontWeight.w600),
                )
              ]),
        ],
      ),
    );
  }

  Widget momentCircle() {
    return Container(
        height: 70,
        width: 70,
        margin: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: kSecondaryColor, width: 1)),
        child: CircleAvatar(
          backgroundImage: NetworkImage(
              "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80"),
        ));
  }
}
