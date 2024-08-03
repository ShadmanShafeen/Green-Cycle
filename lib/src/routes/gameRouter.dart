import 'package:go_router/go_router.dart';
import 'package:green_cycle/src/widgets/transitions.dart';

import '../games/archive/archive_container.dart';
import '../games/games.dart';
import '../games/quiz/quiz_question_holder.dart';
import '../games/quiz/quiz_welcome.dart';

final gameRouter = GoRoute(
  path: "/games",
  name: "games",
  pageBuilder: (context, state) {
    return returnCustomTransitionPage(
      child: const GamesPage(),
      context: context,
      type: PageTransitionType.leftToRight,
    );
  },
  routes: [
    GoRoute(
      path: "archive",
      name: "archive",
      pageBuilder: (context, state) {
        return returnCustomTransitionPage(
          child: ArchiveContainer(),
          context: context,
          type: PageTransitionType.bottomToTop,
        );
      },
    ),
    GoRoute(
      path: "quiz",
      pageBuilder: (context, state) {
        return returnCustomTransitionPage(
          child: const QuizWelcome(),
          context: context,
          type: PageTransitionType.bottomToTop,
        );
      },
      routes: [
        GoRoute(
          path: "quiz-question/:questionCategory",
          name: "quiz-question",
          pageBuilder: (context, state) {
            return returnCustomTransitionPage(
              child: QuizQuestionHolder(
                questionCategory: state.pathParameters["questionCategory"]!,
              ),
              context: context,
              type: PageTransitionType.rightToLeft,
              durationMillis: 500,
            );
          },
        ),
      ],
    ),
  ],
);
