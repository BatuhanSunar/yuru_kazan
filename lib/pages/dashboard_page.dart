import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:yuru_kazan/pages/login_page.dart';
import 'package:yuru_kazan/pages/map_page.dart';
import '../controller/geolocator_controller.dart';

String ad = "";
String soyad = "";

class DashBoard extends StatefulWidget {
  String email;
  DashBoard({required this.email});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    getData();
    getLocation();
    super.initState();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final geolocatorController = Get.put(GeolocatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text(
          "Dashboard",
          textAlign: TextAlign.center,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.pink[50],
        alignment: Alignment.topCenter,
        // Kullanıcı Bilgileri Card
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                // Kullanıcı ad soyad bilgisi
                title: Text("$ad $soyad"),
                // Kullanıcı mail bilgisi
                subtitle: Text(
                  widget.email,
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                // Kullanıcı aktivite bilgisi
                child: Text(
                  'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  // Yeni Aktivite Butonu
                  FlatButton(
                    textColor: const Color(0xFF6200EE),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Maps(
                              latitude:
                                  geolocatorController.currentPosition.latitude,
                              longitude: geolocatorController
                                  .currentPosition.longitude),
                        ),
                      );
                    },
                    child: const Text('Yeni Aktivite'),
                  ),
                  // Geçmiş Aktivite Butonu
                  FlatButton(
                    textColor: const Color(0xFF6200EE),
                    onPressed: () {},
                    child: const Text('Aktivite Geçmişim'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void getData() async {
    var userRef = _firestore.collection('Person');
    var response = await userRef.get();

    var users = response.docs;

    users.forEach((element) {
      if (element.data().isNotEmpty) {
        if (element.data()['email'] == email) {
          setState(() {
            ad = element.data()['ad'];
            soyad = element.data()['soyad'];
          });
        }
      }
    });
  }

  getLocation() {
    Geolocator.requestPermission().then((request) {
      if (Platform.isAndroid) {
        if (request != LocationPermission.whileInUse) {
          return;
        } else {
          geolocatorController.permissionOK();
        }
      }
    });
  }
}
