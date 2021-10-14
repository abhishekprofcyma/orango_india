import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vanam_social/constants.dart';

class VanamIconView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
    child: Text("Vanam",style: Theme.of(context).textTheme.subtitle1?.copyWith(color: kSecondaryColor,fontSize: 22,fontWeight: FontWeight.bold),),);
  }
}
