import 'package:carfixer/booking/booking.dart';
import 'package:carfixer/maintenance/maintenance.dart';
import 'package:flutter/material.dart';
import 'package:carfixer/Page/dashboard.dart';
import 'package:carfixer/Page/notif.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final GoogleSignInAccount? googleUser; // Added variable
  final User? firebaseUser; // Added variable

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
  int _selectedIndex = 0; // Active page index

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex; // Initialize with the passed index
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigation logic based on the index
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NotificationPage(
          googleUser: widget.googleUser, // Kirim Google User
              firebaseUser: widget.firebaseUser
        )),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BookingPage(
          googleUser: widget.googleUser, // Kirim Google User
              firebaseUser: widget.firebaseUser
        )),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MaintenancePage(
          googleUser: widget.googleUser, // Kirim Google User
              firebaseUser: widget.firebaseUser
        )),
      );
    }
    widget.onTap(index); // Notify the parent
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
