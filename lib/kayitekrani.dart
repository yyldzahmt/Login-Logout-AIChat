import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:kullanicikayitgiris/chat_gpt/screen/chat_screen.dart';
//import 'package:kullanicikayitgiris/anasayfa.dart';
import 'package:kullanicikayitgiris/girisekrani.dart';

class KayitEkrani extends StatefulWidget {
  const KayitEkrani({Key? key}) : super(key: key);

  @override
  State<KayitEkrani> createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {
  //--------------------kayit parametreleri--------------
  late String email, sifre;

  //----

  var _formAnahtari = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      // appBar: AppBar(
      //   title: Text("Kayıt Ekranı"),
      //   backgroundColor: Color.fromARGB(255, 0, 0, 0),
      //   centerTitle: true,
      // ),
      body: Form(
        key: _formAnahtari,
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.app_registration_outlined,
                  color: Colors.black,
                  size: 100,
                ),
                Text(
                  "Kayıt ol!",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Hesabın mı yok? Hemen kayıt ol!",
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
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.only(left: 20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0,
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
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 11.6),
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      kayitEkle();
                    },
                    child: Text("Kaydol"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  alignment: Alignment.center,
                  child: GestureDetector(
                      onTap: () {
                        //-------Giriş Sayfasına gidicek
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => GirisEkrani()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Hesabın var mı? ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Giriş Yapın",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      )
                      // child: Text(
                      //   "Zaten Hesabım Var",
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     color: Colors.blue,
                      //   ),
                      // ),
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//-------------------email ve şifre göre firebase kullanıcı ekle-----------
  void kayitEkle() {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
              //child: CircularProgressIndicator(),
              );
        });
    if (_formAnahtari.currentState!.validate()) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: sifre)
          .then((user) {
        //-----başarılı isa anasayfaya git
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (_) => ProviderScope(
                      child: ChatScreen(),
                    )),
            (Route<dynamic> route) => false);
      }).catchError((hata) {
        //---başarılı değilse hata mesajı göster
        Fluttertoast.showToast(msg: hata);
      });
    }
  }
}
