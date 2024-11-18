import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carfixer/Page/nav.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carfixer/booking/booking.dart'; 
import 'package:carfixer/maintenance/detail.dart';

class MaintenancePage extends StatelessWidget {
  final GoogleSignInAccount? googleUser;
  final User? firebaseUser;

  MaintenancePage({required this.googleUser, required this.firebaseUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maintenance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.0), // Spasi di atas

            // Container untuk Tanggal, Detail Service, dan Tombol Booking
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.brown[300]!), // Border untuk kotak
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.transparent,
              ),
              child: Column(
                children: [
                  // Container untuk Tanggal
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.brown[300]!),
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        '11 September 2024', // Menampilkan tanggal saat ini
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0), // Spasi di antara kontainer

                  // Container untuk Detail Service
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.brown[300]!),
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                         Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailServicePage()),
                      );

                        },
                        child: Text(
                          'Detail Service',
                          style: TextStyle(fontSize: 16, color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0), // Spasi di antara kontainer dan tombol

                  // Tombol Booking
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                      backgroundColor: Color(0xFFF4F2F2),
                      side: BorderSide(color: Color(0xFF5B1010), width: 2),
                    ),
                    onPressed: () {
                      // Arahkan ke halaman BookingPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BookingPage(
                          googleUser: googleUser,
                          firebaseUser: firebaseUser,
                        )),
                      );
                    },
                    child: Text(
                      'Booking',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Color(0xFF5B1010),
                      ),
                    ),
                  ),
                ],
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