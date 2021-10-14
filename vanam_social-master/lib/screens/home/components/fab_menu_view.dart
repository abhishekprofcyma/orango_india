import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vanam_social/screens/profile/profile_screen.dart';
import 'package:vanam_social/screens/vendor/vendor_list/vendor_zone_screen.dart';
class FabMenuView extends StatefulWidget {
  @override
  _FabMenuViewState createState() => _FabMenuViewState();
}

class _FabMenuViewState extends State<FabMenuView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.7),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            item("Vendor Zone",FaIcon(FontAwesomeIcons.storeAlt,color: Colors.white,size: 32,),(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>VendorZoneScreen()));

            }),
            SizedBox(height: 16,),
            item("    Create Post",FaIcon(FontAwesomeIcons.plus,color: Colors.white,size: 32,),(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
            }),
            SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: FloatingActionButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.close),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.15,width: MediaQuery.of(context).size.width,)
          ],
        ),
      ),
    );
  }
  Widget item(String title,Widget icon,Function() onclick){
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 16),
      child: InkWell(
        onTap: onclick,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            SizedBox(width: 16,),
            Text(title,style: Theme.of(context).textTheme.subtitle1?.copyWith(fontSize: 22,color: Colors.white,fontWeight: FontWeight.w500),)
          ],
        ),
      ),
    );
  }
}
