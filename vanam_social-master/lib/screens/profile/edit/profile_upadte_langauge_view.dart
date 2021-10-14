import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vanam_social/data/cubit/profile/profile_cubit.dart';
import 'package:vanam_social/data/cubit/profile/profile_state.dart';
import 'package:vanam_social/data/remote/model/profile/user_details_response.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';

import '../../../main.dart';

class ProfileUpdateLanguageView extends StatefulWidget {
  final UserDetailResponse userDetails;

  const ProfileUpdateLanguageView({Key? key, required this.userDetails})
      : super(key: key);

  @override
  _ProfileUpdateLanguageViewState createState() =>
      _ProfileUpdateLanguageViewState();
}

class _ProfileUpdateLanguageViewState extends State<ProfileUpdateLanguageView> {
  ProfileCubit? _bloc;
  List<String> languages = [];
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
          "Edit Languages",
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
                      hintText: "Enter Language",
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontSize: 20),
                      prefixIcon: Icon(Icons.golf_course),
                    ),
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      if(formController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Please enter language");
                      }else{
                        setState(() {
                          languages.add(formController.text.toString());
                        });
                        formController.text = "";
                      }
                    },
                    child: Text("Add"))
              ],
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: languages.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                      child: Row(
                        children: [
                          Expanded(child: Text(languages[index],style: TextStyle(fontSize: 18),)),
                          IconButton(onPressed: (){
                            setState(() {
                              languages.remove(languages[index]);
                            });
                          }, icon: Icon(Icons.delete))
                        ],
                      ),
                    );
                  }),
            ),
            BlocConsumer<ProfileCubit, ProfileState>(builder: (context, state) {
              return Container();
            }, listener: (context, state) {
              if (state is ProfileUpdateCompleted) {
                Navigator.pop(context);
                Fluttertoast.showToast(msg: "Language Updated");
              }
            }),
            PrimaryButton(text: "SAVE", press: (){
              if(languages.isEmpty){
                Fluttertoast.showToast(msg: "Please enter languages");
              }else {
                _bloc?.profileUpdateDetails(
                    context,
                    widget.userDetails.data?.userBasicInfo?.homeCity ??
                        "",
                    widget.userDetails.data?.userBasicInfo?.currentCity ??
                        "",
                    widget.userDetails.data?.userBasicInfo?.gender ?? "",
                    languages.toString().substring(1, languages
                        .toString()
                        .length - 1),
                    widget.userDetails.data?.userBasicInfo?.interests ??
                        "",
                    widget.userDetails.data?.userBasicInfo?.relationship ??
                        "",
                    widget.userDetails.data?.userBasicInfo?.dob ?? "");
              }
            }),
          ],
        ),
      ),
    );
  }
}
