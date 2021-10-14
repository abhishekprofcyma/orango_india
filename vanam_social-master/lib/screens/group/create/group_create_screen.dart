import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vanam_social/data/cubit/group/group_cubit.dart';
import 'package:vanam_social/data/cubit/group/group_state.dart';
import 'package:vanam_social/data/remote/model/group/group_share_with_response.dart';
import 'package:vanam_social/screens/components/loading_view.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';
import 'package:vanam_social/screens/group/groups/groups_screen.dart';

import '../../../constants.dart';

class GroupCreateScreen extends StatefulWidget {
  @override
  _GroupCreateScreenState createState() => _GroupCreateScreenState();
}

class _GroupCreateScreenState extends State<GroupCreateScreen> {
  late GroupCubit _cubit;
  String name = "";
  GroupShareWithResponseDataShareWith? shareSelected;
  List<GroupShareWithResponseDataShareWith?>? shareWithList = [];
  List<PlatformFile>? images = [];

  @override
  void initState() {
    _cubit = BlocProvider.of(context, listen: false);
    super.initState();
    _cubit.fetchGroupShareWith(context);
  }

  Future<FilePickerResult?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        images!.addAll(result.files);
      });
      PlatformFile file = result.files.first;

      List<File> files = [];
      images?.forEach((element) {
        files.add(File(element.path ?? ""));
      });
      return result;
    } else {
      // User canceled the picker
    }
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Personal information",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    infoItemView("Name", "Enter group name here", () {}, false),
                    SizedBox(height: 8,),
                    dropDownCustom("Group Privacy",
                        "${shareSelected == null ? "Choose group privacy" : "${shareSelected?.name}"}",
                        () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: shareWithList?.length,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  GroupShareWithResponseDataShareWith? share =
                                      shareWithList?[index];
                                  return ListTile(
                                    leading: Container(
                                      width: 32,
                                      height: 32,
                                      child: Stack(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/images/ic_chat_circle_button_bg.svg"),
                                          Align(
                                              alignment: Alignment.center,
                                              child: SvgPicture.asset(
                                                "assets/images/ic_public.svg",
                                                color: Colors.black,
                                                width: 14,
                                              )),
                                        ],
                                      ),
                                    ),
                                    title: new Text("${share?.name}"),
                                    onTap: () {
                                      setState(() {
                                        shareSelected = share;
                                      });
                                      Navigator.pop(context);
                                    },
                                  );
                                });
                          });
                    }, true),
                    SizedBox(height: 8,),
                    dropDownCustom("Image", "Select Group Image", () {
                      pickFile();
                    }, true),
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
                    Spacer(),
                    Center(
                        child: PrimaryButton(
                            text: "Create Group",
                            press: () {
                              if (name.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Please enter group name");
                              } else if (shareSelected == null) {
                                Fluttertoast.showToast(
                                    msg: "Please select group privacy");
                              } else {
                                List<File> files = [];
                                images?.forEach((element) {
                                  files.add(File(element.path ?? ""));
                                });
                                _cubit.groupAdd(context, name,
                                    shareSelected?.id ?? 0, files);
                              }
                            })),
                    SizedBox(
                      height: 16,
                    )
                  ],
                ),
              ),
            ),
            if (state is GroupShareWithLoading)
              Center(
                child: LoadingView(),
              ),
          ],
        );
      }, listener: (context, state) {
        if (state is GroupShareWithLoaded) {
          shareWithList?.addAll(state.response.data!.shareWith!);
        } else if (state is GroupAdded) {
          Fluttertoast.showToast(msg: "Group created successfully");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => GroupsScreen()));
        }
      }),
    );
  }

  Widget bottomSheet() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: Container(
            width: 32,
            height: 32,
            child: Stack(
              children: [
                SvgPicture.asset("assets/images/ic_chat_circle_button_bg.svg"),
                Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      "assets/images/ic_public.svg",
                      color: Colors.black,
                      width: 14,
                    )),
              ],
            ),
          ),
          title: new Text('Public'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Container(
            width: 32,
            height: 32,
            child: Stack(
              children: [
                SvgPicture.asset("assets/images/ic_chat_circle_button_bg.svg"),
                Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      "assets/images/ic_private.svg",
                      color: Colors.black,
                      width: 14,
                    )),
              ],
            ),
          ),
          title: new Text('Private'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget dropDownCustom(
      String title, String hint, Function() onClick, isDisable) {
    return Container(

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
            child: Text(
              title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          InkWell(
            onTap: onClick,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Color(0xffFFCC00)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("$hint",style: TextStyle(color: Color(0xffBEBEBE),fontSize: 16,),),
                  Icon(Icons.arrow_drop_down,color: Color(0xffBEBEBE),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget infoItemView(
      String title, String hint, Function() onClick, isDisable) {
    return InkWell(
      onTap: onClick,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
              child: Text(
                title,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            TextFormField(
              enabled: !isDisable,
              onChanged: (value) {
                if (title == "Name") {
                  setState(() {
                    name = value;
                  });
                }
              },
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Color(0xffBEBEBE)),
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: Color(0xffFFCC00), width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(
                    color: Color(0xffFFCC00),
                    width: 1.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
