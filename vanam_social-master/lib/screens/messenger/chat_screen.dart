import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vanam_social/constants.dart';
import 'package:vanam_social/data/cubit/chat/chat_cubit.dart';
import 'package:vanam_social/data/cubit/chat/chat_state.dart';
import 'package:vanam_social/data/local/shared_pref.dart';
import 'package:vanam_social/screens/components/readmore_view/read_more_view.dart';
import 'package:vanam_social/screens/components/video_player_view.dart';
import 'package:vanam_social/screens/friend/friend_screen.dart';
import 'package:vanam_social/screens/home/components/vanam_image_viewer.dart';
import 'package:video_player/video_player.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../main.dart';
import 'emoji.dart';

class ChatScreen extends StatefulWidget {
  final int friendId;
  final String friendName;
  final String friendImage;
  final bool isGroupChat;

  ChatScreen(
      {Key? key,
      required this.friendId,
      required this.friendName,
      required this.friendImage,
      this.isGroupChat = false})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin{
  late ChatCubit _cubit;
  DatabaseReference? reference;
  DatabaseReference? referenceLastActive;
  DatabaseReference? referenceFriendLastActive;
  DatabaseReference? referenceMessageCount;
  String userId = "";
  List<DataSnapshot> itemSelected = [];
  TextEditingController messageController = TextEditingController();
  List<PlatformFile>? images = [];
  StreamSubscription<Event>? refrenceListner;
  ScrollController scrollController = ScrollController();
  bool scrolledToTop = false;
  DateTime? friendActiveTime;
  int? friendMessageCount = 0;
  bool isEmojiShow = false;
  TabController? mTabController;

  @override
  void initState() {
    _cubit = BlocProvider.of<ChatCubit>(context, listen: false);
    super.initState();
    mTabController = TabController(
      length: emojis.length,
      vsync: this,
    );
    init();
  }

  init() async {
    userId = (await getUserId())!;
    var chatId = await getChatId();
    print("chatId ${chatId}");
    reference = FirebaseDatabase.instance
        .reference()
        .child("${widget.isGroupChat ? "group_message" : "message"}")
        .child(chatId);
    referenceLastActive = FirebaseDatabase.instance
        .reference()
        .child("last_active")
        .child(userId);
    referenceFriendLastActive = FirebaseDatabase.instance
        .reference()
        .child("last_active")
        .child(widget.friendId.toString());
    referenceMessageCount = FirebaseDatabase.instance
        .reference()
        .child("notification")
        .child(widget.friendId.toString())
        .child("message");
    isActive();

    //scrollController.jumpTo(scrollController.position.maxScrollExtent);
    getFriendActiveDetails();
    try {
      refrenceListner = reference?.onChildAdded.listen((event) {
        print("event add listner");
        LinkedHashMap<Object?, Object?> data = event.snapshot.value;
        if (data['sender_email'] == widget.friendId.toString()) {
          print("data--delivery status updated");
          reference?.child(event.snapshot.key ?? "").update({
            'isDelivered': true,
          });
          Future.delayed(Duration(milliseconds: 100))
              .then((_) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
            );
          });
        }
      });

      reference?.onValue.listen((event) async {
        scrollController.addListener(() {
          if (scrollController.position.atEdge) {
            setState(() {
              if (scrollController.position.pixels == 0) {
                scrolledToTop = true;
              } else {
                scrolledToTop = false;
              }
            });
          }
        });

       // LinkedHashMap<Object?, Object?> data = event.snapshot.value;
      });
    } catch (e) {}

  }

  @override
  void dispose() {
    // TODO: implement dispose
    refrenceListner?.cancel();
    reference?.onDisconnect();
    referenceMessageCount?.onDisconnect();
    referenceFriendLastActive?.onDisconnect();
    referenceLastActive?.onDisconnect();
    super.dispose();
  }

  Future<String> getChatId() async {
    if (widget.isGroupChat) {
      return "${widget.friendId}";
    } else {
      var userId = await getUserId();

      if (widget.friendId > int.parse("${userId??0}")) {
        return widget.friendId.toString() + userId!;
      } else {
        return userId! + widget.friendId.toString();
      }
    }
  }

  getFriendActiveDetails() {
    try {
      referenceFriendLastActive?.onValue.listen((event) async {
        LinkedHashMap<Object?, Object?> data = event.snapshot.value;
        data.forEach((key, value) {
          LinkedHashMap<Object?, Object?> subData = data;
          setState(() {
            try {
              print("friend active time ${subData['time']}");
              friendActiveTime = DateTime.fromMicrosecondsSinceEpoch(int.parse("${subData['time']}"));
            }catch(e){}
          });
        });
      });
    } catch (e) {}

    try {
      referenceMessageCount?.onValue.listen((event) async {
        LinkedHashMap<Object?, Object?> data = event.snapshot.value;
        data.forEach((key, value) {
          LinkedHashMap<Object?, Object?> subData =
              data as LinkedHashMap<Object?, Object?>;
          setState(() {
            friendMessageCount = int.parse("${subData['count']}");
          });
        });
      });
    } catch (e) {}
  }

  void isActive() {
    referenceLastActive?.update({
      "time": DateTime.now().toUtc().microsecondsSinceEpoch,
    });
  }

  bool isFriendActive() {
    if (friendActiveTime != null) {
      int difference = DateTime.now().difference(friendActiveTime!).inMinutes;
      print("friend last active time $difference");
      if (difference >= 5) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }

  void sendMessage(String message, String image) async {
    isActive();
    reference!.push().set({
      'text': message,
      'image': image,
      'sender_email': await getUserId(),
      'receiver_email': widget.friendId.toString(),
      'is_group_chat':widget.isGroupChat,
      'sender_name':await getUserName(),
      'sender_image':await getUserImage(),
      'isSend': true,
      'isDelivered': false,
      'isRead': false,
      'created_time': DateTime.now().toUtc().microsecondsSinceEpoch,
    });
    if (!isFriendActive()) {
      referenceMessageCount?.update({
        "count": (friendMessageCount ?? 0) + 1,
      });
      _cubit.messageNotification(
            context, widget.friendId.toString(), message);
    }
    messageController.text = "";

    print("scroll to down");

    Future.delayed(Duration(milliseconds: 100))
        .then((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    });

  }

  void deleteSelectedMessage() {
    print("item delete");
    itemSelected.forEach((element) {
      print(element.key);
      reference?.child(element.key.toString()).remove();
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "${itemSelected.length == 0 ? "Message" : "Messages"} deleted")));
    setState(() {
      itemSelected = [];
    });
  }

  void copySelectedMessage() {
    String selectedMessageString = "";
    itemSelected.forEach((element) {
      selectedMessageString =
          selectedMessageString + " " + element.value['text'];
    });
    print("copied ${selectedMessageString}");
    Clipboard.setData(ClipboardData(text: selectedMessageString));
    setState(() {
      itemSelected = [];
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Text copied to clipboard')));
  }

  Future<FilePickerResult?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.media,
    );

    if (result != null) {
      setState(() {
        images!.addAll(result.files);
      });
      PlatformFile file = result.files.first;

      return result;
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 56 + 56),
        child: Container(
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.symmetric(
              horizontal: 12, vertical: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back)),
              SizedBox(
                width: 8,
              ),
              if(itemSelected.isEmpty) Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FriendScreen(friendId: widget.friendId)));
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                        NetworkImage("$ImageBaseUrl${widget.friendImage}"),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                          child: Text(
                            "${widget.friendName}",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(fontWeight: FontWeight.w500),
                          )),
                    ],
                  ),
                ),
              ),
              if(itemSelected.isNotEmpty)...[
                Expanded(child: Text("${itemSelected.length} Message Selected")),
                IconButton(
                    onPressed: () {
                      deleteSelectedMessage();
                    },
                    icon: Icon(Icons.delete)),
                IconButton(
                    onPressed: () {
                      copySelectedMessage();
                    },
                    icon: Icon(Icons.copy)),
              ]

              // IconButton(
              //     onPressed: () {},
              //     icon: Stack(
              //       children: [
              //         SvgPicture.asset(
              //             "assets/images/ic_chat_circle_button_bg.svg"),
              //         Align(
              //             alignment: Alignment.center,
              //             child: SvgPicture.asset(
              //                 "assets/images/ic_chat_call.svg")),
              //       ],
              //     )),
              // IconButton(
              //     onPressed: () {},
              //     icon: Stack(
              //       children: [
              //         SvgPicture.asset(
              //             "assets/images/ic_chat_circle_button_bg.svg"),
              //         Align(
              //             alignment: Alignment.center,
              //             child: SvgPicture.asset(
              //                 "assets/images/ic_chat_video_call.svg")),
              //       ],
              //     )),
            ],
          ),
        ),
      ),
      body: BlocConsumer<ChatCubit, ChatState>(builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              reference != null
                  ? Expanded(
                      child: FirebaseAnimatedList(
                        controller: scrollController,
                          query: reference!,
                          shrinkWrap: true,
                          padding: new EdgeInsets.all(8.0),
                          physics: AlwaysScrollableScrollPhysics(),
                          reverse: false,
                          itemBuilder: (_, DataSnapshot snapshot,
                              Animation<double> animation, int x) {
                            if (snapshot == null) {
                              return Text("No Data");
                            }
                            return chatItemView(
                                snapshot,
                                animation,
                                snapshot.value['sender_email'] == userId
                                    ? true
                                    : false);
                          }),
                    )
                  : Expanded(child: Container()),
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Column(
                  children: [
                    Container(
                      height: images!.isNotEmpty ? 90 : 0,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: images!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 110,
                              padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                              child: Stack(
                                children: [
                                  VIDEO_EXTENSION_ALLOW
                                          .contains(images![index].extension!)
                                      ? Card(
                                          child: Container(
                                            width: 160,
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.play_circle_fill,
                                                  size: 32,
                                                ),
                                                Text(
                                                  "${images![index].name}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : Image.file(
                                          File(images![index].path!),
                                          height: 90,
                                        ),
                                  Positioned(
                                      top: 0,
                                      right: 0,
                                      child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              images!.remove(images![index]);
                                            });
                                          },
                                          child: Icon(Icons.close)))
                                ],
                              ),
                            );
                          }),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isEmojiShow = !isEmojiShow;
                            });
                          },
                          icon: SvgPicture.asset(
                              "assets/images/ic_chat_emoji.svg"),
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          constraints: BoxConstraints(),
                        ),
                        IconButton(
                          onPressed: () async {
                            await pickFile();
                          },
                          icon: SvgPicture.asset(
                              "assets/images/ic_chat_camera.svg"),
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          constraints: BoxConstraints(),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: messageController,
                            minLines: 1,
                            maxLines: 8,
                            decoration: InputDecoration(
                                isDense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                      color: Color(0xffFFCC00), width: 2.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(
                                    color: Color(0xffFFCC00),
                                    width: 1.0,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      if (images?.isNotEmpty ?? false) {
                                        List<File> files = [];
                                        images?.forEach((element) {
                                          files.add(File(element.path!));
                                        });
                                        if (files.isNotEmpty) {
                                          _cubit.uploadFile(context, files);
                                        }
                                      } else if (messageController
                                          .text.isNotEmpty) {
                                        sendMessage(
                                            messageController.text
                                                .toString()
                                                .trim(),
                                            "");
                                        setState(() {
                                          isEmojiShow = false;
                                        });
                                      }
                                    },
                                    icon: Stack(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/images/ic_chat_circle_button_bg.svg"),
                                        Align(
                                            alignment: Alignment.center,
                                            child: SvgPicture.asset(
                                                "assets/images/ic_chat_arrow_up.svg")),
                                      ],
                                    ))),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        )
                      ],
                    ),
                    if(isEmojiShow)emojiViews()
                  ],
                ),
              )
            ],
          ),
        );
      }, listener: (context, state) {
        if (state is ChatFileUploadCompleted) {
          setState(() {
            images = [];
          });
          sendMessage(messageController.text.toString().trim(),
              state.chatFileUploadResponse.data!.url);
        }
      }),
    );
  }



  Widget dateTimeShow() {
    return Center(
        child: Text(
      "12:45 pm",
      style: Theme.of(context)
          .textTheme
          .caption
          ?.copyWith(color: Color(0xff676767), fontWeight: FontWeight.w300),
    ));
  }

  Widget chatItemView(
    DataSnapshot snapshot,
    Animation animation,
    bool isOwnMessage,
  ) {
    return GestureDetector(
      onTap: () {
        if (itemSelected.isNotEmpty) {
          setState(() {
            if (itemSelected.contains(snapshot)) {
              itemSelected.remove(snapshot);
            } else {
              itemSelected.add(snapshot);
            }
          });
        }
      },
      onLongPress: () {
        setState(() {
          if (itemSelected.contains(snapshot)) {
            itemSelected.remove(snapshot);
          } else {
            itemSelected.add(snapshot);
          }
        });
      },
      child: Align(
        alignment: isOwnMessage ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          color: itemSelected.contains(snapshot)
              ? Colors.grey.withOpacity(0.3)
              : Colors.transparent,
          child: Row(
            mainAxisAlignment: snapshot.value['sender_email'] != userId
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                    color: isOwnMessage ? Color(0xffFFFCDF) : Color(0xffD2FFD2),
                    border: isOwnMessage
                        ? Border.all(color: Color(0xffFFCC00))
                        : Border.all(color: Color(0xff007F00)),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    if(snapshot.value['is_group_chat'] == true && snapshot.value['sender_email'] != userId)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundImage: NetworkImage("$ImageBaseUrl${snapshot.value['sender_image']}"),
                            ),
                            SizedBox(width: 8,),
                            Text("${snapshot.value['sender_name']}",style: Theme.of(context).textTheme.subtitle1,)
                          ],
                        ),
                      ),
                    snapshot.value['text'] != null &&
                            snapshot.value['text'].toString().isNotEmpty
                        ? Container(
                      alignment: snapshot.value['sender_email'] != userId ? Alignment.centerLeft : Alignment.centerRight,
                            width: snapshot.value['text'].toString().length > 20
                                ? MediaQuery.of(context).size.width - 90
                                : null,
                            // child: Text(
                            //   snapshot.value['text'],
                            child: SelectableLinkify(
                              onOpen: (link) async {
                                if (await canLaunch(link.url)) {
                                  await launch(link.url);
                                } else {
                                  throw 'Could not launch $link';
                                }
                              },
                              text: snapshot.value['text'],
                              style: TextStyle(color: Colors.black),
                              linkStyle: TextStyle(color: Colors.blue),
                            ),
                          )
                        : Container(),
                    snapshot.value['image'] != null &&
                            snapshot.value['image'].toString().isNotEmpty
                        ? snapshot.value['image'].toString().contains(".mp4")
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VanamVideoPlayerView(
                                              videoPlayerController:
                                                  VideoPlayerController.network(
                                                      "${ImageBaseUrl}${snapshot.value['image']}"),
                                              looping: false,
                                              autoplay: false)));
                                },
                                child: Container(
                                  width: 160,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.play_circle_fill,
                                        size: 32,
                                      ),
                                      Text(
                                        "${snapshot.value['image'].toString().split("/").last}",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>VanamImageViewer(url: ImageBaseUrl + snapshot.value['image'],)));
                      },
                              child: Image.network(
                                  ImageBaseUrl + snapshot.value['image'],
                                  height: 120,
                                ),
                            )
                        : Container(),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text("${timeago.format(stringToDateTimeDefault(snapshot.value['created_time']))}",style: Theme.of(context).textTheme.caption,))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget emojiViews() {
    return Container(
      height: isEmojiShow ? 280 : 0,
      child: Column(
        children: [
          Container(
            height: 46,
            child: TabBar(
                isScrollable: true,
                controller: mTabController,
                labelColor: Colors.red,
                unselectedLabelColor: Color(0xff666666),
                labelStyle: TextStyle(fontSize: 16.0),
                tabs: emojis.map((item) {
                  return Tab(
                    text: item.name,
                  );
                }).toList()),
          ),
          Expanded(
            child: TabBarView(
              controller: mTabController,
              children: emojis.map((e) {
                return GridView.builder(
                  itemCount: e.emojis.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 10),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        messageController.text =
                            messageController.text + e.emojis[index];
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          e.emojis[index],
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
