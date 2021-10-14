import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vanam_social/data/cubit/profile/profile_cubit.dart';
import 'package:vanam_social/data/cubit/profile/profile_state.dart';
import 'package:vanam_social/data/remote/model/profile/user_details_response.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';

import '../../../main.dart';

class ProfileUpdateRelationShipView extends StatefulWidget {
  final UserDetailResponse userDetails;

  const ProfileUpdateRelationShipView({Key? key,required this.userDetails}) : super(key: key);

  @override
  _ProfileUpdateRelationShipViewState createState() => _ProfileUpdateRelationShipViewState();
}

class _ProfileUpdateRelationShipViewState extends State<ProfileUpdateRelationShipView> {

  ProfileCubit? _bloc;
  List<String> relationships = ["Single","Married","Other"];
  String selected = "";

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
          "Edit Relationship",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: relationships.length,
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){
                      setState(() {
                        selected = relationships[index];
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: selected == relationships[index] ? Colors.blue.withOpacity(0.6) :Colors.grey.withOpacity(0.4),
                      ),
                      child: Center(child: Text(relationships[index],style: TextStyle(color: Colors.black),)),
                    ),
                  );
                }),
            Spacer(),
            BlocConsumer<ProfileCubit,ProfileState>(builder: (context,state){
              return Container();
            }, listener: (context,state){
              if(state is ProfileUpdateCompleted){
                Navigator.pop(context);
               Fluttertoast.showToast(msg: "Relationship Updated");
              }
            }),
            PrimaryButton(text: "SAVE", press: (){
              _bloc?.profileUpdateDetails(context,
                  widget.userDetails.data?.userBasicInfo?.homeCity??"",
                  widget.userDetails.data?.userBasicInfo?.currentCity??"",
                  widget.userDetails.data?.userBasicInfo?.gender??"",
                  widget.userDetails.data?.userBasicInfo?.language??"",
                  widget.userDetails.data?.userBasicInfo?.interests??"",
                  selected.toString(),
                  widget.userDetails.data?.userBasicInfo?.dob??"");
            }),
          ],
        ),
      ),
    );
  }
}
