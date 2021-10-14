import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vanam_social/data/cubit/group/group_cubit.dart';
import 'package:vanam_social/data/cubit/group/group_state.dart';
import 'package:vanam_social/data/remote/model/group/group_image_list_response.dart';
import 'package:vanam_social/screens/home/components/vanam_image_viewer.dart';

import '../../../constants.dart';

class GroupPhotosScreen extends StatefulWidget {
  final int groupId;

  const GroupPhotosScreen({Key? key,required this.groupId}) : super(key: key);
  @override
  _GroupPhotosScreenState createState() => _GroupPhotosScreenState();
}

class _GroupPhotosScreenState extends State<GroupPhotosScreen> {
  late GroupCubit _cubit;
  GroupImageListResponse? _groupImageListResponse;
  List<GroupImageListResponseDataPostImageListData?>? imageList = [];
  ScrollController? _scrollController;
  double? _scrollPosition;


  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController?.position.pixels;
      if (_scrollController?.position.pixels ==
          _scrollController?.position.maxScrollExtent) {
        if ((_groupImageListResponse?.data?.postImageList?.lastPage ?? 0) >
            (_groupImageListResponse?.data?.postImageList?.currentPage ?? 0)) {
          _cubit.groupImageList(
              context, (_groupImageListResponse?.data?.postImageList?.currentPage ?? 1) + 1,widget.groupId);
        }
      }
    });
  }

  @override
  void initState() {
    _cubit = BlocProvider.of(context, listen: false);
    super.initState();
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollListener);
    _cubit.groupImageList(context,1,widget.groupId);
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
        title: Text(
          "Group Photos",
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(12),
          child: BlocConsumer<GroupCubit,GroupState>(builder: (context,state){
            return StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
                itemCount: imageList?.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>VanamImageViewer(url: "$ImageBaseUrl${imageList?[index]?.url}",)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        child: Image.network(
                          "$ImageBaseUrl${imageList?[index]?.url}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (index) {
                  return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
                });
          }, listener: (context,state){
            if (state is GroupImageListAdded) {
              imageList?.addAll(state.response.data!.postImageList!.data!);
              _groupImageListResponse = state.response;
              setState(() {});
            }
          }),
        ),
      ),
    );
  }
}
