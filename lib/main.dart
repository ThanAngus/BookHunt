import 'dart:convert';

import 'package:book_hunt/page/homePage.dart';
import 'package:book_hunt/utils/appTheme.dart';
import 'package:book_hunt/utils/colors.dart';
import 'package:book_hunt/utils/service/bookService.dart';
import 'package:book_hunt/utils/service/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import 'models/config.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  _setUp().then((value) {
    FlutterNativeSplash.remove();
    runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );
  });
}

Future<void> _setUp() async {
  final getIt = GetIt.instance;
  final config = await rootBundle.loadString('assets/json/main.json');
  final configData = jsonDecode(config);
  getIt.registerSingleton<AppConfig>(
    AppConfig(
      baseUrl: configData['BASE_URL'],
    ),
  );
  getIt.registerSingleton<HTTPService>(
    HTTPService(),
  );
  getIt.registerSingleton<BookService>(
    BookService(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, Widget? child) {
        return MaterialApp(
          title: 'Book Hunt',
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: MyBehavior(),
              child: child!,
            );
          },
          home: const HomePage(),
        );
      },
    );
  }
}
