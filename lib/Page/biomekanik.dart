import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carfixer/Page/nav.dart';

class BiodataMekanikPage extends StatelessWidget {
   final GoogleSignInAccount? googleUser; // Tambahkan variabel ini
  final User? firebaseUser; // Tambahkan variabel ini

  BiodataMekanikPage({required this.googleUser, required this.firebaseUser});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Biodata Mekanik"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card for Mechanic Info
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Mechanic Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                      'assets/images/on.png', // Pastikan gambar sudah berada di folder assets
                      width: 100,  // Ganti width dan height sesuai ukuran gambar yang diinginkan
                      height: 100,
                      fit: BoxFit.cover,
                    ),

                    ),
                    SizedBox(width: 16),
                    // Mechanic Details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Muhammad Setia Budi',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 18),
                            SizedBox(width: 4),
                            Text('4.5/5', style: TextStyle(fontSize: 14)),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          '37 thn',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // Status
            Row(
              children: [
                Text(
                  'Status',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Tersedia',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Mechanic Specifications
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Spesialisasi', 'Mesin'),
                    _buildInfoRow('Pengalaman', '5 Tahun'),
                    _buildInfoRow('Pekerjaan Selesai', '120'),
                    _buildInfoRow('Sertifikasi', 'Mesin Level 3'),
                    _buildInfoRow('Shift Kerja', '08:00 - 16:00',
                        highlight: true, highlightColor: Colors.green),
                    _buildInfoRow('Kontak', '0812-xxxx-xxxx',
                        highlight: true, highlightColor: Colors.blue),
                    _buildInfoRow('Cabang', 'Madiun'),
                  ],
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

  // Helper method to build rows of information
  Widget _buildInfoRow(String label, String value,
      {bool highlight = false, Color highlightColor = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14)),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
              color: highlight ? highlightColor : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
