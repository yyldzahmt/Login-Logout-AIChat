import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kullanicikayitgiris/girisekrani.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //-------------------- Firebaseyi çalıştır
  await Firebase.initializeApp();
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: KayitUygulama()));
}

class KayitUygulama extends StatelessWidget {
  const KayitUygulama({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GirisEkrani();
  }
}
