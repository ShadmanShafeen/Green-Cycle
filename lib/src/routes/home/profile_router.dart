import 'package:go_router/go_router.dart';

import '../../Profile/profile.dart';
import '../../Profile/usage_history.dart';
import '../../community/community_calendar.dart';
import '../../waste_item_listing/main_list_container.dart';
import '../../widgets/transitions.dart';

final profileRouter = GoRoute(
  path: "profile",
  name: "profile",
  pageBuilder: (context, state) {
    return returnCustomTransitionPage(
      child: Profile(),
      context: context,
      type: PageTransitionType.rightToLeft,
    );
  },
  routes: [
    GoRoute(
      path: "waste_item_list",
      name: "waste_item_list",
      pageBuilder: (context, state) => returnCustomTransitionPage(
        child: const WasteListContainer(),
        context: context,
        type: PageTransitionType.rightToLeft,
      ),
    ),
    GoRoute(
      path: "community_calender",
      name: "community_calender",
      pageBuilder: (context, state) {
        return returnCustomTransitionPage(
          child: const CommunityCalendar(),
          context: context,
          type: PageTransitionType.bottomToTop,
        );
      },
    ),
    GoRoute(
      path: "usage_history",
      name: "usage_history",
      pageBuilder: (context, state) {
        return returnCustomTransitionPage(
          child: const UsageHistory(),
          context: context,
          type: PageTransitionType.rightToLeft,
        );
      },
    ),
  ],
);
