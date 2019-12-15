import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:otobill/Screens/maps.dart';
import 'package:otobill/Screens/users.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

class MyHomePage extends StatefulWidget {  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 1;
  List newlist = ["Profile", "Settings", "Exit"];
  GlobalKey bottomNavigationKey = GlobalKey();
  Position position1;
  Geolocator geolocator = Geolocator();
  @override
   void initState() {
    super.initState();
     _getCurrentLocation();
  }

  void _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        position1 = position;
      });
    }).catchError((e) {
      print(e);
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(      
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: _getPage(currentPage),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(
              iconData: Icons.map,
              title: "Maps",
              onclick: () {
                final FancyBottomNavigationState fState =
                    bottomNavigationKey.currentState;
                fState.setPage(1);
              }),
          TabData(
              iconData: Icons.people,
              title: "Users",
              onclick: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Users()))),
        ],
        initialSelection: 1,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),      
    );
  }

  _getPage(int page) {        
    switch (page) {
      case 0:
        return Maps(position1);
      case 1:
        return Users();
    }
  }
}
