import 'package:flutter/material.dart';
import 'package:admin_app/ui/screens/home_page/home_page_body.dart';

class MapScreen extends StatefulWidget {
  static String routeName = "/map_screen";
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
          // backgroundColor: Colors.black,
          // elevation: 0,
          // title: Text('ffff'),
          ),
      drawer: Drawer(),
      body: HomePageBody(),
    );
  }
}
