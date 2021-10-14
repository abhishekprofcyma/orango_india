import 'package:flutter/material.dart';
import 'package:flutter_animator/animation/animation_preferences.dart';
import 'package:flutter_animator/animation/animator_play_states.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_animator/widgets/animator_widget.dart';
import 'package:flutter_animator/widgets/bouncing_entrances/bounce_in.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vanam_social/screens/components/vanam_button.dart';
import 'package:vanam_social/screens/vendor/vendor_list/vendor_zone_screen.dart';

class PermissionLocationView extends StatefulWidget {
  @override
  _PermissionLocationViewState createState() => _PermissionLocationViewState();
}

class _PermissionLocationViewState extends State<PermissionLocationView> {
  final GlobalKey<AnimatorWidgetState> basicAnimation =
      GlobalKey<AnimatorWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Bounce(
              child:
                  SvgPicture.asset("assets/images/ic_permission_location.svg"),
              preferences: AnimationPreferences(
                  autoPlay: AnimationPlayStates.Loop,
                  duration: Duration(seconds: 3)),
            ),
            FadeIn(
                child: SvgPicture.asset(
                    "assets/images/ic_permission_location_map.svg"),
                preferences: AnimationPreferences(
                  duration: Duration(seconds: 3),
                )),
            SizedBox(
              height: 8,
            ),
            SlideInUp(
                child: Text(
                  "Allow your location",
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
                preferences:
                    AnimationPreferences(duration: Duration(seconds: 1))),
            SlideInUp(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 46, vertical: 8),
                  child: Text(
                    "we will need your location to give you nearby services",
                    textAlign: TextAlign.center,
                  ),
                ),
                preferences:
                    AnimationPreferences(duration: Duration(seconds: 2))),
            SlideInUp(
                child: PrimaryButton(
                  text: "Allow",
                  press: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>VendorZoneScreen()));
                  },
                ),
                preferences:
                    AnimationPreferences(duration: Duration(seconds: 3)))
          ],
        ),
      ),
    );
  }
}
