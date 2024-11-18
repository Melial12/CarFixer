import 'package:flutter/material.dart';
import 'package:carfixer/admin/dashboar.dart'; // Sesuaikan dengan nama halaman lain yang kamu miliki
import 'package:carfixer/admin/notif.dart';
import 'package:carfixer/admin/pilihmk.dart';
import 'package:carfixer/mekanik/awal.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final GoogleSignInAccount? googleUser; // Tambahkan variabel ini
  final User? firebaseUser; // Tambahkan variabel ini

  BottomNavigationBarWidget({required this.googleUser, required this.firebaseUser}); // Tambahkan konstruktor ini

  @override
  _BottomNavMenuState createState() => _BottomNavMenuState();
}

class _BottomNavMenuState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0; // Indeks halaman yang aktif

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Ubah indeks aktif
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPage(
              googleUser: widget.googleUser, // Kirim Google User
              firebaseUser: widget.firebaseUser, // Kirim Firebase User
            ),
          ),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NotificationPage(
            googleUser: widget.googleUser, // Kirim Google User
              firebaseUser: widget.firebaseUser
          )),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AddMechanicPage(
            googleUser: widget.googleUser, // Kirim Google User
              firebaseUser: widget.firebaseUser
          )),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MechanicPage(
            googleUser: widget.googleUser, // Kirim Google User
              firebaseUser: widget.firebaseUser
          )),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 2, // Tinggi garis atas
          color: Color.fromARGB(255, 122, 43, 9), // Warna garis atas
        ),
        BottomAppBar(
          color: Colors.white, // Set background menu to white
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildIconButton(Icons.home, 0),
              _buildIconButton(Icons.notifications, 1),
              _buildIconButton(Icons.person, 2),
              _buildIconButton(Icons.build, 3),
            ],
          ),
        ),
        Container(
          height: 2, // Tinggi garis bawah
          color: Color.fromARGB(255, 122, 43, 9), // Warna garis bawah
        ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, int index) {
    final isSelected = _selectedIndex == index; // Cek apakah ikon aktif

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: isSelected ? 50 : 30, // Ukuran saat aktif
          width: isSelected ? 50 : 30, // Ukuran saat aktif
          child: IconButton(
            icon: Icon(
              icon,
              color: isSelected ? Color.fromARGB(255, 122, 43, 9) : Colors.black, // Ganti warna jika aktif
              size: isSelected ? 33 : 27, // Ukuran ikon saat aktif
            ),
            onPressed: () => _onItemTapped(index),
          ),
        ),
        if (isSelected)
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 122, 43, 9), // Warna garis di bawah ikon aktif
              borderRadius: BorderRadius.circular(2),
            ),
          ),
      ],
    );
  }
}
