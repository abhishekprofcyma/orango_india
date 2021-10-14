import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vanam_social/data/remote/model/moment/MomentListResponse.dart';
import 'package:video_player/video_player.dart';
import 'dart:math' as math;

import '../../constants.dart';


class MomentPreview extends StatefulWidget {
  final int currentIndex;
  final Map<String?, List<MomentItem>> allMoments;

  const MomentPreview({Key? key,required this.currentIndex,required this.allMoments}) : super(key: key);


  @override
  _MomentPreviewState createState() => _MomentPreviewState();
}

class _MomentPreviewState extends State<MomentPreview> with SingleTickerProviderStateMixin{
  PageController? _pageParentController;
  AnimationController? _animController;
  double _currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageParentController = PageController(initialPage: widget.currentIndex);
    _animController = AnimationController(vsync: this);
    setState(() {
      _currentPage = widget.currentIndex.toDouble();
    });
    _pageParentController!.addListener(() {
      setState(() {
        _currentPage = _pageParentController!.page! ;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:widget.allMoments.values.length != 0?  PageView.builder(
        controller: _pageParentController,
        itemCount: widget.allMoments.values.length,
        itemBuilder: (context,index){
          return MomentSingleView(moments: widget.allMoments.values.elementAt(index),onPageChanged: (page){
            print("call next page $_currentPage");
            setState(() {
              _currentPage = _currentPage+1;
            });
            setState(() {
            });
          },);
          //return MomentSingleView(moments: widget.allMoments.values.elementAt(index));

        },
      ):Container(),
    );
  }


}

class MomentSingleView extends StatefulWidget {
  final List<MomentItem> moments;
  Function(int page) onPageChanged;

  MomentSingleView({Key? key,required this.moments,required this.onPageChanged }) : super(key: key);
  @override
  _MomentSingleViewState createState() => _MomentSingleViewState();
}

class _MomentSingleViewState extends State<MomentSingleView> with SingleTickerProviderStateMixin {
  PageController? _pageController;
  AnimationController? _animController;
  VideoPlayerController? _videoController;
  int _currentIndex = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    _animController = AnimationController(vsync: this);

    final MomentItem firstStory = widget.moments.first;
    _loadStory(story: firstStory, animateToPage: false,index: 0);

    _animController!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController?.stop();
        _animController?.reset();
        try {
          setState(() {
            if (_currentIndex + 1 < widget.moments.length) {
              _currentIndex += 1;
              _loadStory(story: widget.moments[_currentIndex], index: _currentIndex);
            } else {
              Navigator.of(context).pop();
              _currentIndex = 0;
              widget.onPageChanged(0);
              _loadStory(story: widget.moments[_currentIndex], index: 0);
            }
          });
        }catch(e){}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final MomentItem story = widget.moments[_currentIndex];

    return Dismissible(
      direction: DismissDirection.down,
      key: const Key('key'),
      onDismissed: (_) => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        body: GestureDetector(
          onTapDown: (details) => _onTapDown(details, story),
          onLongPressStart: (details){
            _animController?.stop();
          },
          onLongPressEnd: (details){
            _animController?.value = _animController!.value;
            _animController?.forward();
          },
          child:  story != null ? Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.moments.length,
                itemBuilder: (context, i) {
                  var item = widget.moments[i];
                  print("urls $i ${item.url}");
                  if(!item.url!.contains(".mp4")){
                    return CachedNetworkImage(
                      imageUrl: "${ImageBaseUrl}${item.url}",
                      fit: BoxFit.cover,
                    );
                  }else if(item.url!.contains(".mp4")){
                    if (_videoController != null &&
                        _videoController!.value.isInitialized) {
                      return FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          width: _videoController!.value.size.width,
                          height: 210,
                          child: VideoPlayer(_videoController!),
                        ),
                      );
                    }
                  }
                  return const SizedBox.shrink();
                },
              ),
              Positioned(
                  top: 40,
                  left: 10,
                  right: 10,
                  child: Column(
                    children: [
                      Row(
                        children: widget.moments.asMap()
                            .map((i, e) {
                          return MapEntry(
                            i,
                            AnimatedBar(
                              animController: _animController!,
                              position: i,
                              currentIndex: _currentIndex,
                            ),
                          );
                        })
                            .values
                            .toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 1.5,
                          vertical: 10.0,
                        ),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 30.0,
                                color: Colors.white,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.grey[300],
                              backgroundImage: CachedNetworkImageProvider("$ImageBaseUrl${story.friend?.user?.image??""}"),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Text(
                                story.friend?.user?.name??"",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),

              // Image.network(
              //   "${ImageBaseUrl}${widget.moment.url}",
              //   height: MediaQuery.of(context).size.height,
              // ),

            ],
          ):Container(),
        ),
      ),
    );

  }
  @override
  void dispose() {
    _pageController?.dispose();
    _animController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }
  void _loadStory({MomentItem? story, bool animateToPage = true, int index = 0}) {
    _animController?.stop();
    _animController?.reset();
    if(!story!.url!.contains(".mp4")){
      _animController?.duration = Duration(seconds: 5);
      _animController?.forward();
    }else if(story.url!.contains(".mp4")){
      _videoController = null;
      _videoController?.dispose();
      _videoController = VideoPlayerController.network("$ImageBaseUrl${story.url!}")
        ..initialize().then((_) {
          setState(() {});
          if (_videoController!.value.isInitialized) {
            _animController?.duration = _videoController!.value.duration;
            _videoController?.play();
            _animController?.forward();
          }
        });
    }
    if (animateToPage) {
      _pageController?.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onTapDown(TapDownDetails details, MomentItem? story) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      setState(() {
        if (_currentIndex - 1 >= 0) {
          _currentIndex -= 1;
          _loadStory(story: widget.moments[_currentIndex],index: _currentIndex);
        }
      });
    } else if (dx > 2 * screenWidth / 3) {
      setState(() {
        if (_currentIndex + 1 < widget.moments.length) {
          _currentIndex += 1;
          _loadStory(story: widget.moments[_currentIndex],index: _currentIndex);
        } else {
          widget.onPageChanged(0);
          // _currentIndex = 0;
          // _loadStory(story: widget.moments[_currentIndex],index: _currentIndex);
        }
      });
    } else {
      if (story!.url!.contains(".mp4")) {
        if (_videoController!.value.isPlaying) {
          _videoController?.pause();
          _animController?.stop();
        } else {
          _videoController?.play();
          _animController?.forward();
        }
      }
    }
  }
}


class AnimatedBar extends StatelessWidget {
  final AnimationController animController;
  final int position;
  final int currentIndex;

  const AnimatedBar(
      {Key? key,
        required this.animController,
        required this.position,
        required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: <Widget>[
                _buildContainer(
                  double.infinity,
                  position < currentIndex
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
                position == currentIndex
                    ? AnimatedBuilder(
                  animation: animController,
                  builder: (context, child) {
                    return _buildContainer(
                      constraints.maxWidth * animController.value,
                      Colors.white,
                    );
                  },
                )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 5.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black26,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}
