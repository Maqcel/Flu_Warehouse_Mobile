import 'package:auto_route/auto_route.dart';
import 'package:flu_warehouse_mobile/presentation/routing/app_route.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends $AppRouter {
  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: HomeRoute.page,
      path: '/',
    ),
  ];
}
