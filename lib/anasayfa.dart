// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:kullanicikayitgiris/girisekrani.dart';

// class AnaSayfa extends StatelessWidget {
//   final user = FirebaseAuth.instance.currentUser!;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[300],
//       appBar: AppBar(
//         title: Text("AnaSayfa"),
//         backgroundColor: Colors.transparent,
        //  actions: [
        //    IconButton(
        //      onPressed: () {
        //        FirebaseAuth.instance.signOut().then((user) {
        //          //çıkış yapıp giriş sayfasına git
        //          Navigator.pushAndRemoveUntil(
        //              context,
        //              MaterialPageRoute(
        //                builder: (_) => GirisEkrani(),
        //             ),
        //              (route) => false);
        //        });
        //      },
        //      icon: Icon(Icons.exit_to_app),
        //    ),
        // ],
//       ),
//       body: Center(
//           child: Text(
//         "Anasayfaya Hoşgeldiniz " + user.email!,
//         style: TextStyle(
//             fontSize: 15,
//             fontStyle: FontStyle.italic,
//             color: Color.fromARGB(255, 0, 0, 0)),
//       )),
//     );
//   }
// }
