import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vanam_social/data/cubit/moment/moment_cubit.dart';
import 'package:vanam_social/data/cubit/moment/moment_state.dart';
import 'package:vanam_social/data/local/shared_pref.dart';
import 'package:vanam_social/screens/components/video_player_view.dart';
import 'package:video_player/video_player.dart';

import '../../constants.dart';

class AddMomentsView extends StatefulWidget {
  @override
  _AddMomentsViewState createState() => _AddMomentsViewState();
}

class _AddMomentsViewState extends State<AddMomentsView> {
  List<PlatformFile>? images = [];
  TextEditingController momentController = TextEditingController();
  DatabaseReference? reference;
  MomentCubit? _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = BlocProvider.of<MomentCubit>(context, listen: false);
    init();
    pickFile();
  }

  init() async {
    var userId = await getUserId();

    reference =
        FirebaseDatabase.instance.reference().child("moments").child(userId!);
  }

  Future<FilePickerResult?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.media,
    );

    if (result != null) {
      setState(() {
        images?.addAll(result.files);
      });
      images?.addAll(result.files);
      PlatformFile file = result.files.first;

      return result;
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Add Moments",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          children: [
            (images?.isEmpty ?? false)
                ? Container()
                : IMAGE_EXTENSION_ALLOW.contains(images?.first.extension)
                ? Image.file(
              File(images?.first.path ?? ""),
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.contain,
            )
                : Center(
              child: Container(
                height: 290,
                child: Column(
                  children: [
                    Container(
                      height: 210,
                      child: VanamVideoPlayerView(
                          videoPlayerController:
                          VideoPlayerController
                              .file(File(images?.first.path??"")),
                          looping: false,
                          autoplay: false),
                    ),
                    Text(images?.first.name??"",style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
            ),
            // Positioned(
            //   top: 0,
            //   left: 0,
            //   right: 0,
            //   child: Container(
            //     height: 90,
            //     padding: const EdgeInsets.symmetric(horizontal: 16),
            //     decoration: BoxDecoration(color: Colors.black38),
            //     child: TextFormField(
            //       controller: momentController,
            //       decoration: InputDecoration(
            //         border: InputBorder.none,
            //         hintText: "Enter moments title",
            //         hintStyle: TextStyle(color: Colors.white70, fontSize: 22),
            //       ),
            //       style: TextStyle(color: Colors.white70, fontSize: 22),
            //     ),
            //   ),
            // ),
            BlocConsumer<MomentCubit, MomentState>(builder: (context, state) {
              return Container();
            }, listener: (context, state) {
              if (state is MomentAdded) {
                reference?.push().set({
                  'title': momentController.text.toString(),
                  'url': state.momentAddResponse.data?.moment ?? "",
                  'created_time': DateTime.now().toString(),
                });
                Navigator.pop(context);
                Fluttertoast.showToast(msg: "Moment added successfully");
              }
            }),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 90,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(color: Colors.black38),
                child: Row(
                  children: [
                    // IconButton(
                    //     onPressed: () {},
                    //     icon: Icon(
                    //       Icons.privacy_tip_outlined,
                    //       color: Colors.white70,
                    //     )),
                    // // Text(
                    // //   "Only Visible for Friends",
                    // //   style: TextStyle(color: Colors.white70),
                    // // ),
                    Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          List<File> files = [];
                          images?.forEach((element) {
                            files.add(File(element.path ?? ""));
                          });
                          _bloc?.momentAdd(context,files);
                        },
                        child: Text("Share"))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
