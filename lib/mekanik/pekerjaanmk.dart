import 'package:flutter/material.dart';
import 'package:carfixer/mekanik/nav.dart';
import 'package:carfixer/mekanik/status.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';


class PekerjaanMekanikPage extends StatelessWidget {
  final List<Map<String, String>> orders1 = [
    {"serial": "WS2836RGFN", "description": "Ganti oli mesin"},
    {"serial": "XY1234HJKO", "description": "Perbaikan rem"},
    {"serial": "EF7890QWER", "description": "Pengecekan suspensi"},
  ];
 
 final GoogleSignInAccount? googleUser; // Tambahkan variabel ini
  final User? firebaseUser; // Tambahkan variabel ini

 PekerjaanMekanikPage({required this.googleUser, required this.firebaseUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pekerjaan Mekanik'),
        backgroundColor: Colors.white,
        elevation: 1,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: orders1.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 148, 24, 24),
                        child: Text(
                          '${index + 1}', // Show the item number instead of first letter
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(
                        'Pesanan : ${orders1[index]["serial"]}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(orders1[index]["description"]!),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                      onTap: () {
  // Define the order data here or retrieve it from your model
                            Map<String, String> order = {
                              'serial': '123456',  // Example serial number
                              // Add other keys if necessary
                            };

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StatusServicePage(
                                  order: order,
                                   googleUser: googleUser,
                                  firebaseUser: firebaseUser,
                                  ),  // Pass the order to the page
                              ));
                      },
                    ),
                  );
                },
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
