import 'dart:developer';

import 'package:flutter/material.dart';

List<Route?> routeStack = [];

class AppNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    routeStack.add(route);
    log('didPush: ${previousRoute?.settings.name} => ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    routeStack.remove(route);
    log('didPop: ${route.settings.name} => ${previousRoute?.settings.name}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    routeStack.remove(route);
    log('didPush: ${previousRoute?.settings.name} => ${route.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    final index = routeStack.indexOf(oldRoute);
    routeStack[index] = newRoute;
    log('didPush: ${oldRoute?.settings.name} => ${newRoute?.settings.name}');
  }

  bool isRoutePresent(String routeName) {
    return routeStack.any((route) => route!.settings.name == routeName);
  }
}
