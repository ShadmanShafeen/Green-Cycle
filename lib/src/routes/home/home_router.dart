import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';
import 'package:green_cycle/src/home/home_page.dart';
import 'package:green_cycle/src/notification/notification.dart';
import 'package:green_cycle/src/routes/home/community_router.dart';
import 'package:green_cycle/src/routes/home/profile_router.dart';
import 'package:green_cycle/src/search_waste/search_waste.dart';
import 'package:green_cycle/src/widgets/transitions.dart';
import 'package:location/location.dart';

import '../../../main.dart';
import '../../Locate_Vendor/map.dart';
import '../../community/community_calendar.dart';
import '../../object_recognition/camera_control.dart';
import '../../object_recognition/image_preview.dart';
import '../../voucher_redemption/voucher_page.dart';
import '../../waste_item_listing/main_list_container.dart';

final homeRouter = GoRoute(
  path: '/home',
  builder: (context, state) => HomePage(),
  pageBuilder: (context, state) {
    return returnCustomTransitionPage(
      child: HomePage(),
      context: context,
      type: PageTransitionType.bottomToTop,
    );
  },
  routes: [
    GoRoute(
      path: "notification",
      name: "notification",
      pageBuilder: (context, state) => returnCustomTransitionPage(
        child: const NotificationContainer(),
        context: context,
        type: PageTransitionType.topToBottom,
      ),
    ),
    GoRoute(
      path: "locate-map",
      pageBuilder: (context, state) => returnCustomTransitionPage(
        child: LocateMap(
          locationData: state.extra as LocationData,
        ),
        context: context,
        type: PageTransitionType.leftToRight,
      ),
    ),
    GoRoute(
      path: "camera-control",
      name: "camera-control",
      pageBuilder: (context, state) => returnCustomTransitionPage(
        child: CameraControl(cameras: cameras),
        context: context,
        type: PageTransitionType.size,
      ),
    ),
    GoRoute(
      path: "image-preview/:imagePath",
      name: "image-preview",
      builder: (context, state) => ImagePreview(
        imagePath: state.pathParameters['imagePath']!,
        imageFile: state.extra as XFile,
      ),
    ),
    GoRoute(
      path: "waste-item-list",
      name: "waste-item-list",
      pageBuilder: (context, state) => returnCustomTransitionPage(
        child: const WasteListContainer(),
        context: context,
        type: PageTransitionType.bottomToTop,
      ),
    ),
    GoRoute(
      path: 'calendar',
      pageBuilder: (context, state) => returnCustomTransitionPage(
        child: const CommunityCalendar(),
        context: context,
        type: PageTransitionType.bottomToTop,
        durationMillis: 800,
      ),
    ),
    GoRoute(
      path: 'voucher-redemption',
      pageBuilder: (context, state) {
        return returnCustomTransitionPage(
          child: const VoucherPage(),
          context: context,
          type: PageTransitionType.bottomToTop,
          durationMillis: 800,
        );
      },
    ),
    GoRoute(
        path: 'search-waste',
        pageBuilder: (context, state) {
          final wasteType = state.extra as String; 
          return returnCustomTransitionPage(
            child: SearchWastePage(category: wasteType,),
            context: context,
            type: PageTransitionType.bottomToTop,
            durationMillis: 800,
          );
        }),
    profileRouter,
    communityRouter,
  ],
);
