import 'package:flutter/material.dart';
import 'package:yuru_kazan/pages/dashboard_page.dart';
import 'package:yuru_kazan/pages/singup_page.dart';
import 'package:yuru_kazan/service/auth.dart';

String email = "";
String sifre = "";

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool visible = true;
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/basarlogo.png",
              width: size.width * 0.5,
              height: size.height * 0.25,
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
                      hintText: "Email adresinizi giriniz.",
                    ),
                    onChanged: (deger) {
                      email = deger;
                    },
                  ),
                  TextFormField(
                    obscureText: visible,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.key,
                        color: Colors.blue[700],
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (visible == true) {
                            visible = false;
                          } else {
                            visible = true;
                          }
                        },
                        icon: const Icon(Icons.visibility),
                      ),
                      hintText: "Şifrenizi giriniz.",
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
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => KayitEkrani()));
                          },
                          child: const Text(
                            "SIGN UP",
                            style: TextStyle(
                              letterSpacing: 1,
                            ),
                          ),
                          style: const ButtonStyle(
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _authService.signIn(email, sifre).then(
                                (_) => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DashBoard(
                                      email: email,
                                    ),
                                  ),
                                ),
                              );
                        },
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(
                            letterSpacing: 2,
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
