import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kullanicikayitgiris/chat_gpt/providers/active_theme_provider.dart';
import 'package:kullanicikayitgiris/chat_gpt/screen/chat_screen.dart';

import '../constants/themes.dart';

class KayitUygulama extends ConsumerWidget {
  const KayitUygulama({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeTheme = ref.watch(activeThemeProvider);
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      themeMode: activeTheme == Themes.dark ? ThemeMode.dark : ThemeMode.light,
      home: ChatScreen(),
    );
  }
}
