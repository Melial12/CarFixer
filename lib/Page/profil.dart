import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carfixer/Page/loginscreen.dart'; // Import LoginScreen
import 'package:carfixer/Page/nav.dart'; 
import 'package:carfixer/Page/dashboard.dart'; // Pastikan untuk mengimpor Dashboard

class ProfilePage extends StatefulWidget {
  final GoogleSignInAccount? googleUser;
  final User? firebaseUser;

  ProfilePage({required this.googleUser, required this.firebaseUser});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil', style: GoogleFonts.poppins()),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Dashboard(
                  googleUser: widget.googleUser,
                  firebaseUser: widget.firebaseUser,
                ),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Baris untuk Foto Profil dan Ikon Edit
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(widget.googleUser?.photoUrl ?? ''),
                    ),
                    SizedBox(width: 10),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.black), // Warna ikon edit
                      onPressed: () {
                        // Tambahkan fungsi untuk mengedit profil jika diperlukan
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Container untuk Nama Pengguna
                _buildInfoContainer(
                  'Nama: ${widget.googleUser?.displayName ?? ''}',
                  false, // Tombol edit tidak ada di sini
                ),
                SizedBox(height: 10),
                // Container untuk Email Pengguna
                _buildInfoContainer(
                  'Email: ${widget.googleUser?.email ?? ''}',
                  false, // Tombol edit tidak ada di sini
                ),
                SizedBox(height: 20),
                // Tombol Logout
                ElevatedButton(
                  onPressed: () async {
                    // Logout dari Google dan Firebase
                    await GoogleSignIn().signOut();
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Gunakan backgroundColor
                  ),
                  child: Text('Logout'),
                ),
              ],
            ),
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

  Widget _buildInfoContainer(String text, bool hasEditButton) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.poppins(fontSize: 20, color: const Color.fromARGB(255, 94, 39, 39)),
              textAlign: TextAlign.start,
            ),
          ),
          if (hasEditButton)
            IconButton(
              icon: Icon(Icons.edit, color: Colors.white),
              onPressed: () {
                // Tambahkan fungsi untuk mengedit profil jika diperlukan
              },
            ),
        ],
      ),
    );
  }
}
