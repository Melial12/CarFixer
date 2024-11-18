import 'package:flutter/material.dart';
import 'package:carfixer/admin/biomk.dart';
import 'package:carfixer/admin/addmk.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carfixer/admin/nav.dart'; 

class AddMechanicPage extends StatelessWidget {
  final GoogleSignInAccount? googleUser; // Tambahkan variabel ini
  final User? firebaseUser; // Tambahkan variabel ini

  AddMechanicPage({required this.googleUser, required this.firebaseUser});
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Pilih Mekanik',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Silakan pilih mekanik yang akan menangani pesanan ini',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 4, // Replace with dynamic mechanic list length
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BiodataMekanikPage(
                            googleUser: googleUser, 
                              firebaseUser: firebaseUser, 
                          ), // Replace with your biomekanik page
                        ),
                      );
                    },
                    child: MechanicCard(
                      name: 'XXXXXXXXX',
                      status: index % 2 == 0 ? 'Tersedia' : 'Sedang Bekerja',
                      isAvailable: index % 2 == 0,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TambahMK(
                            
                          ), // Replace with your biomekanik page
                        ),
                      );
              },
              icon: Icon(Icons.add),
              label: Text("ADD"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Background color
                foregroundColor: Colors.red, // Text and icon color
                side: BorderSide(color: Colors.red), // Border color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        googleUser: googleUser,
        firebaseUser: firebaseUser,
      ),
    );
  }
}

class MechanicCard extends StatelessWidget {
  final String name;
  final String status;
  final bool isAvailable;

  MechanicCard({required this.name, required this.status, required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: isAvailable ? Colors.green : Colors.red),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[300], // Background color for the icon
            child: Icon(
              Icons.person, // Person icon
              size: 40,
              color: Colors.grey[700], // Icon color
            ),
          ),
          SizedBox(height: 10),
          Text(name, style: TextStyle(fontSize: 16)),
          SizedBox(height: 5),
          Text(
            status,
            style: TextStyle(
              color: isAvailable ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

