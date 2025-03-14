import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_com/utils/color_value_key.dart';

late GoRouter system_router;

Future<void> main() async {
  system_router = genRouter();
  runApp(MyDisplay());
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