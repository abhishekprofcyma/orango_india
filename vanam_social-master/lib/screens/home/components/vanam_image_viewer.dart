

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class VanamImageViewer extends StatefulWidget {
  final PlatformFile? platformFile;
  final String? url;


  const VanamImageViewer({ Key? key,  this.platformFile, this.url}) : super(key: key);


  @override
  _VanamImageViewerState createState() => _VanamImageViewerState();
}

class _VanamImageViewerState extends State<VanamImageViewer> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Dismissible(
      direction: DismissDirection.down,
      key: const Key('key'),
      onDismissed: (_) => Navigator.of(context).pop(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: CupertinoColors.black,
        appBar: AppBar(
         backgroundColor: Colors.transparent,
        ),
        body: widget.url != null ?  PhotoView(
          imageProvider: NetworkImage(widget.url!),
        ) :  Image.file(File(widget.platformFile!.path!),width: size.width,height: size.height,),
        // body: PhotoView(
        //   imageProvider: NetworkImage(""),
        // ),
      ),
    );
  }
}
