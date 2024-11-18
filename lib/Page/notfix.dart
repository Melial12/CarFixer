import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carfixer/Page/nav.dart';
import 'package:carfixer/Page/profil.dart';


class NotFixPage extends StatefulWidget {
  final GoogleSignInAccount? googleUser; // Tambahkan variabel ini
  final User? firebaseUser; // Tambahkan variabel ini

  NotFixPage({required this.googleUser, required this.firebaseUser});
  @override
  _NotFixPageState createState() => _NotFixPageState();
}

class _NotFixPageState extends State<NotFixPage> {
  String? selectedProblem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Not Fix',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.chat_bubble_outline, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person_outline, color: Colors.black),
            onPressed: () {
              Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(
                              googleUser: widget.googleUser, // Mengirim Google User
                              firebaseUser: widget.firebaseUser, // Mengirim Firebase User
                            ),
                          ),
                        );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sampaikan kendala atau masalah yang belum selesai terkait kendaraan Anda.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                _showProblemDialog(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(selectedProblem ?? 'Masalah Kendaraan'),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Jelaskan masalah yang belum terselesaikan',
              ),
              maxLines: 4,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                  onPressed: () {
                    // Hubungi Admin action
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.brown),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Hubungi Admin',
                    style: TextStyle(color: Colors.brown),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    // Fixation action
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.brown),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Fixation',
                    style: TextStyle(color: Colors.brown),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(
        currentIndex: 0, // Ensure you pass the initial selected index
        onTap: (index) {
          // Handle bottom navigation actions here
        },
        googleUser: widget.googleUser,
        firebaseUser: widget.firebaseUser,
      ),);
  }

  void _showProblemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Pilih Masalah Kendaraan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text('Mesin tidak menyala'),
                  onTap: () {
                    setState(() {
                      selectedProblem = 'Mesin tidak menyala';
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Rem tidak berfungsi'),
                  onTap: () {
                    setState(() {
                      selectedProblem = 'Rem tidak berfungsi';
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Transmisi bermasalah'),
                  onTap: () {
                    setState(() {
                      selectedProblem = 'Transmisi bermasalah';
                    });
                    Navigator.pop(context);
                  },
                ),
                // Tambahkan masalah kendaraan lainnya sesuai kebutuhan
              ],
            ),
          ),
        );
      },
    );
  }
}
