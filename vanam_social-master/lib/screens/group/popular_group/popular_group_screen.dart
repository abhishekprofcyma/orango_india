import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vanam_social/data/cubit/group/group_cubit.dart';
import 'package:vanam_social/data/cubit/group/group_state.dart';
import 'package:vanam_social/data/remote/model/group/popular_group_response.dart';
import 'package:vanam_social/screens/group/group/group_screen.dart';
import 'package:vanam_social/screens/home/components/drawer_view.dart';
import 'package:vanam_social/screens/home/components/vanam_app_bar_view.dart';

import '../../../constants.dart';

class PopularGroupScreen extends StatefulWidget {
  @override
  _PopularGroupScreenState createState() => _PopularGroupScreenState();
}

class _PopularGroupScreenState extends State<PopularGroupScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  late GroupCubit _cubit;
  PopularGroupResponse? _popularGroupResponse;
  List<PopularGroupResponseDataGroupData?>? groupList = [];
  ScrollController? _scrollController;
  double? _scrollPosition;


  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController?.position.pixels;
      if (_scrollController?.position.pixels ==
          _scrollController?.position.maxScrollExtent) {
        if ((_popularGroupResponse?.data?.group?.lastPage ?? 0) >
            (_popularGroupResponse?.data?.group?.currentPage ?? 0)) {
          _cubit.popularGroupList(context,(_popularGroupResponse?.data?.group?.currentPage ?? 1) + 1);

        }
      }
    });
  }
  @override
  void initState() {
    _cubit = BlocProvider.of(context,listen: false);
    super.initState();
    _scrollController = ScrollController();
    _scrollController?.addListener(_scrollListener);
    _cubit.popularGroupList(context, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("Popular Groups"),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: BlocConsumer<GroupCubit,GroupState>(builder: (context,state){
        return Stack(
          children: [
            SafeArea(
              child: GridView.builder(
                controller: _scrollController,
                itemCount: groupList?.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,childAspectRatio: 1.2),

                physics: AlwaysScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  PopularGroupResponseDataGroupData? popularGroup = groupList?[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>GroupScreen(groupId: popularGroup?.id??0)));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Stack(
                          children: [
                            if(popularGroup?.url != null)ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network("$ImageBaseUrl${popularGroup?.url}",fit: BoxFit.cover,width: 160,),
                            ),
                            Container(
                              width: 160,
                              height: 160,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  gradient: LinearGradient(colors: [
                                    Colors.black.withOpacity(0.0),
                                    Colors.black.withOpacity(0.25),
                                    Colors.black
                                  ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter)
                              ),
                            ),
                            Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("${popularGroup?.name}",style: TextStyle(color: Colors.white),),
                                )),

                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

          ],
        );
      }, listener: (context,state){
        if(state is GroupPopularListAdded){
          groupList?.addAll(state.response.data!.group!.data!);
          _popularGroupResponse = state.response;
          setState(() {
          });
        }
      }),
      drawer: DrawerView(),
    );
  }
}
