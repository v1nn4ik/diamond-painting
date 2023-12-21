import 'package:diamond_painting/utilities/build_page_with_default_transition.dart';
import 'package:diamond_painting/views/account/account_info_view.dart';
import 'package:diamond_painting/views/account/account_view.dart';
import 'package:diamond_painting/views/account/contacts_view.dart';
import 'package:diamond_painting/views/authorization/login_view.dart';
import 'package:diamond_painting/views/authorization/register_view.dart';
import 'package:diamond_painting/views/authorization/verify_email_view.dart';
import 'package:diamond_painting/views/main_wrapper.dart';
import 'package:diamond_painting/views/mosaic_view.dart';
import 'package:diamond_painting/views/new_mosaic/mosaic_color_view.dart';
import 'package:diamond_painting/views/new_mosaic/mosaic_hints_view.dart';
import 'package:diamond_painting/views/new_mosaic/photo_selection_view.dart';
import 'package:diamond_painting/views/new_mosaic/photo_upload_view.dart';
import 'package:diamond_painting/views/works_recomendations/works_rec_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  AppNavigation._();

  static String initial = '/worksRecomendations';

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
                path: '/worksRecomendations',
                name: 'WorksRecomendations',
                builder: (BuildContext context, GoRouterState state) =>
                    const WorksRecView(),
                routes: [
                  GoRoute(
                    path: 'mosaicColor',
                    name: 'mosaicColor',
                    pageBuilder: (context, state) {
                      return buildPageWithDefaultTransition(
                          context: context,
                          state: state,
                          child: const MosaicColorView());
                    },
                  ),
                  GoRoute(
                    path: 'mosaicHints',
                    name: 'mosaicHints',
                    pageBuilder: (context, state) {
                      return buildPageWithDefaultTransition(
                          context: context,
                          state: state,
                          child: const MosaicHintsView());
                    },
                  ),
                  GoRoute(
                    path: 'photoUpload',
                    name: 'photoUpload',
                    pageBuilder: (context, state) {
                      return buildPageWithDefaultTransition(
                          context: context,
                          state: state,
                          child: const PhotoUploadView());
                    },
                  ),
                  GoRoute(
                    path: 'photoSelection',
                    name: 'photoSelection',
                    pageBuilder: (context, state) {
                      return buildPageWithDefaultTransition(
                          context: context,
                          state: state,
                          child: const PhotoSelectionView());
                    },
                  ),
                ],
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
                    pageBuilder: (context, state) {
                      return buildPageWithDefaultTransition(
                          context: context,
                          state: state,
                          child: const AccountInfoView());
                    },
                  ),
                  GoRoute(
                    path: 'login',
                    name: 'login',
                    pageBuilder: (context, state) {
                      return buildPageWithDefaultTransition(
                          context: context,
                          state: state,
                          child: const LoginView());
                    },
                  ),
                  GoRoute(
                    path: 'register',
                    name: 'register',
                    pageBuilder: (context, state) {
                      return buildPageWithDefaultTransition(
                          context: context,
                          state: state,
                          child: const RegisterView());
                    },
                  ),
                  GoRoute(
                    path: 'verifyEmail',
                    name: 'verifyEmail',
                    pageBuilder: (context, state) {
                      return buildPageWithDefaultTransition(
                          context: context,
                          state: state,
                          child: const VerifyEmailView());
                    },
                  ),
                  GoRoute(
                    path: 'contacts',
                    name: 'contacts',
                    pageBuilder: (context, state) {
                      return buildPageWithDefaultTransition(
                          context: context,
                          state: state,
                          child: const ContactsView());
                    },
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
