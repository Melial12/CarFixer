import 'package:flutter/material.dart';
import 'package:carfixer/Page/dashboard.dart';
import 'package:carfixer/Page/notif.dart';
import 'package:carfixer/booking/booking.dart';
import 'package:carfixer/maintenance/maintenance.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final GoogleSignInAccount? googleUser; 
  final User? firebaseUser; 

  BottomNavigationBarWidget({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    this.googleUser,
    this.firebaseUser,
  }) : super(key: key);

  @override
  _BottomNavMenuState createState() => _BottomNavMenuState();
}

class _BottomNavMenuState extends State<BottomNavigationBarWidget> {
  int _selectedIndex = 0; // Index halaman aktif

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex; // Inisialisasi dengan index yang diberikan
  }

 void _onItemTapped(int index) {
  if (index == _selectedIndex) return;

  setState(() {
    _selectedIndex = index;
  });

  if (index == 1) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NotificationPage(
        googleUser: widget.googleUser,
        firebaseUser: widget.firebaseUser,
      )),
    );
  } else if (index == 2) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BookingPage(
        googleUser: widget.googleUser,
        firebaseUser: widget.firebaseUser,
      )),
    );
  } else if (index == 3) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MaintenancePage(
        googleUser: widget.googleUser,
        firebaseUser: widget.firebaseUser,
      )),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notification',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Booking',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.build),
          label: 'Maintenance',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: Color.fromARGB(206, 84, 44, 9),
      unselectedItemColor: Colors.grey,
    );
  }
}
