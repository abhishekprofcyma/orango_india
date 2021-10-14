import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vanam_social/constants.dart';
import 'package:vanam_social/data/cubit/vendor/VenderCubit.dart';
import 'package:vanam_social/data/cubit/vendor/VendorState.dart';
import 'package:vanam_social/data/remote/model/vendor/VendorCategoryListResponse.dart';
import 'package:vanam_social/data/remote/model/vendor/VendorListResponse.dart';
import 'package:vanam_social/screens/components/loading_view.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';
import 'package:vanam_social/screens/vendor/service_details/vendor_service_details_screen.dart';
import 'package:vanam_social/screens/vendor/service_pay/vendor_service_pay_screen.dart';

class VendorServiceScreen extends StatefulWidget {
  final int index;
  final VendorItem vendor;
  final Category vendorCategory;

  const VendorServiceScreen(
      {Key? key,
      required this.index,
      required this.vendor,
      required this.vendorCategory})
      : super(key: key);

  @override
  _VendorServiceScreenState createState() => _VendorServiceScreenState();
}

class _VendorServiceScreenState extends State<VendorServiceScreen> {
  late VendorCubit _cubit;
  VendorListResponse? vendorListResponse;

  @override
  void initState() {
    _cubit = BlocProvider.of<VendorCubit>(context, listen: false);
    super.initState();
    loadVendorDetails();
  }

  loadVendorDetails() {
    _cubit.vendorList(context, widget.vendorCategory.id ?? 0);
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
      body: BlocConsumer<VendorCubit,VendorState>(builder: (context, state) {
        return Stack(
          children: [
            Center(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 56, vertical: 16),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Color(0xffFFCC00)),
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      children: [
                        Hero(
                          tag: "vendor_${widget.index}",
                          child: widget.vendor.image == null ? SvgPicture.asset("assets/images/user.svg",height: 56,width: 56,): CircleAvatar(
                            backgroundImage: NetworkImage(
                                "$ImageBaseUrl${widget.vendor.image}"),
                            radius: 70,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "${widget.vendor.name}",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 4,
                        ),
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
                                    offset: Offset(0.3, 1.9),
                                    spreadRadius: 4,
                                    blurRadius: 9)
                              ]),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: Color(0xffFFCC00),
                                size: 12,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                "5",
                                style: Theme.of(context).textTheme.caption,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  if (vendorListResponse?.data?.userSubscipation?.isEmpty ==
                      true)
                    ...[
                      PrimaryButton(
                          text: "Subscribe",
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VendorServicePayScreen(
                                      vendorCategory: widget.vendorCategory,
                                      vendor: widget.vendor,
                                    )));
                          })
                    ],
                  if (vendorListResponse?.data?.userSubscipation?.isEmpty ==
                      false)
                    ...[
                      PrimaryButton(
                          text: "Connect",
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VendorServiceDetailsScreen(vendorCategory: widget.vendorCategory,vendor: widget.vendor,)));
                          })
                    ],

                ],
              ),
            ),
            if (state is VendorListLoading)
              Center(
                child: LoadingView(),
              ),
          ],
        );
      }, listener: (context, state) {
        if (state is VendorListLoaded) {
          vendorListResponse = state.response;
        }
      }),
    );
  }
}
