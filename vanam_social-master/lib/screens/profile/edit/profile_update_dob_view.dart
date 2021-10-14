import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vanam_social/data/cubit/profile/profile_cubit.dart';
import 'package:vanam_social/data/cubit/profile/profile_state.dart';
import 'package:vanam_social/data/remote/model/profile/user_details_response.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';

import '../../../main.dart';

class ProfileUpdataDobView extends StatefulWidget {
  final UserDetailResponse userDetails;

  const ProfileUpdataDobView({Key? key,required this.userDetails}) : super(key: key);
  @override
  _ProfileUpdataDobViewState createState() => _ProfileUpdataDobViewState();
}

class _ProfileUpdataDobViewState extends State<ProfileUpdataDobView> {
  ProfileCubit? _bloc;
  DateTime currentDate = DateTime(2001);
  bool dateSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = BlocProvider.of<ProfileCubit>(context, listen: false);
    dateSelected = false;
    Timer(Duration(seconds: 0), () {
      _selectDate(context);
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1930),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        dateSelected = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Edit date of birth",
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
            ListTile(
              title: Text(dateSelected ? "${currentDate.year}-${currentDate.month}-${currentDate.day}" : widget.userDetails.data?.userBasicInfo?.dob??"Select DOB: DD/MM/YYYY"),
              onTap: (){
                _selectDate(context);
              },
            ),
            Spacer(),
            BlocConsumer<ProfileCubit,ProfileState>(builder: (context,state){
              return Container();
            }, listener: (context,state){
              if(state is ProfileUpdateCompleted){
                Navigator.pop(context);
                Fluttertoast.showToast(msg: "Date of birth Updated");
              }
            }),
            PrimaryButton(text: "SAVE", press: (){
              if(dateSelected == false){
                Fluttertoast.showToast(msg: "Please select date of birth");
              }else {
                _bloc?.profileUpdateDetails(
                    context,
                    widget.userDetails.data?.userBasicInfo?.homeCity ?? "",
                    widget.userDetails.data?.userBasicInfo?.currentCity ?? "",
                    widget.userDetails.data?.userBasicInfo?.gender ?? "",
                    widget.userDetails.data?.userBasicInfo?.language ?? "",
                    widget.userDetails.data?.userBasicInfo?.interests ?? "",
                    widget.userDetails.data?.userBasicInfo?.relationship ?? "",
                    "${currentDate.year}-${currentDate.month}-${currentDate
                        .day}");
              }
            })
          ],
        ),
      ),
    );
  }
}
