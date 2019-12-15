import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:url_launcher/url_launcher.dart';

class Maps extends StatefulWidget {
  Maps(this.pos);
  final Position pos;

  @override
  State<StatefulWidget> createState() => MapsState();
}

class MapsState extends State<Maps> {
  final Set<Polyline> polyline = {};
  List<LatLng> routeCoords;
  GoogleMapPolyline googleMapPolyline =
      new GoogleMapPolyline(apiKey: "AIzaSyCGeQzXmy5jl7uOc7nupVlbC6IloHbjjUo");
  Completer<GoogleMapController> _controller = Completer();
  Geolocator geolocator = Geolocator();
  Position position1;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MapType _currentMapType = MapType.normal;
   final Set<Polyline> poly = {};
  List foto = [];
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    addMarker();

    foto.add("assets/img/car_3d.png");
    foto.add("assets/img/normal.png");
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

  void addMarker() {
    final MarkerId markerId = MarkerId("1");
    Marker marker = Marker(
      consumeTapEvents: true,
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => SizedBox(
            width: 100.0,
            height: 200.0,
            child: Center(
              child: Stack(
                children: <Widget>[
                  Container(
                      height: MediaQuery.of(context).size.height / 1.2,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(Consts.padding),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10.0,
                            offset: const Offset(0.0, 10.0),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: <Widget>[
                          ListView(
                            // mainAxisSize:
                            //     MainAxisSize.min, // To make the card compact
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  padding:
                                      EdgeInsets.only(top: 5.0, right: 5.0),
                                  width: 45.0,
                                  height: 45.0,
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                    child: new Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                    shape: new CircleBorder(),
                                    elevation: 6.0,
                                    fillColor: Colors.red,
                                    constraints: BoxConstraints(
                                        minWidth: 40.0, minHeight: 20.0),
                                    padding: const EdgeInsets.all(0.0),
                                  ),
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.only(top: 10),
                                  height: 200,
                                  child: PhotoViewGallery.builder(
                                    itemCount: 2,
                                    builder: (context, index) {
                                      return PhotoViewGalleryPageOptions(
                                        imageProvider: AssetImage(
                                          foto[index],
                                        ),
                                        minScale:
                                            PhotoViewComputedScale.contained *
                                                1,
                                        maxScale:
                                            PhotoViewComputedScale.covered * 1,
                                      );
                                    },
                                    scrollPhysics: BouncingScrollPhysics(),
                                    backgroundDecoration: BoxDecoration(
                                      color: Theme.of(context).canvasColor,
                                    ),
                                    scrollDirection: Axis.horizontal,
                                    loadingChild: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 20, left: 20.0, right: 10.0),
                                child: RichText(
                                  text: TextSpan(
                                    style: new TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      new TextSpan(
                                          text: 'Adres : ',
                                          style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          )),
                                      new TextSpan(
                                          text:
                                              'Maden Mah. Kevser Sokak No 19 SARIYER / ISTANBUL',
                                          style: new TextStyle(
                                            fontSize: 16.0,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.0),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 20, left: 20.0, right: 10.0),
                                child: RichText(
                                  text: TextSpan(
                                    style: new TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      new TextSpan(
                                          text: 'Saatlik Ücret: ',
                                          style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                          )),
                                      new TextSpan(
                                          text: '5 Tl',
                                          style: new TextStyle(
                                            fontSize: 16.0,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.0),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: 20, left: 20.0, right: 10.0),
                                  child: RichText(
                                    text: TextSpan(
                                      style: new TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                      children: <TextSpan>[
                                        new TextSpan(
                                            text: 'Günlük Ücret: ',
                                            style: new TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                            )),
                                        new TextSpan(
                                            text: '15 Tl',
                                            style: new TextStyle(
                                              fontSize: 16.0,
                                            )),
                                      ],
                                    ),
                                  )),
                              SizedBox(height: 16.0),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: 20, left: 20.0, right: 10.0),
                                  child: RichText(
                                    text: TextSpan(
                                      style: new TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                      children: <TextSpan>[
                                        new TextSpan(
                                            text: 'Haftalık Ücret: ',
                                            style: new TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                            )),
                                        new TextSpan(
                                            text: '90 Tl',
                                            style: new TextStyle(
                                              fontSize: 16.0,
                                            )),
                                      ],
                                    ),
                                  )),
                              SizedBox(height: 16.0),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: 20, left: 20.0, right: 10.0),
                                  child: RichText(
                                    text: TextSpan(
                                      style: new TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                      children: <TextSpan>[
                                        new TextSpan(
                                            text: 'Aylık Ücret: ',
                                            style: new TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0,
                                            )),
                                        new TextSpan(
                                            text: '150 Tl',
                                            style: new TextStyle(
                                              fontSize: 16.0,
                                            )),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: EdgeInsets.only(top: 30.0),
                              height: 50.0,
                              width: MediaQuery.of(context).size.width,
                              child: RaisedButton(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                color: Colors.redAccent,
                                child: Text("Git",
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.white)),
                                onPressed: () {
                                  Navigator.pop(context);
                                  
                                  _launchMapsUrl(widget.pos.latitude.toString(),widget.pos.longitude.toString());
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(0.0),
                                    topLeft: Radius.circular(0.0),
                                    bottomRight: Radius.circular(10.0),
                                    bottomLeft: Radius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        );
      },
      icon: BitmapDescriptor.defaultMarker,
      markerId: markerId,
      position: LatLng(widget.pos.latitude, widget.pos.longitude),
    );

    setState(() {
      markers[markerId] = marker;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        GoogleMap(
          myLocationEnabled: true,
          rotateGesturesEnabled: true,
          onMapCreated: onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(
                double.parse(widget.pos == null
                    ? "0.0"
                    : widget.pos.latitude.toString()),
                double.parse(widget.pos == null
                    ? "0.0"
                    : widget.pos.longitude.toString())),
            tilt: 10.2,
            zoom: 17.0,
          ),
          mapType: _currentMapType,
          markers: Set<Marker>.of(markers.values),
        ),
        wmylocationbutton(),
      ],
    ));
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller.complete(controller);
    });
  }

  void onMapTypeButtonPressed(Position position) async {
    CameraPosition _position1 = CameraPosition(
      bearing: 0.0,
      target: LatLng(position == null ? widget.pos.latitude : position.latitude,
          position == null ? widget.pos.longitude : position.longitude),
      tilt: 0.0,
      zoom: 17.0,
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
  }

  Widget wmylocationbutton() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(
          right: 10.0, top: 20.0,
          // bottom: haritadurum ? 200.0 : taksiDurum ? 220.0 : 320.0
        ),
        child: Container(
          width: 40.0,
          height: 40.0,
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                onMapTypeButtonPressed(position1);
              });
            },
            materialTapTargetSize: MaterialTapTargetSize.padded,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            child: Icon(
              Icons.my_location,
              size: 25.0,
              color: Colors.blueAccent,
            ),
          ),
        ),
      ),
    );
  }

  void _launchMapsUrl(String lat, String lng)   async {
    final String googleMapsUrl = "comgooglemaps://?center=$lat,$lng";
    final String appleMapsUrl = "https://maps.apple.com/?q=$lat,$lng";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    }
    if (await canLaunch(appleMapsUrl)) {
      await launch(appleMapsUrl, forceSafariVC: false);
    } else {
      throw "Couldn't launch URL";
    }
  }

  
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
