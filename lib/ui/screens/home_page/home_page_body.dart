import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePageBody extends StatefulWidget {
  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  BitmapDescriptor pinLocationIcon;
  // Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {};
  Set<Circle> circles = {};
  Map userMap = {};
  bool isLoad = false;
  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/images/car_icon.png',
    ).then((onValue) {
      pinLocationIcon = onValue;
    });
    Future.delayed(Duration(seconds: 2), () {
      isLoad = true;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StreamBuilder<Event>(
          stream:
              FirebaseDatabase.instance.reference().child("Drivers").onValue,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                print('waiting');
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              default:
                if (snapshot.hasError) {
                  print('hasError');
                  return Center(
                    child: Text('error'),
                  );
                } else if (!snapshot.hasData) {
                  print('dont hasData');
                  return Center(
                    child: Text('no data'),
                  );
                } else {
                  // Check for null
                  var result = snapshot.data;
                  if (result != null) {
                    print('result not null');
                    userMap = Map.from(snapshot.data.snapshot.value);
                    Set keys = userMap.keys.toSet();
                    markers = keys
                        .map(
                          (element) => Marker(
                            markerId: MarkerId(element),
                            infoWindow: InfoWindow(
                              title:
                                  '${userMap[element]['firstName'].toString()} ',
                              snippet: 'Click to open Whatsapp',
                              anchor: Offset(0.5, 0.0),
                              onTap: () async {
                                var phone =
                                    userMap[element]['phoneNumber'].toString();
                                var whatsappUrl = "";
                                if (Platform.isIOS) {
                                  whatsappUrl = "whatsapp://wa.me/$phone}";
                                } else {
                                  whatsappUrl = "whatsapp://send?phone=$phone}";
                                }
                                await canLaunch(whatsappUrl)
                                    ? launch(whatsappUrl)
                                    : showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text("AlertDialog"),
                                            content:
                                                Text("whats_app_not_installed"),
                                            actions: [
                                              FlatButton(
                                                child: Text("Cancel"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                // showAlertDialog(
                                //     context, "whats_app_not_installed");
                              },
                            ),
                            position: LatLng(
                              userMap[element]['latitude'] ??
                                  266.93341064453125,
                              userMap[element]['longitude'] ??
                                  266.93341064453125,
                            ),
                            rotation: double.parse(
                                userMap[element]['heading'].toString() ??
                                    266.93341064453125),
                            draggable: false,
                            zIndex: 2,
                            flat: true,
                            anchor: Offset(0.5, 0.5),
                            icon: pinLocationIcon,
                          ),
                        )
                        .toSet();
                    circles = keys
                        .map(
                          (element) => Circle(
                              circleId: CircleId(element),
                              radius: userMap[element]['accuracy'] ??
                                  5.196000099182129,
                              zIndex: 1,
                              strokeColor: Colors.blue,
                              center: LatLng(
                                userMap[element]['latitude'] ??
                                    266.93341064453125,
                                userMap[element]['longitude'] ??
                                    266.93341064453125,
                              ),
                              fillColor: Colors.blue.withAlpha(70)),
                        )
                        .toSet();

                    return GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(31.4167, 34.3333),
                        zoom: 10.5,
                      ),
                      // onMapCreated: (GoogleMapController controller) {
                      //   _controller.complete(controller);
                      // },
                      markers: markers,
                      circles: circles,
                    );
                  } else {
                    print('result null');
                    return Center(
                      child: Text('data null'),
                    );
                  }
                }

                break;
            }
          },
        ),
        !isLoad
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(),
      ],
    );
  }
  // getUserLocationFromRealTime() {
  //   FirebaseDatabase.instance
  //       .reference()
  //       .child("Drivers")
  //       .onValue
  //       .listen((event) {
  //     userMap = Map.from(event.snapshot.value);
  //     List keys = userMap.keys.toList();
  //     keys.forEach((element) {
  //       List<Marker> markers2 = markers
  //           .where((marker) => marker.markerId == MarkerId(element))
  //           .toList();
  //       markers.removeAll(markers2);
  //       markers.add(
  //         Marker(
  //           markerId: MarkerId(element),
  //           infoWindow:
  //               InfoWindow(title: userMap[element]['firstName'].toString()),
  //           position: LatLng(
  //             userMap[element]['latitude'],
  //             userMap[element]['longitude'],
  //           ),
  //           rotation: userMap[element]['heading'],
  //           draggable: false,
  //           zIndex: 2,
  //           flat: true,
  //           anchor: Offset(0.5, 0.5),
  //           icon: pinLocationIcon,
  //         ),
  //       );
  //       List<Circle> circles2 = circles
  //           .where((circles) => circles.circleId == CircleId(element))
  //           .toList();
  //       circles.removeAll(circles2);
  //       circles.add(
  //         Circle(
  //             circleId: CircleId(element),
  //             radius: userMap[element]['accuracy'],
  //             zIndex: 1,
  //             strokeColor: Colors.blue,
  //             center: LatLng(
  //               userMap[element]['latitude'],
  //               userMap[element]['longitude'],
  //             ),
  //             fillColor: Colors.blue.withAlpha(70)),
  //       );
  //     });
  //     setState(() {});
  //   });
  // }

  // getUserLocationFromFirestore() {
  //   FirebaseFirestore.instance
  //       .collection('Drivers')
  //       .snapshots()
  //       .listen((event) {
  //     event.docChanges.forEach((change) {
  //       List<Marker> markers2 = markers
  //           .where((element) => element.markerId == MarkerId(change.doc.id))
  //           .toList();
  //       markers.removeAll(markers2);

  //       markers.add(
  //         Marker(
  //           markerId: MarkerId(change.doc.id),
  //           infoWindow:
  //               InfoWindow(title: change.doc.data()['firstName'].toString()),
  //           position: LatLng(
  //             change.doc.data()['location'].latitude,
  //             change.doc.data()['location'].longitude,
  //           ),
  //           icon: pinLocationIcon,
  //         ),
  //       );
  //       print(markers.length);
  //       setState(() {});
  //     });
  //   });
  // }
}
