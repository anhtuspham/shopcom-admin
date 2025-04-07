import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_com/routes/router.dart';
import 'package:shop_com/utils/color_value_key.dart';

import 'data/config/app_config.dart';

late GoRouter system_router;

Future<void> main() async {
  system_router = genRoute();
  app_config.init().then((value) {
    try {
      system_router = genRoute();
      try {
        runApp(const MyDisplay());
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  });
}

class MyDisplay extends StatefulWidget {
  const MyDisplay({super.key});

  @override
  State<StatefulWidget> createState() => _MyDisplay();
}

class _MyDisplay extends State<MyDisplay> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scrollBehavior: const ScrollBehavior().copyWith(
          dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse},
          scrollbars: true,
          overscroll: true),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'SHOP COM',
      debugShowCheckedModeBanner: false,
      routerConfig: system_router,
      theme: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.hovered)) {
              return ColorValueKey.textColor.withOpacity(0.5);
            }
            return ColorValueKey.textColor.withOpacity(0.5);
          }),
          thumbVisibility:const WidgetStatePropertyAll(true),
          trackVisibility: const WidgetStatePropertyAll(true),
          interactive: true,
          trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.dragged) || states.contains(WidgetState.hovered)) {
              return ColorValueKey.textColor.withOpacity(0.1);
            }
            return Colors.transparent;
          }),
          trackBorderColor: WidgetStateProperty.all(Colors.transparent),
          radius: const Radius.circular(2),
          thickness: WidgetStateProperty.resolveWith<double?>((states) {
            return 10;
          }),
          minThumbLength: 48,
        ),
        textTheme: const TextTheme().copyWith(
          bodyLarge: TextStyle(color: ColorValueKey.textColor,),
          bodyMedium: TextStyle(color: ColorValueKey.textColor),
          bodySmall: TextStyle(color: ColorValueKey.textColor),
          titleLarge: TextStyle(color: ColorValueKey.textColor),
          titleMedium: TextStyle(color: ColorValueKey.textColor),
          titleSmall: TextStyle(color: ColorValueKey.textColor),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: ColorValueKey.textColor.withOpacity(0.4),
          ),
          floatingLabelStyle: TextStyle(
            color: ColorValueKey.textColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorValueKey.lineBorder,
            ),
          ),
          hintStyle: TextStyle(
            color: ColorValueKey.textColor.withOpacity(0.4),
          ),
        ),
      ),
      locale: const Locale('vi', 'VN'),
      supportedLocales: const[
        Locale('vi', "VN"),
        Locale('en', "US"),
      ],
    );
  }
}