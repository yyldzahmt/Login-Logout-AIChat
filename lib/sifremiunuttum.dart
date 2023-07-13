import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:kullanicikayitgiris/anasayfa.dart';
import 'package:kullanicikayitgiris/kayitekrani.dart';

class Reset extends StatefulWidget {
  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  //----------- giriş parametreleri
  late String email;

  //----------doğrulama anahtarı
  var _forAnahtari = GlobalKey<FormState>();
  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(email +
                ' adlı E-postanıza şifre sıfırlama bağlantısı gönderilmiştir. Lütfen E-postanızı kontrol ediniz!'),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
                "Bu E-Maile karşılık gelen kullanıcı kaydı yok. Kullanıcı silinmiş olabilir."),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],

      // appBar: AppBar(
      //   title: Text("Reset Ekranı"),
      //   backgroundColor: Color.fromARGB(255, 0, 0, 0),
      //   centerTitle: true,
      // ),
      body: Form(
        key: _forAnahtari,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_reset,
                size: 150,
                color: Colors.black,
              ),
              SizedBox(height: 8),
              Text(
                "Giriş Yaparken Sorun mu Yaşıyorsun?",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "E-posta adresini gir ve hesabına yeniden",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                " girebilmen için sana bir bağlantı gönderelim.",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (alinanEmail) {
                      email = alinanEmail;
                    },
                    validator: (alinanEmail) {
                      return alinanEmail!.contains("@")
                          ? null
                          : "Mail geçersiz";
                    },
                    // ignore: prefer_const_constructorss
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(left: 20.0),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    passwordReset();
                  },
                  child: Text("Giriş Bağlantısı Gönder"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
