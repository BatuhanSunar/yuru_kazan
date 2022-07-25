import 'package:flutter/material.dart';
import 'package:yuru_kazan/pages/login_page.dart';
import 'package:yuru_kazan/service/auth.dart';

String ad = "";
String soyad = "";
String email = "";
String sifre = "";

class KayitEkrani extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/basarlogo.png",
              width: size.width * 0.5,
              height: size.height * 0.2,
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.pink[50],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.blue[700],
                      ),
                      hintText: "Adınız",
                    ),
                    onChanged: (deger) {
                      ad = deger;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.blue[700],
                      ),
                      hintText: "Soyadınız",
                    ),
                    onChanged: (deger) {
                      soyad = deger;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.mail,
                        color: Colors.blue[700],
                      ),
                      hintText: "E-mail",
                    ),
                    onChanged: (deger) {
                      email = deger;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.key,
                        color: Colors.blue[700],
                      ),
                      hintText: "Şifre",
                    ),
                    onChanged: (deger) {
                      sifre = deger;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _authService.createUser(ad, soyad, email, sifre);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (content) => const Login(),
                            ),
                          );
                        },
                        child: const Text(
                          "KAYIT OL",
                          style: TextStyle(
                            letterSpacing: 1,
                          ),
                        ),
                        style: const ButtonStyle(
                          alignment: Alignment.center,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
