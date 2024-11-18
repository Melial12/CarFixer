import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FullMapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Widget peta yang memenuhi layar
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              // Logika untuk peta
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(-7.6298, 111.5239), // Ganti dengan koordinat awal
              zoom: 14.0,
            ),
          ),
          // AppBar transparan
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              title: Text('Peta'),
              backgroundColor: Colors.transparent, // Membuat background transparan
              elevation: 0, // Menghilangkan bayangan
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black), // Warna ikon
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
