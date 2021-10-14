import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconButtonVerticalView extends StatefulWidget {
  final String icon;
  final String title;
  final Function() onClick;
  final bool isCircularBg;

  const IconButtonVerticalView({Key? key,required this.icon,required this.title,required this.onClick, this.isCircularBg = false}) : super(key: key);
  @override
  _IconButtonVerticalViewState createState() => _IconButtonVerticalViewState();
}

class _IconButtonVerticalViewState extends State<IconButtonVerticalView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.isCircularBg ? Container(
              width: 46,
              height: 46,
              child: Stack(
                children: [
                  SvgPicture.asset("assets/images/ic_chat_circle_button_bg.svg",width: 46,height: 46,),
                  Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        "assets/images/${widget.icon}.svg",
                        color: Colors.black,
                        width: 18,
                      )),
                ],
              ),
            ):SvgPicture.asset("assets/images/${widget.icon}.svg"),
            SizedBox(height: 4,),
            Text("${widget.title}",style: Theme.of(context).textTheme.subtitle2,)
          ],
        ),
      ),
    );
  }
}
