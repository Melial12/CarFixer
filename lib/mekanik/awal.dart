import 'package:flutter/material.dart';
import 'package:carfixer/mekanik/pekerjaanmk.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MechanicPage extends StatelessWidget {
  final GoogleSignInAccount? googleUser; // Tambahkan variabel ini
  final User? firebaseUser; // Tambahkan variabel ini

 MechanicPage({required this.googleUser, required this.firebaseUser});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(213, 216, 168, 126), 
      body: SafeArea(
        child: Column(
          children: [
          
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/logo.png', // Replace with your logo path
                    height: 150,
                  ),
                  Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            Spacer(),
          
            Image.asset(
              'assets/images/orang.png', 
              height: 400, 
            ),
            Spacer(),
          
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF542C09),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                onPressed: () {
              Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PekerjaanMekanikPage(
                            googleUser: googleUser,
                           firebaseUser: firebaseUser,
                          ), // Replace with your biomekanik page
                        ),
                      );
                },
                child: Text(
                  'PEKERJAAN MEKANIK',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
