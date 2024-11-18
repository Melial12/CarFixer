import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carfixer/Page/nav.dart';
import 'package:carfixer/Page/profil.dart';
import 'package:carfixer/Page/datamobil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataKendaraanPage extends StatelessWidget {
  final GoogleSignInAccount? googleUser; // Tambahkan variabel ini
  final User? firebaseUser; // Tambahkan variabel ini

  DataKendaraanPage({required this.googleUser, required this.firebaseUser}); // Tambahkan konstruktor ini

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DATA MOBIL',
          style: GoogleFonts.getFont('Poppins'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
                        // Navigasi ke halaman profil dengan data pengguna
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(
                              googleUser: googleUser, // Mengirim Google User
                              firebaseUser: firebaseUser, // Mengirim Firebase User
                            ),
                          ),
                        );
                      },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.sentiment_dissatisfied,
              size: 100,
              color: Colors.black,
            ),
            SizedBox(height: 20),
            Text(
              'Data Kendaraan Kosong!!!',
              style: GoogleFonts.getFont(
                'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF5B1010), // Warna tombol
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IsiDataKendaraanPage(),
                  ),
                ); // Navigasi ke halaman Isi Data Kendaraan
              },
              child: Text(
                'Isi Data Kendaraan',
                style: GoogleFonts.getFont(
                  'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
     bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: 0, // Ensure you pass the initial selected index
        onTap: (index) {
          // Handle bottom navigation actions here
        },
        googleUser: googleUser,
        firebaseUser: firebaseUser,
      ),
    );
  }
}
