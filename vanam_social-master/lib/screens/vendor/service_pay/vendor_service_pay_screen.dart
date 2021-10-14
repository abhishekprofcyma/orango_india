import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:vanam_social/data/cubit/vendor/VenderCubit.dart';
import 'package:vanam_social/data/cubit/vendor/VendorState.dart';
import 'package:vanam_social/data/remote/model/setting/razorpay_order_response.dart';
import 'package:vanam_social/data/remote/model/vendor/VendorCategoryListResponse.dart';
import 'package:vanam_social/data/remote/model/vendor/VendorListResponse.dart';
import 'package:vanam_social/data/remote/model/vendor/VendorPlanListResponse.dart';
import 'package:vanam_social/screens/components/loading_view.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';
import 'package:vanam_social/screens/vendor/service/compoent/vendor_pay_list_view.dart';
import 'package:vanam_social/screens/vendor/service_details/vendor_service_details_screen.dart';

import '../../../constants.dart';
import 'package:http/http.dart' as http;

class VendorServicePayScreen extends StatefulWidget {
  final VendorItem vendor;
  final Category vendorCategory;

  const VendorServicePayScreen(
      {Key? key, required this.vendor, required this.vendorCategory})
      : super(key: key);

  @override
  _VendorServicePayScreenState createState() => _VendorServicePayScreenState();
}

class _VendorServicePayScreenState extends State<VendorServicePayScreen> {
  late VendorCubit _cubit;
  VendorPlanListResponse? vendorResponse;
  VendorSubscription? vendorSubscription;
  static const platform = const MethodChannel("razorpay_flutter");
  Razorpay? _razorpay;
  bool isLoading = false;

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _cubit = BlocProvider.of<VendorCubit>(context, listen: false);
    super.initState();
    _cubit.vendorPlanList(context, widget.vendor.id ?? 0);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay?.clear();
  }

  void openCheckout(RazorpayOrderResponse data) async {
    setState(() {
      isLoading = true;
    });
    var options = {
      'key': 'rzp_test_q0FLy0FYnKC94V',
      'amount': double.parse(vendorSubscription?.price ?? "0").toInt() * 100,
      'name': 'Vanam',
      'description': '',
      'order_id': '${data.id}',
    };

    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "Payment Successfully");
    _cubit.vendorSubScribe(context, vendorSubscription?.id ?? 0,
        vendorSubscription?.price ?? "", "razorpay");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "Payment failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "Payment Successfully");
    _cubit.vendorSubScribe(context, vendorSubscription?.id ?? 0,
        vendorSubscription?.price ?? "", "wallet");
  }

  Future<dynamic> createOrder() async {
    setState(() {
      isLoading = true;
    });
    var mapHeader = new Map<String, String>();
    mapHeader['Authorization'] = "Basic cnpwX3Rlc3RfcTBGTHkwRlluS0M5NFY6MlFTb2t6SUVQbjgwc1c2aUlJQ2N6RDd2";
    mapHeader['Accept'] = "application/json";
    mapHeader['Content-Type'] = "application/x-www-form-urlencoded";
    var map = new Map<String, String>();
    map['amount'] = "${double.parse(vendorSubscription?.price ?? "0.0").toInt() * 100}";
    map['currency'] = "INR";
    map['receipt'] = "receipt1";
    print("map $map");
    var response = await http.post(Uri.https("api.razorpay.com", "/v1/orders"),
        headers: mapHeader, body: map);
    print("...." + response.body);
    if (response.statusCode == 200) {
      RazorpayOrderResponse data =
          RazorpayOrderResponse.fromJson(json.decode(response.body));
      openCheckout(data);
    }
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VendorCubit, VendorState>(builder: (context, state) {
      return Stack(
        children: [
          Scaffold(
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
              child: Column(
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network("$ImageBaseUrl${widget.vendor.image}"),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 46,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: vendorResponse?.data?.vendor?.data?[0]
                            .vendorSubscription?.length ??
                            0,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          VendorSubscription? subscription = vendorResponse
                              ?.data?.vendor?.data?[0].vendorSubscription?[index];
                          return InkWell(
                            onTap: () {
                              setState(() {
                                vendorSubscription = subscription;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.all(6),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                      color: vendorSubscription != subscription
                                          ? Color(0xffFFCC00)
                                          : Colors.transparent,
                                      width: 1),
                                  gradient: vendorSubscription == subscription
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
                                    "${subscription?.plan?.name}",
                                    style: Theme.of(context).textTheme.subtitle2,
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price: ₹${vendorSubscription?.price ?? ""}",
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Features",
                          style: Theme.of(context).textTheme.subtitle1,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Html(data: vendorSubscription?.features ?? ""),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: PrimaryButton(
                            text: "Subscribe",
                            press: () {
                              createOrder();
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          if(isLoading)Center(child: LoadingView(),),
        ],
      );
    }, listener: (context, state) {
      if (state is VendorPlanListLoaded) {
        vendorResponse = state.response;
        vendorSubscription =
            vendorResponse?.data?.vendor?.data?[0].vendorSubscription?[0];
        setState(() {});
      }else if(state is VendorSubscribeLoaded){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>VendorServiceDetailsScreen(vendorCategory: widget.vendorCategory,vendor: widget.vendor,)));
      }
    });
  }
}
