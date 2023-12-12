import 'package:diamond_painting/views/authorization/login_view.dart';
import 'package:diamond_painting/views/authorization/register_view.dart';
import 'package:diamond_painting/views/authorization/verify_email_view.dart';
import 'package:diamond_painting/views/contacts_view.dart';
import 'package:diamond_painting/views/main_wrapper.dart';
import 'package:diamond_painting/views/mosaic_view.dart';
import 'package:diamond_painting/views/account_info_view.dart';
import 'package:diamond_painting/views/my_works_view.dart';
import 'package:diamond_painting/views/account_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  AppNavigation._();

  static String initial = '/mosaic';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorMosaic =
      GlobalKey<NavigatorState>(debugLabel: 'shellMosaic');
  static final _shellNavigatorMyWorks =
      GlobalKey<NavigatorState>(debugLabel: 'shellMyWorks');
  static final _shellNavigatorAccount =
      GlobalKey<NavigatorState>(debugLabel: 'shellAccount');

  static final GoRouter router = GoRouter(
    initialLocation: initial,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapper(
            navigationShell: navigationShell,
          );
        },
        branches: <StatefulShellBranch>[
          //My works
          StatefulShellBranch(
            navigatorKey: _shellNavigatorMyWorks,
            routes: <RouteBase>[
              GoRoute(
                path: '/myWorks',
                name: 'MyWorks',
                builder: (BuildContext context, GoRouterState state) =>
                    const MyWorksView(),
              )
            ],
          ),
          //Mosaic
          StatefulShellBranch(
            navigatorKey: _shellNavigatorMosaic,
            routes: <RouteBase>[
              GoRoute(
                path: '/mosaic',
                name: 'Mosaic',
                builder: (BuildContext context, GoRouterState state) =>
                    const MosaicView(),
              )
            ],
          ),
          //Account
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAccount,
            routes: <RouteBase>[
              GoRoute(
                path: '/account',
                name: 'Account',
                builder: (BuildContext context, GoRouterState state) =>
                    const AccountView(),
                routes: [
                  GoRoute(
                    path: 'info',
                    name: 'info',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const AccountInfoView(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'login',
                    name: 'login',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const LoginView(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'register',
                    name: 'register',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const RegisterView(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'verifyEmail',
                    name: 'verifyEmail',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const VerifyEmailView(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                  GoRoute(
                    path: 'contacts',
                    name: 'contacts',
                    pageBuilder: (context, state) => CustomTransitionPage<void>(
                      key: state.pageKey,
                      child: const ContactsView(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) =>
                              FadeTransition(opacity: animation, child: child),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      )
    ],
  );
}
