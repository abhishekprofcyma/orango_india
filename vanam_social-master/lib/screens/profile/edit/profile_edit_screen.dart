import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vanam_social/data/cubit/profile/profile_cubit.dart';
import 'package:vanam_social/data/cubit/profile/profile_state.dart';
import 'package:vanam_social/data/remote/model/profile/user_details_response.dart';
import 'package:vanam_social/screens/profile/edit/profile_upadte_langauge_view.dart';
import 'package:vanam_social/screens/profile/edit/profile_upadte_relationship_view.dart';
import 'package:vanam_social/screens/profile/edit/profile_update_city_view.dart';
import 'package:vanam_social/screens/profile/edit/profile_update_dob_view.dart';
import 'package:vanam_social/screens/profile/edit/profile_update_gender_view.dart';
import 'package:vanam_social/screens/profile/edit/profile_update_intrest_view.dart';

import '../../../constants.dart';

class ProfileEditScreen extends StatefulWidget {
  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
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
      body: BlocConsumer<ProfileCubit,ProfileState>(builder: (context,state){
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Edit Info",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
                          child: Text(
                            "Places Lived",
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 135,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color(0xffFFCC00),
                                    Color(0xffFFEC3B)
                                  ]),
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              margin: const EdgeInsets.only(bottom: 3),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                        Color(0xff000000).withOpacity(0.08),
                                        spreadRadius: 1,
                                        blurRadius: 2)
                                  ]),
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              ""),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${_profile?.data?.userBasicInfo?.currentCity??""}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2,
                                              ),
                                              Text(
                                                "Current City",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileCityUpdateView(userDetails: _profile!,editCurrentCity: true,)));
                                            },
                                            icon: Icon(Icons.edit))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              ""),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${_profile?.data?.userBasicInfo?.homeCity??""}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2,
                                              ),
                                              Text(
                                                "Home City",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileCityUpdateView(userDetails: _profile!,editCurrentCity: false,)));
                                            },
                                            icon: Icon(Icons.edit))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(vertical: 8),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
                  //         child: Text(
                  //           "Studied at",
                  //           style: Theme.of(context).textTheme.subtitle2,
                  //         ),
                  //       ),
                  //       Stack(
                  //         children: [
                  //           Container(
                  //             height: 120,
                  //             decoration: BoxDecoration(
                  //                 gradient: LinearGradient(colors: [
                  //                   Color(0xffFFCC00),
                  //                   Color(0xffFFEC3B)
                  //                 ]),
                  //                 borderRadius: BorderRadius.circular(6)),
                  //           ),
                  //           Container(
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: 8, vertical: 4),
                  //             margin: const EdgeInsets.only(bottom: 3),
                  //             decoration: BoxDecoration(
                  //                 border: Border.all(
                  //                   color: Colors.white,
                  //                 ),
                  //                 color: Colors.white,
                  //                 borderRadius: BorderRadius.circular(6),
                  //                 boxShadow: [
                  //                   BoxShadow(
                  //                       color:
                  //                       Color(0xff000000).withOpacity(0.08),
                  //                       spreadRadius: 1,
                  //                       blurRadius: 2)
                  //                 ]),
                  //             child: Column(
                  //               children: [
                  //                 schoolTextButton("Add Secondary School", () {}),
                  //                 schoolTextButton(
                  //                     "Add College / University", () {}),
                  //                 Padding(
                  //                   padding:
                  //                   const EdgeInsets.symmetric(vertical: 6),
                  //                   child: Row(
                  //                     children: [
                  //                       CircleAvatar(
                  //                         backgroundImage: NetworkImage(
                  //                             "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80"),
                  //                       ),
                  //                       SizedBox(
                  //                         width: 8,
                  //                       ),
                  //                       Expanded(
                  //                         child: Column(
                  //                           mainAxisAlignment:
                  //                           MainAxisAlignment.start,
                  //                           crossAxisAlignment:
                  //                           CrossAxisAlignment.start,
                  //                           children: [
                  //                             Text(
                  //                               "Tampa, Florida",
                  //                               style: Theme.of(context)
                  //                                   .textTheme
                  //                                   .subtitle2,
                  //                             ),
                  //                             Text(
                  //                               "Home City",
                  //                               style: Theme.of(context)
                  //                                   .textTheme
                  //                                   .bodyText2,
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       IconButton(
                  //                           onPressed: () {},
                  //                           icon: Icon(Icons.edit))
                  //                     ],
                  //                   ),
                  //                 )
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   padding: const EdgeInsets.symmetric(vertical: 8),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
                  //         child: Text(
                  //           "Works at",
                  //           style: Theme.of(context).textTheme.subtitle2,
                  //         ),
                  //       ),
                  //       Stack(
                  //         children: [
                  //           Container(
                  //             height: 75,
                  //             decoration: BoxDecoration(
                  //                 gradient: LinearGradient(colors: [
                  //                   Color(0xffFFCC00),
                  //                   Color(0xffFFEC3B)
                  //                 ]),
                  //                 borderRadius: BorderRadius.circular(6)),
                  //           ),
                  //           Container(
                  //             padding: const EdgeInsets.symmetric(
                  //                 horizontal: 8, vertical: 4),
                  //             margin: const EdgeInsets.only(bottom: 3),
                  //             decoration: BoxDecoration(
                  //                 border: Border.all(
                  //                   color: Colors.white,
                  //                 ),
                  //                 color: Colors.white,
                  //                 borderRadius: BorderRadius.circular(6),
                  //                 boxShadow: [
                  //                   BoxShadow(
                  //                       color:
                  //                       Color(0xff000000).withOpacity(0.08),
                  //                       spreadRadius: 1,
                  //                       blurRadius: 2)
                  //                 ]),
                  //             child: Column(
                  //               children: [
                  //                 Padding(
                  //                   padding:
                  //                   const EdgeInsets.symmetric(vertical: 6),
                  //                   child: Row(
                  //                     children: [
                  //                       CircleAvatar(
                  //                         backgroundImage: NetworkImage(
                  //                             "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=934&q=80"),
                  //                       ),
                  //                       SizedBox(
                  //                         width: 8,
                  //                       ),
                  //                       Expanded(
                  //                         child: Column(
                  //                           mainAxisAlignment:
                  //                           MainAxisAlignment.start,
                  //                           crossAxisAlignment:
                  //                           CrossAxisAlignment.start,
                  //                           children: [
                  //                             Text(
                  //                               "Tampa, Florida",
                  //                               style: Theme.of(context)
                  //                                   .textTheme
                  //                                   .subtitle2,
                  //                             ),
                  //                             Text(
                  //                               "Home City",
                  //                               style: Theme.of(context)
                  //                                   .textTheme
                  //                                   .bodyText2,
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       ),
                  //                       IconButton(
                  //                           onPressed: () {},
                  //                           icon: Icon(Icons.edit))
                  //                     ],
                  //                   ),
                  //                 )
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),


                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
                          child: Text(
                            "Basic Information",
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 197,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color(0xffFFCC00),
                                    Color(0xffFFEC3B)
                                  ]),
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              margin: const EdgeInsets.only(bottom: 3),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                        Color(0xff000000).withOpacity(0.08),
                                        spreadRadius: 1,
                                        blurRadius: 2)
                                  ]),
                              child: Column(
                                children: [
                                  basicInfoItem("ic_profile_gender", "${_profile?.data?.userBasicInfo?.gender??"Gender"}",(){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileUpdateGenderView(userDetails: _profile!,)));
                                  },true),
                                  basicInfoItem("ic_profile_dob", "${_profile?.data?.userBasicInfo?.dob??"Date of birth"}",(){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileUpdataDobView(userDetails: _profile!,)));
                                  },true),
                                  basicInfoItem("ic_profile_languages", "${_profile?.data?.userBasicInfo?.language??"Languages"}",(){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileUpdateLanguageView(userDetails: _profile!,)));
                                  },true),
                                  basicInfoItem("ic_profile_interest", "${_profile?.data?.userBasicInfo?.interests??"Interests"}",(){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileUpdateIntrestView(userDetails: _profile!,)));
                                  },true),
                                  basicInfoItem("ic_profile_relationship", "${_profile?.data?.userBasicInfo?.relationship??"Relationship"}",(){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ProfileUpdateRelationShipView(userDetails: _profile!,)));
                                  },true),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),


                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
                          child: Text(
                            "Contact",
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 89,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    Color(0xffFFCC00),
                                    Color(0xffFFEC3B)
                                  ]),
                                  borderRadius: BorderRadius.circular(6)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              margin: const EdgeInsets.only(bottom: 3),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                        Color(0xff000000).withOpacity(0.08),
                                        spreadRadius: 1,
                                        blurRadius: 2)
                                  ]),
                              child: Column(
                                children: [
                                  basicInfoItem("ic_profile_email", "${_profile?.data?.email??""}",(){},false),
                                  basicInfoItem("ic_profile_call", "${_profile?.data?.mobileNumber??""}",(){},false),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }, listener: (context,state){
        if(state is ProfileCompleted){
          _profile = state.userDetailResponse;
        }
      }),
    );
  }

  Widget basicInfoItem(String icon, String title,Function() onClick, bool isEditable,) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SvgPicture.asset("assets/images/$icon.svg"),
          SizedBox(
            width: 8,
          ),
          Expanded(
              child: Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          )),
          isEditable ? InkWell(
            onTap: onClick,
              child: Icon(Icons.edit,)):Container(height: 24,)
        ],
      ),
    );
  }

  Widget schoolTextButton(String title, Function() onClick) {
    return InkWell(
      onTap: onClick,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
