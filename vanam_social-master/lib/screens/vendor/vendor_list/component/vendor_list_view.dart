import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vanam_social/constants.dart';
import 'package:vanam_social/data/remote/model/vendor/VendorCategoryListResponse.dart';
import 'package:vanam_social/data/remote/model/vendor/VendorListResponse.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';
import 'package:vanam_social/screens/vendor/service/vendor_service_screen.dart';

class VendorListView extends StatelessWidget {
  final VendorListResponse? vendorList;
  final Category vendorCategory;
  VendorListView(this.vendorList,  this.vendorCategory);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: vendorList?.data?.vendor?.data?.length??0,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 0.9
        ),
        itemBuilder: (BuildContext context, int index) {
          VendorItem? vendor = vendorList?.data?.vendor?.data?[index];
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xffFFCC00)),
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Column(
                  children: [
                    Hero(
                      tag: "vendor_$index",
                      child: vendor?.image == null ? SvgPicture.asset("assets/images/user.svg",height: 46,width: 46,): CircleAvatar(
                        backgroundImage: NetworkImage("$ImageBaseUrl${vendor?.image}"),
                        radius: 30,
                      ),
                    ),
                    SizedBox(height: 12,),
                    Text("${vendor?.name}",style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.w600),),
                    SizedBox(height: 4,),
                    Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        border: Border.all(color: Color(0xff00000029)),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xff00000029),
                            offset: Offset(0.3,1.9),
                            spreadRadius: 4,
                            blurRadius: 9
                          )
                        ]
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         Icon(Icons.star,color: Color(0xffFFCC00),size: 12,),
                         SizedBox(width: 4,),
                         Text("-",style: Theme.of(context).textTheme.caption,)
                       ],
                      ),
                    )
                  ],
                ),
              ),
              PrimaryButton(text: "Connect", press: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>VendorServiceScreen(index: index,vendor: vendor!,vendorCategory: vendorCategory,)));
              })
            ],
          );
        },
      ),
    );
  }
}
