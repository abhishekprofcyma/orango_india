import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vanam_social/data/cubit/profile/profile_cubit.dart';
import 'package:vanam_social/data/cubit/profile/profile_state.dart';
import 'package:vanam_social/data/remote/model/profile/user_details_response.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';

import '../../../main.dart';

class ProfileUpdateIntrestView extends StatefulWidget {
  final UserDetailResponse userDetails;

  const ProfileUpdateIntrestView({Key? key, required this.userDetails})
      : super(key: key);

  @override
  _ProfileUpdateIntrestViewState createState() =>
      _ProfileUpdateIntrestViewState();
}

class _ProfileUpdateIntrestViewState extends State<ProfileUpdateIntrestView> {
  ProfileCubit? _bloc;
  List<String> intersts = [];
  TextEditingController formController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = BlocProvider.of<ProfileCubit>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Edit Interest",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: formController,
                    decoration: InputDecoration(
                      hintText: "Enter Interest",
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 20),
                      prefixIcon: Icon(Icons.golf_course),
                    ),
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        intersts.add(formController.text.toString());
                      });
                      formController.text = "";
                    },
                    child: Text("Add"))
              ],
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: intersts.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          intersts[index],
                          style: TextStyle(fontSize: 18),
                        )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                intersts.remove(intersts[index]);
                              });
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ),
                  );
                }),
            Spacer(),
            BlocConsumer<ProfileCubit, ProfileState>(builder: (context, state) {
              return Container();
            }, listener: (context, state) {
              if (state is ProfileUpdateCompleted) {
                Navigator.pop(context);
                Fluttertoast.showToast(msg: "Interest Updated");
              }
            }),
            PrimaryButton(text: "SAVE", press: (){
              _bloc?.profileUpdateDetails(context,
                  widget.userDetails.data?.userBasicInfo?.homeCity ??
                      "",
                  widget.userDetails.data?.userBasicInfo?.currentCity ??
                      "",
                  widget.userDetails.data?.userBasicInfo?.gender ?? "",
                  widget.userDetails.data?.userBasicInfo?.language ??
                      "",
                  intersts.toString().substring(1,intersts.toString().length-1),
                  widget.userDetails.data?.userBasicInfo?.relationship ??
                      "",
                  widget.userDetails.data?.userBasicInfo?.dob ?? "");
            }),
          ],
        ),
      ),
    );
  }
}
