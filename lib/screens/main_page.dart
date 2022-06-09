import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/helpers/helper_methods.dart';
import 'package:uber_clone/styles/styles.dart';
import 'package:uber_clone/widgets/brand_divider.dart';

import '../brand_colors.dart';
import '../dataproviders/app_data.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);
  static const String id = 'main';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Completer<GoogleMapController> _controller = Completer();

  late GoogleMapController mapController;

  double mapBottomPadding = 0;

  late Position currentPosition;

  void setupPositionLocator() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    LatLng newPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cp = CameraPosition(target: newPosition, zoom: 16);

    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));

    String address =
        await HelperMethods.findCordinateAddress(position, context);
    print(address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Container(
          width: 250,
          color: Colors.white,
          child: Drawer(
              child: ListView(padding: const EdgeInsets.all(0), children: [
            Container(
                color: Colors.white,
                height: 160,
                child: DrawerHeader(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Row(children: [
                      Image.asset('assets/images/user_icon.png',
                          height: 60, width: 60),
                      const SizedBox(width: 15),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Sami',
                                style: const TextStyle(
                                    fontSize: 20, fontFamily: 'Brand-Bold')),
                            const SizedBox(height: 5),
                            const Text('View Profile')
                          ])
                    ]))),
            const BrandDivider(),
            const SizedBox(height: 10),
            ListTile(
                leading: const Icon(Icons.card_giftcard_outlined),
                title: Text('Free Rides', style: kDrawerItemStyle)),
            ListTile(
                leading: const Icon(Icons.card_membership_outlined),
                title: Text('Payments', style: kDrawerItemStyle)),
            ListTile(
                leading: const Icon(Icons.history_outlined),
                title: Text('Ride History', style: kDrawerItemStyle)),
            ListTile(
                leading: const Icon(Icons.support_agent_outlined),
                title: Text('Support', style: kDrawerItemStyle)),
            ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text('About', style: kDrawerItemStyle))
          ]))),
      body: Stack(children: [
        GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            padding: EdgeInsets.only(bottom: mapBottomPadding),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              mapController = controller;
              setState(() {
                mapBottomPadding = 290;
              });

              setupPositionLocator();
            },
            initialCameraPosition: const CameraPosition(
                target: LatLng(6.6720242, -1.5693055), zoom: 16)),
        Positioned(
          top: 44,
          left: 20,
          child: GestureDetector(
            onTap: () {
              scaffoldKey.currentState!.openDrawer();
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      const BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5.0,
                          spreadRadius: 0.5,
                          offset: const Offset(0.7, 0.7))
                    ]),
                child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: const Icon(Icons.menu, color: Colors.black87))),
          ),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
                height: 300,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 15.0,
                          spreadRadius: 0.5,
                          offset: Offset(0.7, 0.7))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 24),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        const Text(
                          'Nice to see you!',
                          style: TextStyle(fontSize: 10),
                        ),
                        const Text(
                          'Where are you going?',
                          style:
                              TextStyle(fontSize: 18, fontFamily: 'Brand-Bold'),
                        ),
                        const SizedBox(height: 20),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 5.0,
                                      spreadRadius: 0.5,
                                      offset: Offset(0.7, 0.7))
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(children: const [
                                Icon(Icons.search, color: Colors.blueAccent),
                                SizedBox(width: 10),
                                Text('Search Destination')
                              ]),
                            )),
                        const SizedBox(
                          height: 22,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.home_outlined,
                                color: BrandColors.colorDimText),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Provider.of<AppData>(context)
                                            .pickupAddress !=
                                        null
                                    ? Provider.of<AppData>(context)
                                        .pickupAddress
                                        .placeName
                                    : 'Add Home'),
                                SizedBox(height: 3),
                                Text('Your residential address',
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: BrandColors.colorDimText))
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        const BrandDivider(),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.work_outline,
                                color: BrandColors.colorDimText),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Add Work'),
                                SizedBox(height: 3),
                                Text('Your work address',
                                    style: TextStyle(
                                        fontSize: 11,
                                        color: BrandColors.colorDimText))
                              ],
                            )
                          ],
                        ),
                      ]),
                )))
      ]),
    );
  }
}
