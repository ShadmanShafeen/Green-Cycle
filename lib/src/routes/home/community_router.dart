import 'package:go_router/go_router.dart';
import 'package:green_cycle/src/community/my_community_view/community_chat.dart';

import '../../community/community_calendar.dart';
import '../../community/community_explore.dart';
import '../../community/explore_community/communities_nearby.dart';
import '../../community/my_community_view/my_community.dart';
import '../../widgets/transitions.dart';

final communityRouter = GoRoute(
  path: 'community-explore',
  name: 'community-explore',
  pageBuilder: (context, state) {
    return returnCustomTransitionPage(
      child: CommunityExplore(),
      context: context,
      type: PageTransitionType.bottomToTop,
    );
  },
  routes: [
    GoRoute(
      path: "explore-communities",
      name: "explore-communities",
      pageBuilder: (context, state) {
        return returnCustomTransitionPage(
          child: const CommunitiesNearby(),
          context: context,
          type: PageTransitionType.rightToLeft,
        );
      },
    ),
    GoRoute(
      path: 'my_com',
      name: 'my_com',
      builder: (context, state) => MyCommunity(),
      pageBuilder: (context, state) {
        return returnCustomTransitionPage(
          child: MyCommunity(),
          context: context,
          type: PageTransitionType.rightToLeft,
        );
      },
    ),
    GoRoute(
      path: "com-chat",
      name: "com-chat",
      pageBuilder: (context, state) {
        return returnCustomTransitionPage(
          child: const CommunityChat(),
          context: context,
          type: PageTransitionType.bottomToTop,
        );
      },
    ),
    GoRoute(
      path: "community-calender",
      name: "community-calender",
      pageBuilder: (context, state) {
        return returnCustomTransitionPage(
          child: const CommunityCalendar(),
          context: context,
          type: PageTransitionType.bottomToTop,
        );
      },
    ),
  ],
);
