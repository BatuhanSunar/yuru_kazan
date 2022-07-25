import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:yuru_kazan/pages/login_page.dart';
import 'package:yuru_kazan/pages/map_page.dart';
import 'package:yuru_kazan/pages/past_activities_page.dart';
import '../controller/geolocator_controller.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        
        title: const Text(
          "Dashboard",
          textAlign: TextAlign.center,
          style: TextStyle(
            color:Colors.black,
            fontFamily: 'Roboto',
            fontStyle: FontStyle.italic,
            fontSize: 25,
            fontWeight: FontWeight.w700
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Color.fromARGB(255, 228, 227, 226),
        child: Column(
          
          children:<Widget> [
            SizedBox(height: 20,),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Column(
                    children: [
                      Container(//board container 
                        height: 300,
                        margin: EdgeInsets.symmetric(horizontal: 15,vertical:15 ),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 240, 114, 17),
                          borderRadius: BorderRadius.all(
                            Radius.circular(40)
                          ),
                          
                        ),
                        padding: EdgeInsets.all(20),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            SizedBox(height: 20,),
                            Row(//percent_indicators
                              children: [
                                
                                Container(//Mesafe sayar 
                                margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                decoration: BoxDecoration(
                                   
                                ),
                                transformAlignment: Alignment.center,
                                    child: CircularPercentIndicator(
                                      backgroundColor: Color.fromARGB(255, 115, 114, 114),
                                      radius: 70.0,
                                      lineWidth: 15.0,
                                      percent: 0.50,
                                      animation: true,
                                      animationDuration: 1200,
                                      center: Column(
                                        
                                        children: [
                                          SizedBox(height: 25,),
                                          Icon(
                                            Icons.directions_walk_outlined,
                                            color: Colors.white,
                                            size: 50,
                                          ),
                                          Text(
                                            '2222 adım',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'OpenSans',
                                              fontStyle: FontStyle.italic,
                                            ),
                                            )
                                          
                                        ],
                                      ),
                                      
                                      progressColor: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                ),
                            
      
                                Container(// süre sayar
                                 margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                                decoration: BoxDecoration(
                                   
                                ),
                                transformAlignment: Alignment.center,
                                    child: CircularPercentIndicator(
                                      backgroundColor: Color.fromARGB(255, 115, 114, 114),
                                      radius: 70.0,
                                      lineWidth: 15.0,
                                      percent: 0.50,
                                      animation: true,
                                      animationDuration: 1200,
                                      center: Column(
                                        
                                        children: [
                                         const SizedBox(height: 25,),
                                          const Icon(
                                            Icons.access_time,
                                            color: Colors.white,
                                            size: 50,
                                          ),
                                          Text(
                                            '45 Dakika',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'OpenSans',
                                              fontStyle: FontStyle.italic,
                                            ),
                                            )
                                          
                                        ],
                                      ),
                                      
                                      progressColor: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(//toplam mesafe ve toplam aktivite sayısı
                              mainAxisAlignment: MainAxisAlignment.center,
                              
                              children: [
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.social_distance,
                                    color: Colors.white,
                                    ),
                                  Text(
                                    ' 2.55 km   |  ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white
                                    ),
                                    ),
                                ],
                              ),
                                Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.social_distance,
                                    color: Colors.white,
                                    ),
                                  Text(
                                    ' 5 aktivite ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white
                                    ),
                                    ),
                                ],
                              )
                              ],
                            )
      
                            
                          ],
                        ),
                      ),
                      
                      SizedBox(height: 20,),
                      Container(
                        
                        alignment: Alignment.center,
                      
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            
                            Container(
                              height: size.height/4,
                              width: size.width/2.8,
                              margin: EdgeInsets.symmetric(horizontal: 15,vertical:15 ),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 246, 246, 245),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40)
                                ),
                              ),
                              
                              alignment: Alignment.topCenter,
                              child:SizedBox.expand(
                              
                                child: ElevatedButton(
                                  child: Text(
                                    'Egzersiz Kayıtları',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20
                                    ),),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                        MaterialPageRoute(
                                          builder: (context) => Past_Activity(),
                                          )
                                    );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 246, 246, 245),),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(40)),
                                      )
                                    ),
                                  ),
                                ),
                              )
                            ),
                            SizedBox(width: 20,),
                            Container(
                              height: size.height/4,
                              width: size.width/2.8,
                              margin: EdgeInsets.symmetric(horizontal: 15,vertical:15 ),
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 246, 246, 245),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40)
                                ),
                                
                              ),
                              
                              alignment: Alignment.centerLeft,
                              child:SizedBox.expand(
                              
                                child: ElevatedButton(
                                  child: Text(
                                    'Yeni Egzersiz',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20
                                    ),),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                        MaterialPageRoute(
                                          builder: (context) => Maps(
                                            latitude: geolocatorController
                                            .currentPosition
                                            .latitude,
                                            longitude: geolocatorController
                                            .currentPosition.longitude,
                                          
                                    ),
                                  ),
                                );
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 246, 246, 245),),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(40)),
                                      )
                                    ),
                                  ),
                                ),
                              )
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // body: Container(
      //   color: Colors.pink[50],
      //   alignment: Alignment.topCenter,
      //   // Kullanıcı Bilgileri Card
      //   child: Card(
      //     clipBehavior: Clip.antiAlias,
      //     child: Column(
      //       children: [
      //         ListTile(
      //           leading: const Icon(Icons.person),
      //           // Kullanıcı ad soyad bilgisi
      //           title: Text("$ad $soyad"),
      //           // Kullanıcı mail bilgisi
      //           subtitle: Text(
      //             widget.email,
      //             style: TextStyle(color: Colors.black.withOpacity(0.6)),
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.all(16.0),
      //           // Kullanıcı aktivite bilgisi
      //           child: Text(
      //             'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
      //             style: TextStyle(color: Colors.black.withOpacity(0.6)),
      //           ),
      //         ),
      //         ButtonBar(
      //           alignment: MainAxisAlignment.start,
      //           children: [
      //             // Yeni Aktivite Butonu
      //             FlatButton(
      //               textColor: const Color(0xFF6200EE),
      //               onPressed: () {
      //                 Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                     builder: (context) => Maps(
      //                         latitude:
      //                             geolocatorController.currentPosition.latitude,
      //                         longitude: geolocatorController
      //                             .currentPosition.longitude),
      //                   ),
      //                 );
      //               },
      //               child: const Text('Yeni Aktivite'),
      //             ),
      //             // Geçmiş Aktivite Butonu
      //             FlatButton(
      //               textColor: const Color(0xFF6200EE),
      //               onPressed: () {},
      //               child: const Text('Aktivite Geçmişim'),
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
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
