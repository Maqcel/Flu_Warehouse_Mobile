import 'package:auto_route/auto_route.dart';
import 'package:flu_warehouse_mobile/extensions/extension_mixin.dart';
import 'package:flu_warehouse_mobile/l10n/l10n.dart';
import 'package:flu_warehouse_mobile/style/app_typography.dart';
import 'package:flu_warehouse_mobile/style/theme/theme.dart';
import 'package:flu_warehouse_mobile/utils/hide_keyboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

const Size _mobileMockSize = Size(390, 844);

class App extends StatelessWidget with ExtensionMixin {
  const App({
    super.key,
    required RootStackRouter appRouter,
  }) : _appRouter = appRouter;

  final RootStackRouter _appRouter;

  @override
  Widget build(BuildContext context) => _globalUnfocusKeyboard(
        context: context,
        child: ScreenUtilInit(
          designSize: _mobileMockSize,
          builder: (context, widget) => ListenableProvider<ThemeModel>(
            create: (_) => ThemeModel(),
            builder: (context, child) => MaterialApp(
              home: MaterialApp.router(
                routerDelegate: _appRouter.delegate(),
                routeInformationParser: _appRouter.defaultRouteParser(),
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                theme: _appThemeData(context),
              ),
            ),
          ),
        ),
      );

  Widget _globalUnfocusKeyboard({
    required BuildContext context,
    required Widget child,
  }) =>
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => hideKeyboard(context),
        child: child,
      );

  ThemeData _appThemeData(BuildContext context) => ThemeData(
        cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: context.getColors().primaryBlack100,
          primaryContrastingColor: context.getColors().primaryYellow100,
        ),
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: context.getColors().primaryYellow25,
          selectionColor: context.getColors().primaryYellow25,
        ),
        colorScheme: ColorScheme.light(
          primary: context.getColors().primaryYellow100,
          secondary: context.getColors().primaryGrey,
        ),
        fontFamily: AppTypography.fontFamily,
        scaffoldBackgroundColor: context.getColors().secondaryBlack100,
        textTheme: const TextTheme().apply(
          bodyColor: context.getColors(listen: false).secondaryBlack100,
          displayColor: context.getColors(listen: false).secondaryBlack100,
        ),
      );
}
