import 'package:flutter/material.dart';
import 'package:carfixer/Page/nav.dart'; 
import 'package:carfixer/Page/profil.dart';
import 'package:carfixer/Page/pantau.dart'; // Assuming this is where PantauServicePage is defined
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';


class NotificationPage extends StatelessWidget {
   final GoogleSignInAccount? googleUser; // Tambahkan variabel ini
  final User? firebaseUser; // Tambahkan variabel ini

  NotificationPage({required this.googleUser, required this.firebaseUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NOTIFICATION"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
              // Tambahkan aksi pesan di sini
            },
          ),
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
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            NotificationItem(
              status: 'Pesanan Diproses',
              description: 'Pesanan AR62UOW090 sedang diproses di bengkel pilihanmu.',
              icon: Icons.autorenew,
              backgroundColor: Colors.brown[300] ?? Colors.brown,
              onTap: () {
                // Navigate to PantauServicePage when tapped
                Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PantauServicePage(
              googleUser: googleUser, // Kirim Google User
              firebaseUser: firebaseUser, // Kirim Firebase User
            ),
          ),);
              },
            ),
            SizedBox(height: 20),
            NotificationItem(
              status: 'Pesanan Siap',
              description: 'Pesanan AR62UOW091 sudah siap diambil.',
              icon: Icons.check_circle,
              backgroundColor: Colors.green[300] ?? Colors.green,
              onTap: () {
                // Action when the second item is clicked (if any)
              },
            ),
            // Tambahkan lebih banyak NotificationItem jika perlu
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
 // Ini harus menjadi bagian dari Scaffold.
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String status;
  final String description;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback? onTap; // Add a callback for the tap event

  NotificationItem({
    required this.status,
    required this.description,
    required this.icon,
    required this.backgroundColor,
    this.onTap, // Callback is optional
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Trigger the onTap callback when the item is tapped
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              icon, // Ikon Material
              size: 40,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    status,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
