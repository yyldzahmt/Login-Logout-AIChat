import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kullanicikayitgiris/chat_gpt/providers/active_theme_provider.dart';
import 'package:kullanicikayitgiris/chat_gpt/widgets/theme_switch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../girisekrani.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Flutter GPT',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      actions: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((user) {
                  //çıkış yapıp giriş sayfasına git
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => GirisEkrani(),
                      ),
                      (route) => false);
                });
              },
              icon: Icon(Icons.exit_to_app),
            ),
            // Consumer(
            //   builder: (context, ref, child) => Icon(
            //     ref.watch(activeThemeProvider) == Themes.light
            //         ? Icons.dark_mode
            //         : Icons.light_mode,
            //   ),
            // ),
            // const SizedBox(width: 8),
            // const ThemeSwitch(),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
