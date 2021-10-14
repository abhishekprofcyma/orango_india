import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vanam_social/data/cubit/profile/profile_cubit.dart';
import 'package:vanam_social/data/cubit/profile/profile_state.dart';
import 'package:vanam_social/data/remote/model/profile/user_details_response.dart';

import '../../../constants.dart';

class PersonalInformationScreen extends StatefulWidget {
  @override
  _PersonalInformationScreenState createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  late ProfileCubit _cubit;
  UserDetailResponse? _profile;

  @override
  void initState() {
    _cubit = BlocProvider.of<ProfileCubit>(context,listen: false);
    super.initState();
    _cubit.profileDetails(context);
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
      body: SafeArea(
        child: BlocConsumer<ProfileCubit,ProfileState>(builder: (context,state){
          if(state is ProfileCompleted) {
          return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Personal information",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline6,
                    ),
                    infoItemView("Email address", "${state.userDetailResponse.data?.email}"),
                    infoItemView("Phone number", "${state.userDetailResponse.data?.mobileNumber}"),
                    infoItemView("Gender", "${state.userDetailResponse.data?.gender}"),

                  ],
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator(),);
        }, listener: (context,state){
        }),
      ),
    );
  }

  Widget infoItemView(String title,String hint) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
            child: Text(title,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Stack(
            children: [
              Container(
                height: 54,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xffFFCC00), Color(0xffFFEC3B)]),
                    borderRadius: BorderRadius.circular(6)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff000000).withOpacity(0.08),
                          spreadRadius: 1,
                          blurRadius: 2)
                    ]),
                child: TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: hint),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
