import 'package:clothing_store/feature/products/page/product_page.dart';
import 'package:clothing_store/feature/watchlist/page/watchlist_page.dart';
import 'package:clothing_store/feature/cart/page/cart_page.dart';
import 'package:clothing_store/feature/payment/page/checkout_page.dart';
import 'package:clothing_store/feature/payment/page/payment_result_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../feature/login/page/login_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) => _fadePageRouteBuilder(
          const LoginScreen(),
          state,
        ),
      ),
      GoRoute(
        path: '/watchlist',
        name: 'watchlist',
        pageBuilder: (context, state) => _fadePageRouteBuilder(
          const WatchlistPage(), state,
        ),
      ),
      GoRoute(
        path: '/cart',
        name: 'cart',
        pageBuilder: (context, state) => _fadePageRouteBuilder(
          const CartPage(), state,
        ),
      ),
      GoRoute(
        path: '/checkout',
        name: 'checkout',
        pageBuilder: (context, state) => _fadePageRouteBuilder(
          const CheckoutPage(), state,
        ),
      ),
      GoRoute(
        path: '/payment-result',
        name: 'payment-result',
        pageBuilder: (context, state) => _fadePageRouteBuilder(
          const PaymentResultPage(), state,
        ),
      ),
      GoRoute(
        path: '/products',
        name: 'products',
        pageBuilder: (context, state) => _fadePageRouteBuilder(
          const ProductListScreen(),
          state,
        ),
      ),
    ],
  );

  static Page<dynamic> _fadePageRouteBuilder(
      Widget child,
      GoRouterState state, {
        int transitionDuration = 300,
      }) {
    return CustomTransitionPage<dynamic>(
      key: state.pageKey,
      child: child,
      transitionDuration: Duration(
        milliseconds: transitionDuration,
      ),
      reverseTransitionDuration: Duration(
        milliseconds: transitionDuration,
      ),
      transitionsBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
          ) {
        final Animatable<double> tween =
        Tween<double>(begin: 0.0, end: 1.0).chain(
          CurveTween(curve: Curves.easeInOut),
        );

        return FadeTransition(
          opacity: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

final RouteObserver<PageRoute<dynamic>> routeObserver =
RouteObserver<PageRoute<dynamic>>();