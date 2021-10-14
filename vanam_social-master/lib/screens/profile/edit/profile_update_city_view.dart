import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vanam_social/data/cubit/profile/profile_cubit.dart';
import 'package:vanam_social/data/cubit/profile/profile_state.dart';
import 'package:vanam_social/data/remote/model/profile/user_details_response.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';

class ProfileCityUpdateView extends StatefulWidget {
  final UserDetailResponse userDetails;
  final bool editCurrentCity;
  const ProfileCityUpdateView({Key? key,required this.userDetails,required this.editCurrentCity}) : super(key: key);
  @override
  _ProfileCityUpdateViewState createState() => _ProfileCityUpdateViewState();
}

class _ProfileCityUpdateViewState extends State<ProfileCityUpdateView> {
  TextEditingController fieldController = TextEditingController();
  ProfileCubit? _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = BlocProvider.of<ProfileCubit>(context, listen: false);
    if(widget.editCurrentCity) {
      fieldController.text =
          widget.userDetails.data?.userBasicInfo?.currentCity ?? "";
    }else{
      fieldController.text =
          widget.userDetails.data?.userBasicInfo?.homeCity ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Edit ${widget.editCurrentCity ? "City": "Home City"}",
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
            TextFormField(
              controller: fieldController,
              decoration: InputDecoration(
                hintText: "Add current ${widget.editCurrentCity ? "City": "Home City"} (required)",
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 20),
                prefixIcon: Icon(Icons.home_filled),
              ),
              style: TextStyle(fontSize: 22),
            ),
            Spacer(),
            BlocConsumer<ProfileCubit,ProfileState>(builder: (context,state){
              return Container();
            }, listener: (context,state){
              if(state is ProfileUpdateCompleted){
                Navigator.pop(context);
               Fluttertoast.showToast(msg: "Address updated");
              }
            }),
            PrimaryButton(text: 'SAVE',press: (){
              _bloc?.profileUpdateDetails(context,
                  !widget.editCurrentCity? fieldController.text: widget.userDetails.data?.userBasicInfo?.homeCity??"",
                  widget.editCurrentCity? fieldController.text: widget.userDetails.data?.userBasicInfo?.currentCity??"",
                  widget.userDetails.data?.userBasicInfo?.gender??"",
                  widget.userDetails.data?.userBasicInfo?.language??"",
                  widget.userDetails.data?.userBasicInfo?.interests??"",
                  widget.userDetails.data?.userBasicInfo?.relationship??"",
                  widget.userDetails.data?.userBasicInfo?.dob??"");
            },),
          ],
        ),
      ),
    );
  }
}
