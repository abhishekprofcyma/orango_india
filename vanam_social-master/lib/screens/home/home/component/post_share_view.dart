import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:vanam_social/data/cubit/post_list/post_list_cubit.dart';
import 'package:vanam_social/data/cubit/post_list/post_list_state.dart';
import 'package:vanam_social/data/local/shared_pref.dart';
import 'package:vanam_social/data/remote/model/post/PostShareWithResponse.dart';
import 'package:vanam_social/data/remote/model/post/post_list_response.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:vanam_social/screens/components/vanam_button.dart';
import 'package:vanam_social/screens/profile/profile_screen.dart';
import '../../../../constants.dart';
import '../../../../main.dart';
import 'home_tab_post_view.dart';

class PostShareView extends StatefulWidget {
  final PostListResponseDataPostListData? post;
  final List<PostMedia>? postMedia;

  PostShareView({Key? key, this.post, this.postMedia}) : super(key: key);

  @override
  _PostShareViewState createState() => _PostShareViewState();
}

class _PostShareViewState extends State<PostShareView> {
  late PostListCubit _cubit;
  PostListResponseDataPostListData? post;
  List<PostMedia>? postMedia = [];
  String userId = "";
  String userName = "";
  String userImage = "";
  TextEditingController contentController = TextEditingController();
  List<ShareWith> shareWith = [];
  ShareWith? shareSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit = BlocProvider.of<PostListCubit>(context, listen: false);
    setState(() {
      post = widget.post;
      postMedia = widget.postMedia;
    });
    init();
    _cubit.fetchPostWithList(context);
  }

  init() async {
    String tuserId = (await getUserId())!;
    String tuserName = (await getUserName());
    String tuserImage = (await getUserImage());
    setState(() {
      userId = tuserId;
      userName = tuserName;
      userImage == tuserImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          BlocConsumer<PostListCubit, PostListState>(builder: (context, state) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage("$ImageBaseUrl"),
                    ),
                    title: Text(userName),
                    subtitle: Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 120,
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                    color: Theme.of(context).accentColor)),
                            // child: Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //     Text("Public",style: TextStyle(color: Theme.of(context).primaryColor),),
                            //     SizedBox(width: 4,),
                            //     Icon(Icons.arrow_drop_down_outlined)
                            //   ],
                            // ),
                            // child: DropdownButton<String>(
                            //   items: <String>['A', 'B', 'C', 'D'].map((String value) {
                            //     return DropdownMenuItem<String>(
                            //       value: value,
                            //       child: Text(value),
                            //     );
                            //   }).toList(),
                            //   onChanged: (_) {},
                            // ),
                            child: SizedBox(
                              height: 30,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<ShareWith>(
                                  isExpanded: true,
                                  items: shareWith.map((ShareWith value) {
                                    return DropdownMenuItem<ShareWith>(
                                      value: value,
                                      child: Text(
                                        value.name.toString(),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      shareSelected = value;
                                    });
                                  },
                                  value: shareSelected,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      controller: contentController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Say something about this...",
                      ),
                      minLines: 3,
                      maxLines: 8,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.grey)),
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage("$ImageBaseUrl${post?.user?.image}"),
                          ),
                          title: Text("${post?.user?.name}"),
                          subtitle: Text(
                              "${timeago.format(stringToDateTime(post?.createdAt ?? ""))}"),
                          trailing: Icon(Icons.more_horiz),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: Text(
                            "${post?.content}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(color: Colors.black),
                            maxLines: 4,
                            softWrap: true,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        postMedia?.length != 0
                            ? Container(
                                height: 210,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: PageIndicatorContainer(
                                  child: PageView.builder(
                                      itemCount: postMedia?.length,
                                      itemBuilder: (context, index) {
                                        if (postMedia?[index].type ==
                                            PostMediaType.Image) {
                                          return Image.network(
                                            "${ImageBaseUrl}${post?.postImage?[index]?.url}",
                                            fit: BoxFit.contain,
                                          );
                                        } else if (postMedia?[index].type ==
                                            PostMediaType.Video) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              gradient: new LinearGradient(
                                                  colors: [
                                                    kPrimaryColor
                                                        .withOpacity(0.2),
                                                    kPrimaryColor
                                                        .withOpacity(0.7),
                                                  ],
                                                  begin: const FractionalOffset(
                                                      1.0, 0.0),
                                                  end: const FractionalOffset(
                                                      0.0, 0.9),
                                                  tileMode: TileMode.clamp),
                                            ),
                                            child: Stack(
                                              children: [
                                                Center(
                                                  child: Icon(
                                                    Icons.play_circle_fill,
                                                    size: 42,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      }),
                                  length: postMedia?.length ?? 0,
                                  align: IndicatorAlign.bottom,
                                  indicatorSpace: 20.0,
                                  padding: const EdgeInsets.all(10),
                                  indicatorColor: Colors.white,
                                  indicatorSelectorColor: kPrimaryColor,
                                  shape: IndicatorShape.circle(size: 12),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: PrimaryButton(
                            text: "Share Now",
                            press: () {
                              _cubit.postShareAdd(
                                  context,
                                  post?.userId??0,
                                  post?.id??0,
                                  shareSelected?.id ?? 0,
                                  contentController.text);
                            })),
                  )
                ],
              ),
            )
          ],
        );
      }, listener: (context, state) {
        if (state is PostShareLoading ) {
          AlertDialog dialog = showLoaderDialog(context);
        } else if (state is PostShareAdded) {
          Fluttertoast.showToast(msg: "Post share successfully");
          Navigator.pop(context);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => ProfileScreen()));
        } else if (state is PostShareError) {
          Fluttertoast.showToast(msg: "Post share failed");
          Navigator.pop(context);
        } else if (state is PostShareWithCompleted) {
          //Navigator.pop(context);
          shareWith.addAll(state.postCommentResponse.data!.shareWith);
          shareSelected = state.postCommentResponse.data?.shareWith.first;
        }
      }),
    );
  }
}
