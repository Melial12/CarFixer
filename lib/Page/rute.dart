import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:carfixer/Page/nav.dart';
import 'package:carfixer/Page/chat.dart';
import 'package:carfixer/Page/kosong.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Rute extends StatefulWidget {
  final GoogleSignInAccount? googleUser;
  final User? firebaseUser;

  Rute({required this.googleUser, required this.firebaseUser});

  @override
  _RuteState createState() => _RuteState();
}

class _RuteState extends State<Rute> {
  GoogleMapController? _mapController;
  LatLng _currentPosition = LatLng(-7.6333244, 111.5274847);  // Posisi saat ini
  LatLng _destination = LatLng(-7.6300, 111.5300);  // Lokasi tujuan (misalnya Bengkel A)
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};  // Set untuk menyimpan polyline
  DraggableScrollableController _scrollController = DraggableScrollableController();

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
      return Future.error('Layanan lokasi tidak aktif.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Izin lokasi ditolak');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Izin lokasi ditolak secara permanen.');
    }

    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
      _markers.add(
        Marker(
          markerId: MarkerId("currentLocation"),
          position: _currentPosition,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: "Lokasi Saya"),
        ),
      );
    });

    // Menambahkan polyline rute
    _addPolyline(_currentPosition, _destination);

    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: _currentPosition, zoom: 14.0),
      ),
    );
  }

  // Fungsi untuk menambahkan polyline (rute)
  void _addPolyline(LatLng start, LatLng end) {
    setState(() {
      _polylines.add(
        Polyline(
          polylineId: PolylineId("route"),
          visible: true,
          points: [start, end],  // Menyambungkan titik pengguna dan tujuan
          width: 5,
          color: Colors.blue,
        ),
      );
    });
  }

  // Fungsi untuk menangani klik peta dan memperbarui lokasi tujuan
  void _onMapTapped(LatLng tappedPoint) {
    setState(() {
      _destination = tappedPoint;  // Update lokasi tujuan dengan klik pengguna
      _markers.add(
        Marker(
          markerId: MarkerId("destination"),
          position: _destination,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: "Tujuan"),
        ),
      );

      // Menambahkan polyline rute
      _addPolyline(_currentPosition, _destination);
    });
  }

  void _toggleBottomSheet() {
    if (_scrollController.size > 0.1) {
      _scrollController.animateTo(0.1, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      _scrollController.animateTo(0.3, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Google Maps
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _currentPosition, zoom: 14.0),
            mapType: MapType.normal,
            myLocationEnabled: true,
            markers: _markers,
            polylines: _polylines,  // Menambahkan polyline ke peta
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
            },
            onTap: _onMapTapped,  // Menambahkan event tap untuk mengubah tujuan
            padding: EdgeInsets.only(bottom: 100),
          ),

          // Lokasi Terdekat Panel
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.1,
            maxChildSize: 0.5,
            controller: _scrollController,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF5B1010)),
                  color: Color(0xFFF4F2F2),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: _toggleBottomSheet,
                      ),
                    ),
                    _buildWorkshopCard(
                      name: 'Bengkel A',
                      address: 'Jln. Gerilya No.77',
                      rating: '4 (32)',
                      distance: '2,3 KM',
                      imagePath: 'assets/images/bengkel.jpeg',
                    ),
                    _buildActionButtons(context),
                    SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: 0, // Pastikan untuk mengirimkan index yang dipilih pertama
        onTap: (index) {
          // Tangani aksi navigasi bawah di sini
        },
        googleUser: widget.googleUser,
        firebaseUser: widget.firebaseUser,
      ),
    );
  }

  // Fungsi untuk membuat panel bengkel
  Widget _buildWorkshopCard({required String name, required String address, required String rating, required String distance, required String imagePath}) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 17),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF581717)),
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      padding: EdgeInsets.fromLTRB(10, 1, 15.2, 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(4, 0, 4, 16),
            child: Text(
              name,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Color(0xFF343232),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 13, 0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(imagePath),
                    ),
                  ),
                  height: 107,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Color(0xFF000000),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      rating,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Color(0xFF000000),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      distance,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: Color(0xFFC6BDBD),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

   Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            backgroundColor: Color(0xFFF4F2F2),
            side: BorderSide(color: Color(0xFF5B1010), width: 2),
          ),
          onPressed: () {
            Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DataKendaraanPage(
      googleUser: widget.googleUser, // Ganti googleUser dengan widget.googleUser
      firebaseUser: widget.firebaseUser, // Ganti firebaseUser dengan widget.firebaseUser
    ),
  ),
);

          },
          child: Text(
            'Service',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Color(0xFF5B1010),
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            backgroundColor: Color(0xFFF4F2F2),
            side: BorderSide(color: Color(0xFF5B1010), width: 2),
          ),
           onPressed: () {
          // Arahkan ke ChatPage
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(),
            ),
          );
        },
          child: Row(
            children: [
              Icon(Icons.chat, color: Color(0xFF5B1010)),
              SizedBox(width: 8),
              Text(
                'Chat',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Color(0xFF5B1010),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}