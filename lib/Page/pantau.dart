import 'package:flutter/material.dart';
import 'package:carfixer/Page/nav.dart';
import 'package:carfixer/Page/notfix.dart';
import 'package:carfixer/Page/dashboard.dart';
import 'package:carfixer/Page/biomekanik.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';  // Import ini untuk TapGestureRecognizer

class PantauServicePage extends StatelessWidget {
  final GoogleSignInAccount? googleUser; // Tambahkan variabel Google User
  final User? firebaseUser; // Tambahkan variabel Firebase User

  PantauServicePage({required this.googleUser, required this.firebaseUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        title: Text('Pantau Service'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text:
                    'Pesanan anda sedang ditangani oleh SA Dian dan dikerjakan oleh ',
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(
                    text: 'mekanik Wawan',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Arahkan ke halaman BiomekanikPage ketika teks diklik
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BiodataMekanikPage(
                              googleUser: googleUser, // Mengirim Google User
                              firebaseUser: firebaseUser,
                            ), // Halaman tujuan
                          ),
                        );
                      },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            _buildTimeline(),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                     Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotFixPage(
                              googleUser: googleUser,
                              firebaseUser: firebaseUser,
                            ), 
                          ),
                        );
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey, 
                    padding: EdgeInsets.symmetric(horizontal: 40),
                  ),
                  child: Text('Not Fix'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    // Menampilkan pop-up ketika tombol 'Fix' ditekan
                    _showThankYouDialog(context); // Panggil fungsi dialog
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Warna tombol 'Fix'
                    padding: EdgeInsets.symmetric(horizontal: 40),
                  ),
                  child: Text('Fix'),
                ),
              ],
            ),
            SizedBox(height: 30),
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

  // Widget untuk membuat timeline
  Widget _buildTimeline() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0), // Padding kiri
      child: Column(
        children: [
          _buildTimelineStep('Menunggu Dikerjakan', true),
          _buildTimelineStep('Dikerjakan Mekanik', false),
          _buildTimelineStep('Job Stop', false),
          _buildTimelineStep('Final Test', false),
          _buildTimelineStep('Proses Pencucian', false),
          _buildTimelineStep('Penyerahan Kendaraan', false),
        ],
      ),
    );
  }

  // Widget untuk setiap langkah pada timeline
  Widget _buildTimelineStep(String title, bool isActive) {
    return Row(
      children: [
        Column(
          children: [
            Icon(
              Icons.circle,
              color: isActive ? Colors.green : Colors.grey,
              size: 20,
            ),
            Container(
              height: 70,
              width: 2,
              color: Colors.grey,
            ),
          ],
        ),
        SizedBox(width: 16),
        Text(
          title,
          style: TextStyle(
            color: isActive ? Colors.green : Colors.grey,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

 void _showThankYouDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        title: Center(
          child: Icon(
            Icons.check_circle_outline,
            color: Colors.green,
            size: 60,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Terima Kasih!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Terima kasih sudah service di bengkel kami. Kami berharap kendaraan Anda segera kembali dalam kondisi baik.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Dashboard(), // Arahkan ke DashboardPage
                  ),
                );
              },
              child: Text('Tutup'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
            ),
          ],
        ),
      );
    },
  );
}

}