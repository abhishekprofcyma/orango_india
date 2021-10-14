import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:organo_india/model/address/country_model.dart';
import 'package:organo_india/screens/register/register_view.dart';
import 'package:organo_india/screens/widgets/circle_view.dart';
import 'package:organo_india/repo.dart';

import '../../constants.dart';

class AddressAddView extends StatefulWidget {
  @override
  _AddressAddViewState createState() => _AddressAddViewState();
}

class _AddressAddViewState extends State<AddressAddView> {
  String dropdownValue = "India";
  List<String> _country = ['India', 'Bangladesh'];
  Repo repo = Repo();
  List<CountryModelDataCountry?>? countryList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    repo.getCountry(context, Map()).then((value) {
      countryList?.addAll(value.data!.country!);
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int listSize = 1;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 56 + 36),
        child: Container(
          color: kSecondaryColor,
          padding: const EdgeInsets.only(top: 26, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.menu,
                    color: Colors.white,
                  )),
              CircleView(
                radius: 36,
                color: Color(0xffB9E1C0),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset("assets/icons/location.svg"),
                  SizedBox(
                    width: 8,
                  ),
                  Text("Choose Current Location")
                ],
              ),
              ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: 1,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 0),
                          decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                    color: Color(0xff919191), width: 1),
                              ),
                              color: Colors.white),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "Sr no.",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Color(0xff646464),
                                    decorationStyle: TextDecorationStyle.wavy)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 0),
                          decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                    color: Color(0xff919191), width: 1),
                              ),
                              color: Colors.white),

                          child: Align(
                            alignment: Alignment.topLeft,
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: _country.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: TextStyle(
                                        color: Color(0xff646464),
                                        decorationStyle:
                                            TextDecorationStyle.wavy,
                                      )),
                                );
                              }).toList(),
                            ),
                          ),
                          // child: TextFormField(
                          //   decoration: InputDecoration(
                          //       hintText: "Country",
                          //       border: InputBorder.none,
                          //       hintStyle: TextStyle(
                          //           color: Color(0xff646464),
                          //           decorationStyle: TextDecorationStyle.wavy)),
                          // ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 0),
                          decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                    color: Color(0xff919191), width: 1),
                              ),
                              color: Colors.white),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "State",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Color(0xff646464),
                                    decorationStyle: TextDecorationStyle.wavy)),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 0),
                          decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                    color: Color(0xff919191), width: 1),
                              ),
                              color: Colors.white),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintText: "Village / City",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Color(0xff646464),
                                    decorationStyle: TextDecorationStyle.wavy)),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: Text("Save"),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: kPrimaryColor),
                          ),
                        )
                      ],
                    );
                  }),
              TextButton.icon(
                  onPressed: () {
                    setState(() {
                      listSize = listSize + 1;
                    });
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/plus.svg",
                    height: 14,
                  ),
                  label: Text("Add new Address"))
            ],
          ),
        ),
      ),
    );
  }
}
