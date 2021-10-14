import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vanam_social/data/remote/model/vendor/VendorCategoryListResponse.dart';
import 'package:vanam_social/data/remote/model/vendor/VendorListResponse.dart';
import 'package:vanam_social/screens/home/home/component/home_tab_post_view.dart';

import '../../../constants.dart';

class VendorServiceDetailsScreen extends StatefulWidget {
  final VendorItem vendor;
  final Category vendorCategory;

  const VendorServiceDetailsScreen({Key? key,required this.vendor,required this.vendorCategory}) : super(key: key);
  @override
  _VendorServiceDetailsScreenState createState() => _VendorServiceDetailsScreenState();
}

class _VendorServiceDetailsScreenState extends State<VendorServiceDetailsScreen> {
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
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    "${widget.vendorCategory.name}",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Color(0xff00000029),
                      spreadRadius: 6,
                      blurRadius: 7,
                      offset: Offset(0.3, 0.7))
                ]),
                child: widget.vendor.image == null ? SvgPicture.asset("assets/images/user.svg",height: 56,width: 56,): ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                      "$ImageBaseUrl${widget.vendor.image}"),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              serviceItem("ic_vendor_call","${widget.vendor.mobile}"),
              serviceItem("ic_vendor_email","${widget.vendor.email}"),
              serviceItem("ic_vendor_location","${widget.vendor.address}"),
              serviceItem("ic_vendor_time","${widget.vendor.timeStart} - ${widget.vendor.timeEnd}"),
              serviceItem("ic_vendor_close","${widget.vendor.closingDay}"),
              SizedBox(height: 16,),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16),
              //   child: Text("About",style: Theme.of(context).textTheme.headline6,),
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              //   child: Text("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita...more",
              //   overflow: TextOverflow.ellipsis,softWrap: true,),
              // ),
              SizedBox(height: 16,),

              //HomeTabPostsView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget serviceItem(String icon,String title){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            child: Stack(
              children: [
                SvgPicture.asset(
                    "assets/images/ic_chat_circle_button_bg.svg"),
                Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      "assets/images/$icon.svg",
                      color: Colors.black,
                      width: 14,
                    )),
              ],
            ),
          ),
          SizedBox(width: 8,),
          Text("$title")
        ],
      ),
    );
  }
}
