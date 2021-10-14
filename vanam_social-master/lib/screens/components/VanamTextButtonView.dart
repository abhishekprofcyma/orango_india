import 'package:flutter/material.dart';

class VanamTextButtonView extends StatefulWidget {
  final String title;
  final Function() onClick;
  final Color textColor;

  const VanamTextButtonView({Key? key,required this.title,required this.onClick, this.textColor = Colors.black}) : super(key: key);
  @override
  _VanamTextButtonViewState createState() => _VanamTextButtonViewState();
}

class _VanamTextButtonViewState extends State<VanamTextButtonView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        child: Text(widget.title,style: Theme.of(context).textTheme.subtitle2?.copyWith(color: widget.textColor),),
      ),
    );
  }
}
