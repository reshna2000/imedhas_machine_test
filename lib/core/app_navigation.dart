import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:order_management_app/features/orders/presentation/screens/order_create_screen.dart';
import 'package:order_management_app/features/orders/presentation/screens/order_edit_screen.dart';
import 'package:order_management_app/features/orders/presentation/screens/order_listing_screen.dart';
import 'package:order_management_app/features/splash_screen/splash_screen.dart';

import '../features/authentication/presentation/screens/login_screen.dart';
import '../features/orders/data/order_model.dart';


class AppNavigator {
  // Private constructor to prevent instantiation
  AppNavigator._();

  // NavigatorKeys
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  // Path Names
  static const String splashScreen = "splashScreen";
  static const String loginScreen = "loginScreen";
  static const String orderListingScreen = "orderListingScreen";
  static const String createOrderScreen = "createOrderScreen";
  static const String editOrderScreen = "editOrderScreen";

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/$splashScreen',
    debugLogDiagnostics: true, // Helpful for debugging
    routes: [
      GoRoute(
        path: '/$splashScreen',
        name: splashScreen,
        builder: (context, state) =>  SplashScreen(),
      ),


      GoRoute(
        path: '/$loginScreen',
        name: loginScreen,
        builder: (context, state) => const UserLoginScreen(),
      ),

      GoRoute(
        path: '/$orderListingScreen',
        name: orderListingScreen,
        builder: (context, state) => const OrderListingScreen(),
      ),
      GoRoute(
        path: '/$createOrderScreen',
        name: createOrderScreen,
        builder: (context, state) => const OrderCreateScreen(),
      ),
      GoRoute(
        path: '/$editOrderScreen',
        name: editOrderScreen,
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>;
          final order = args['order'] as OrderModel;
          return OrderEditScreen(order: order);
        },
      ),

    ],
  );
}