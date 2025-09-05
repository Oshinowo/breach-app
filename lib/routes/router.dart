import 'package:go_router/go_router.dart';

import '../features/auth/view/login_screen.dart';
import '../features/auth/view/signup_screen.dart';
import '../features/blog/view/categories_screen.dart';
import '../features/blog/view/view_post_screen.dart';
import '../features/bottom_navigation/view/bottom_navigation_bar.dart';
import '../features/dashboard/view/dashboard_screen.dart';
import '../features/dashboard/view/interested_posts_screen.dart';
import '../features/dashboard/view/stream_posts_screen.dart';
import '../features/home/view/home_screen.dart';
import '../features/interests/view/interests_screen.dart';
import '../features/welcome/view/welcome_screen.dart';

var router = GoRouter(
  initialLocation: BottomNavBar.home,
  routes: <RouteBase>[
    GoRoute(
      path: BottomNavBar.home,
      builder: (context, state) => const BottomNavBar(screenIndex: 0),
    ),
    GoRoute(
      path: BottomNavBar.discover,
      builder: (context, state) => const BottomNavBar(screenIndex: 1),
    ),
    GoRoute(
      path: HomeScreen.id,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: CategoriesScreen.id,
      builder: (context, state) => const CategoriesScreen(),
    ),
    GoRoute(
      path: SignupScreen.id,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: LoginScreen.id,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: WelcomeScreen.id,
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: InterestsScreen.id,
      builder: (context, state) => const InterestsScreen(),
    ),
    GoRoute(
      path: DashboardScreen.id,
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: InterestedPostsScreen.id,
      builder: (context, state) => const InterestedPostsScreen(),
    ),
    GoRoute(
      path: StreamPostsScreen.id,
      builder: (context, state) => const StreamPostsScreen(),
    ),
    GoRoute(
      path: ViewPostScreen.id,
      builder: (context, state) => const ViewPostScreen(),
    ),
  ],
);
