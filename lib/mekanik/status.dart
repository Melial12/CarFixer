import 'dart:async';
import 'package:flutter/material.dart';
import 'package:carfixer/mekanik/pekerjaanmk.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StatusServicePage extends StatelessWidget {
  final Map<String, String> order;
  final GoogleSignInAccount? googleUser;
  final User? firebaseUser;

  StatusServicePage({
    required this.googleUser,
    required this.firebaseUser,
    required this.order,
  });

  // Variabel Timer
  Timer? _timer;
  Duration _timeElapsed = Duration();
  bool isRunning = false;

  // Fungsi memulai timer
  void _startTimer(void Function(void Function()) setState) {
    if (!isRunning) {
      isRunning = true;
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _timeElapsed += Duration(seconds: 1);
        });
      });
    }
  }

  // Fungsi menghentikan dan mereset timer
  void _resetTimer(void Function(void Function()) setState) {
    _timer?.cancel();
    setState(() {
      _timeElapsed = Duration();
      isRunning = false;
    });
  }

  // Fungsi format waktu
  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  // Dialog Detail dengan Timer
  void _showDetailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.grey.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              title: Center(
                child: Text(
                  'DETAIL',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Table(
                    border: TableBorder.all(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    columnWidths: const {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(2),
                    },
                    children: [
                      TableRow(
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Action',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Waktu',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.play_circle_fill),
                                  color: Colors.brown,
                                  iconSize: 32,
                                  onPressed: () {
                                    _startTimer(setState);
                                  },
                                ),
                                SizedBox(width: 10),
                                IconButton(
                                  icon: Icon(Icons.restart_alt),
                                  color: Colors.brown,
                                  iconSize: 32,
                                  onPressed: () {
                                    _resetTimer(setState);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Text(
                              _formatTime(_timeElapsed),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "TUTUP",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }


void _showSuggestionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.grey.shade300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        title: Center(
          child: Text(
            'PENYERAHAN',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                labelText: 'SARAN:',
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.brown),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.brown, width: 2.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PekerjaanMekanikPage(
                        googleUser: googleUser, // Kirim Google User
                        firebaseUser:firebaseUser, // Kirim Firebase User
                      ),
                    ),
                  );
                },
                child: Text(
                  "SIMPAN",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 112, 18, 18),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "TUTUP",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade700,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status Service'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'No Pol ${order["serial"]}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),

            // Tombol PROSES
            OutlinedButton(
              onPressed: () => _showDetailDialog(context),
              child: Text(
                "PROSES",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.green),
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Tombol FINAL TEST
            OutlinedButton(
               onPressed: () => _showDetailDialog(context),
              child: Text(
                "FINAL TEST",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.black),
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Tombol JOB STOP
            OutlinedButton(
               onPressed: () => _showDetailDialog(context),
              child: Text(
                "JOB STOP",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.black),
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Tombol PROSES PENCUCIAN
            OutlinedButton(
               onPressed: () => _showDetailDialog(context),
              child: Text(
                "PROSES PENCUCIAN",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.black),
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Tombol PENYERAHAN
            OutlinedButton(
              onPressed: () => _showSuggestionDialog(context),
              child: Text(
                "PENYERAHAN",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.black),
                padding: EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
