import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';  // Untuk format tanggal
import 'package:carfixer/Page/datamobil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carfixer/Page/nav.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingPage extends StatefulWidget {
  final GoogleSignInAccount? googleUser;
  final User? firebaseUser;

  BookingPage({Key? key, required this.googleUser, required this.firebaseUser}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? _selectedDate;
  bool _isMaintenanceChecked = false;
  late GoogleMapController _mapController;

  static const LatLng _initialPosition = LatLng(-7.6298, 111.5239);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void showThankYouDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Terima Kasih'),
          content: Text('Booking Anda telah berhasil. Kami akan menghubungi Anda segera.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Booking Service'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari lokasi atau bengkel terdekat',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  height: 200,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _initialPosition,
                      zoom: 14.0,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _mapController = controller;
                    },
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => IsiDataKendaraanPage()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.directions_car),
                        SizedBox(width: 10),
                        Text('Data Mobil'),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 10),
                        Text(
                          _selectedDate == null
                              ? 'Pilih Tanggal Booking'
                              : DateFormat.yMMMd().format(_selectedDate!),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: _isMaintenanceChecked,
                        onChanged: (bool? newValue) {
                          setState(() {
                            _isMaintenanceChecked = newValue ?? false;
                          });
                        },
                      ),
                      Text('Maintenance'),
                      Spacer(),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                      backgroundColor: Color(0xFFF4F2F2),
                      side: BorderSide(color: Color(0xFF5B1010), width: 2),
                    ),
                    onPressed: () {
                      showThankYouDialog(context);
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
}
