import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanam_social/data/cubit/vendor/VenderCubit.dart';
import 'package:vanam_social/data/cubit/vendor/VendorState.dart';
import 'package:vanam_social/data/remote/model/vendor/VendorCategoryListResponse.dart';
import 'package:vanam_social/data/remote/model/vendor/VendorListResponse.dart';
import 'package:vanam_social/screens/home/components/drawer_view.dart';
import 'package:vanam_social/screens/home/components/vanam_app_bar_view.dart';
import 'package:vanam_social/screens/home/components/vanam_bottom_navigation_bar_view.dart';
import 'package:vanam_social/screens/home/home_screen.dart';
import 'package:vanam_social/screens/vendor/vendor_list/component/vendor_list_view.dart';

class VendorZoneScreen extends StatefulWidget {
  @override
  _VendorZoneScreenState createState() => _VendorZoneScreenState();
}

class _VendorZoneScreenState extends State<VendorZoneScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int selected = -1;
  late VendorCubit _cubit;
  VendorCategoryListResponse? categoryList;
  VendorListResponse? vendorList;
  Category? vendorCategory;

  @override
  void initState() {
    _cubit = BlocProvider.of<VendorCubit>(context, listen: false);
    super.initState();
    _cubit.vendorCategory(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Theme.of(context).backgroundColor,
      body: BlocConsumer<VendorCubit, VendorState>(builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              VanamAppBarView(onMenuTap: () {
                _key.currentState!.openDrawer();
              }),
              Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    "Vendor Zone",
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.left,
                  )),
              Container(
                height: 46,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: categoryList?.data.category.length ?? 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      Category? category = categoryList?.data.category[index];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selected = category?.id ?? 0;
                            vendorCategory = category;
                          });
                          _cubit.vendorList(context, category?.id ?? 0);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                  color: selected != category?.id
                                      ? Color(0xffFFCC00)
                                      : Colors.transparent,
                                  width: 1),
                              gradient: selected == category?.id
                                  ? LinearGradient(
                                      colors: [
                                        Color(0xffFFCC00),
                                        Color(0xffFFEC3B)
                                      ],
                                      begin: FractionalOffset.topCenter,
                                      end: FractionalOffset.bottomCenter,
                                      stops: [0.0, 1.0],
                                      tileMode: TileMode.repeated)
                                  : null,
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xff000000).withOpacity(0.15),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0.3, 0.7))
                              ]),
                          child: Center(
                              child: Text(
                            "${category?.name}",
                            style: Theme.of(context).textTheme.subtitle2,
                            textAlign: TextAlign.center,
                          )),
                        ),
                      );
                    }),
              ),
              vendorCategory != null
                  ? VendorListView(vendorList, vendorCategory!)
                  : Expanded(child: Center(child: Text("Vendor list is empty",style: Theme.of(context).textTheme.headline6,),))
            ],
          ),
        );
      }, listener: (context, state) {
        if (state is VendorCategoryLoaded) {
          categoryList = state.response;
          vendorCategory = state.response.data.category.first;
          _cubit.vendorList(context, vendorCategory?.id??0);
        } else if (state is VendorListLoaded) {
          vendorList = state.response;
        }
      }),
      drawer: DrawerView(),
      bottomNavigationBar: VanamBottomNavigationBarView(
        onClick: (index) {
          print("HomeScreen index $index");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        index: index,
                      )));
        },
        index: 0,
      ),
    );
  }
}
