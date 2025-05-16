import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grocery/provider/address_provider.dart';
import 'package:grocery/provider/favorite_provider.dart';
import 'package:grocery/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ta'), Locale('hi')],
      path: 'assets/translation',
      fallbackLocale: const Locale('en'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FavoriteProvider()),
          ChangeNotifierProvider(create: (_) => AddressProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider(false)),
        ],
        child: const GroceryApp(),
      ),
    ),
  );
}

class GroceryApp extends StatelessWidget {
  const GroceryApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Grocery App',
      debugShowCheckedModeBanner: false,
      theme: themeProvider.isDark
          ? ThemeData.dark(useMaterial3: true)
          : ThemeData.light(useMaterial3: true),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: SplashScreen(
        toggleTheme: (bool isDark) {  },
        isDarkTheme: themeProvider.isDark,
      ),
    );
  }
}
