import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  final ZoomDrawerController controller;

  const SettingsScreen({super.key, required this.controller});

  void _changeLanguage(BuildContext context, Locale locale) {
    context.setLocale(locale);
    Navigator.of(context).pop(); // close dialog
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkTheme = themeProvider.isDark;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.green),
          onPressed: () {
            controller.toggle!();
          },
        ),
        title: Text(
          "settings".tr(),
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🌙 Dark Theme Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "dark_theme".tr(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Switch(
                  value: isDarkTheme,
                  onChanged: (value) => themeProvider.toggleTheme(value),
                ),
              ],
            ),
            const SizedBox(height: 30),
            // 🌐 Language Selection
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.language),
              title: Text(
                "choose_language".tr(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              onTap: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: Text("choose_language".tr()),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: const Text("English"),
                              onTap:
                                  () => _changeLanguage(
                                    context,
                                    const Locale('en'),
                                  ),
                            ),
                            ListTile(
                              title: const Text("தமிழ்"),
                              onTap:
                                  () => _changeLanguage(
                                    context,
                                    const Locale('ta'),
                                  ),
                            ),
                            ListTile(
                              title: const Text("हिन्दी"),
                              onTap:
                                  () => _changeLanguage(
                                    context,
                                    const Locale('hi'),
                                  ),
                            ),
                          ],
                        ),
                      ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
