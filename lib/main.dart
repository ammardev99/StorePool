import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:storepool/app_shell/app_shell_io.dart';
import 'package:storepool/app_shell/auth_ui/onboarding/splash.dart';
import 'package:storepool/app_shell/menu/store_menu/store_sub_pages/create_store_view.dart';
import 'package:storepool/firebase_options.dart';

import 'package:zi_core/zi_core_io.dart';


Future<void> main() async {
  ziCoreInit(beta: false);
  ZiColors.override(
    ZiColorOverrides(
      primary: const Color(0xFFFF55A0),
      secondary: const Color(0xFF55FFFF),
      tertiary: const Color(0xFF55FF55),
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('✔ Firebase connected successfully');
  } catch (e, stackTrace) {
    debugPrint('❌ Firebase connection failed');
    debugPrint('Error: $e');
    debugPrint('StackTrace: $stackTrace');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Store Pool zi_3',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: ZiSplashScreen(),
      // home: StoreMenuView(),
      // home: CreateStoreView(),
      home: ZiSplashScreen(),
      // home: StorePoolAppView(),
      // home: const TestShell(),
    );
  }
}
