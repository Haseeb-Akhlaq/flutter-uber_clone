import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:uber_clone/helpers/helperMethods.dart';

import '../styles/project_style_data.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  double mapBottomPadding = 0;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.4685, 70.9606),
    zoom: 14.4746,
  );

  var geoLocator = Geolocator();
  Position currentPosition;

  void setupPositonLocator() async {
    currentPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );
    CameraPosition cp = CameraPosition(
      target: LatLng(
        currentPosition.latitude,
        currentPosition.longitude,
      ),
      zoom: 16,
    );
    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
    final address = await HelperMethods.findCoordinatesAddress(currentPosition);
    print(address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: Container(
          width: 250,
          child: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: 180,
                  color: Colors.white,
                  child: DrawerHeader(
                    margin: EdgeInsets.all(0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/user_icon.png',
                          height: 60,
                          width: 60,
                        ),
                        SizedBox(width: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Haseeb',
                              style: TextStyle(
                                  fontFamily: 'bolt-semibold', fontSize: 25),
                            ),
                            Text(
                              'View Profile',
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(OMIcons.cardGiftcard),
                  title: Text('Free Rides', style: Styles.kdrawerTileStyle),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(OMIcons.creditCard),
                  title: Text('Payments', style: Styles.kdrawerTileStyle),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(OMIcons.history),
                  title: Text('Ride History', style: Styles.kdrawerTileStyle),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(OMIcons.contactSupport),
                  title: Text('Support', style: Styles.kdrawerTileStyle),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(OMIcons.info),
                  title: Text('About', style: Styles.kdrawerTileStyle),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout', style: Styles.kdrawerTileStyle),
                  onTap: () async {
                    Navigator.pop(context);
                    await FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
          ),
        ), //Drawer
        body: Stack(
          children: [
            GoogleMap(
              padding: EdgeInsets.only(bottom: mapBottomPadding),
              mapType: MapType.hybrid,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                mapController = controller;
                setState(() {
                  mapBottomPadding = MediaQuery.of(context).size.height * 0.35;
                });
                setupPositonLocator();
              },
            ),

            //Drawer Button
            Positioned(
              top: 40,
              left: 15,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 0.5,
                      blurRadius: 15,
                      offset: Offset(7, 7), // changes position of shadow
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    scaffoldKey.currentState.openDrawer();
                  },
                ),
              ),
            ),

            //Search Sheet
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 0.5,
                      blurRadius: 15,
                      offset: Offset(7, 7), // changes position of shadow
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Nice to see you', style: TextStyle(fontSize: 13)),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Where are you Going?',
                            style: TextStyle(
                                fontSize: 20, fontFamily: 'bolt-semibold')),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 0.2,
                                blurRadius: 5,
                                offset:
                                    Offset(3, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('Search Destination')
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Icon(
                              OMIcons.home,
                              size: 30,
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Add Home',
                                    style: TextStyle(fontSize: 18)),
                                Text('Your home address',
                                    style: TextStyle(fontSize: 12))
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(thickness: 1),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              OMIcons.home,
                              size: 30,
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Add Work',
                                    style: TextStyle(fontSize: 18)),
                                Text('Your Work address',
                                    style: TextStyle(fontSize: 12))
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
