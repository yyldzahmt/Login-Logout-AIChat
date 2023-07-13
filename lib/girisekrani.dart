import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'package:kullanicikayitgiris/anasayfa.dart';
import 'package:kullanicikayitgiris/kayitekrani.dart';
import 'package:kullanicikayitgiris/chat_gpt/screen/chat_screen.dart';
import 'package:kullanicikayitgiris/sifremiunuttum.dart';

class GirisEkrani extends StatefulWidget {
  @override
  State<GirisEkrani> createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  //----------- giriş parametreleri
  late String email, sifre;

  //----------doğrulama anahtarı
  var _forAnahtari = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      // appBar: AppBar(
      //   title: Text("Giriş Ekranı"),
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
                Icons.account_circle,
                color: Colors.black,
                size: 100,
              ),
              Text(
                "Hoşgeldiniz!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Tekrar Hoşgeldin Özlendin",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[500],
                ),
              ),
              SizedBox(height: 25),
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
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(left: 20.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    obscureText: true,
                    onChanged: (alinanSifre) {
                      sifre = alinanSifre;
                    },
                    validator: (alinanSifre) {
                      return alinanSifre!.length >= 6
                          ? null
                          : "En az 6 karekter";
                    },
                    decoration: InputDecoration(
                      hintText: "Şifre",
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(left: 20.0),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Reset()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Şifreni mi unuttun?",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 11.6),
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    girisYap();
                  },
                  child: Text("Giriş Yap"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    textStyle: TextStyle(fontSize: 18),
                    //textStyle: GoogleFonts.roboto(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: 15),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => KayitEkrani()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hesabın yok mu? ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Kaydol",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                  // child: Container(
                  //   padding: EdgeInsets.all(8),
                  //   alignment: Alignment.center,
                  //   child: Text(
                  //     "Hesabın yok mu? Kaydol",
                  //     style: TextStyle(
                  //       fontSize: 15,
                  //       color: Colors.blue,
                  //     ),
                  //   ),
                  // ),
                  ),
              SizedBox(height: 5),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(
              //         context, MaterialPageRoute(builder: (_) => Reset()));
              //   },
              //   child: Container(
              //     padding: EdgeInsets.all(8),
              //     alignment: Alignment.center,
              //     child: Text(
              //       "Şifreni mi unuttun?",
              //       style: TextStyle(
              //         fontSize: 15,
              //         color: Colors.blue,
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

// email ve şifreye göre doğrulamaya göre giriş yapıcak
  void girisYap() {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
              //child: CircularProgressIndicator(),
              );
        });
    if (_forAnahtari.currentState!.validate()) {
      //Giriş Yap
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: sifre)
          .then((user) {
        //eger başarılı ise ana sayfaya git
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (_) => ProviderScope(
                      child: ChatScreen(),
                    )),
            (route) => false);
      }).catchError((hata) {
        Fluttertoast.showToast(msg: hata);
      });
    }
  }
}
