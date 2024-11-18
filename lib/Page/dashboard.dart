import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carfixer/Page/nav.dart';
import 'package:carfixer/Page/rute.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carfixer/Page/loginscreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:carfixer/Page/profil.dart';
import 'package:geolocator/geolocator.dart';

class Dashboard extends StatefulWidget {
  final GoogleSignInAccount? googleUser;
  final User? firebaseUser;

  Dashboard({this.googleUser, this.firebaseUser});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  GoogleMapController? _mapController;
  LatLng _currentPosition = LatLng(-7.6298, 111.5239);
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied.');
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('Location permissions are permanently denied.');
      return Future.error('Location permissions are permanently denied.');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      
      // Tambahkan marker untuk posisi saat ini
      _markers.add(
        Marker(
          markerId: MarkerId("currentLocation"),
          position: _currentPosition,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: "Lokasi Saya"),
        ),
      );
    });

    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _currentPosition, zoom: 14.0),
      ),
    );
  }
  Future<void> _handleLogout(BuildContext context) async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              Container(
                margin: EdgeInsets.fromLTRB(28, 20, 25, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.logout, color: Colors.red),
                      onPressed: () => _handleLogout(context),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/logo2.png'),
                        ),
                      ),
                      width: 50,
                      height: 68,
                    ),
                    IconButton(
                      icon: Icon(Icons.person, color: Color.fromARGB(255, 122, 43, 9)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(
                              googleUser: widget.googleUser,
                              firebaseUser: widget.firebaseUser,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Google Maps
              Container(
                height: 300,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(target: _currentPosition, zoom: 14.0),
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  markers: _markers,
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                ),
              ),

              // Lokasi Terdekat Section
            
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF5B1010)),
                  color: Color(0xFFF4F2F2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(27, 16, 21, 19),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 42),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Lokasi Terdekat',
                            style: GoogleFonts.getFont(
                              'Poppins',
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Color(0xFF343232),
                            ),
                          ),
                        ),
                      ),
                      // Bengkel A
                      _buildWorkshopCard(context, 'Bengkel A', 'Jln. Gerilya No.77', '2,3 KM', 'assets/images/bengkel.jpeg'),
                      // Bengkel B
                      _buildWorkshopCard(context, 'Bengkel B', 'Jln. Daya No.55', '1,8 KM', 'assets/images/bengkel.jpeg'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
     bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: 0, // Ensure you pass the initial selected index
        onTap: (index) {
          // Handle bottom navigation actions here
        },
        googleUser: widget.googleUser,
        firebaseUser: widget.firebaseUser,
      ),
    );
  }
   Widget _buildWorkshopCard(BuildContext context, String name, String address, String distance, String imagePath) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman rute saat diklik
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Rute(
              googleUser: widget.googleUser, // Kirim Google User
              firebaseUser: widget.firebaseUser, // Kirim Firebase User
            ),
          ),
        ); // Arahkan ke class Rute
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 0, 17),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF581717)),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white, // Ubah warna latar belakang menjadi putih
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 1, 15.2, 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(4, 0, 4, 16),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    name,
                    style: GoogleFonts.getFont(
                      'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Color(0xFF581717),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 120,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(imagePath), // Ganti dengan gambar bengkel
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          address,
                          style: GoogleFonts.getFont(
                            'Poppins',
                            fontSize: 14,
                            color: Color(0xFF4D4D4D),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          distance,
                          style: GoogleFonts.getFont(
                            'Poppins',
                            fontSize: 14,
                            color: Color(0xFF4D4D4D),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

