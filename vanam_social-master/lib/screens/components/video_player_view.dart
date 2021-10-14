import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VanamVideoPlayerView extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final bool autoplay;

  const VanamVideoPlayerView({Key? key,required this.videoPlayerController,required this.looping,required this.autoplay}) : super(key: key);


  @override
  _VanamVideoPlayerViewState createState() => _VanamVideoPlayerViewState();
}

class _VanamVideoPlayerViewState extends State<VanamVideoPlayerView> {

   VideoPlayerController? videoPlayerController;
   bool? looping;
   bool? autoplay;
   ChewieController? _chewieController;


  @override
  void initState() {
    super.initState();

    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio:5/8,
      autoInitialize: true,
      autoPlay: widget.autoplay,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }


   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body:  Padding(
         padding: const EdgeInsets.all(8.0),
         child: VisibilityDetector(
           key: Key("unique key"),
          onVisibilityChanged: (VisibilityInfo info){
            var visiblePercentage = info.visibleFraction * 100;
            // if(info.visibleFraction == 0){
            //   videoPlayerController?.pause();
            //   _chewieController?.pause();
            // }
            // else{
            //   videoPlayerController?.play();
            // }
            if(visiblePercentage != 100.0){
              videoPlayerController?.pause();
              _chewieController?.pause();
            }
            else{
              videoPlayerController?.play();
            }
          }, child: Chewie(
           controller: _chewieController!,
         ),
         ),

       ),
     );
   }

   @override
   void dispose() {
     super.dispose();
     videoPlayerController?.pause();
     _chewieController?.pause();
     _chewieController?.dispose();
   }
}

