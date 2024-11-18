import 'package:flutter/material.dart';

class DetailServicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Service'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Menambahkan warna AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul dan informasi mobil
              Text('Nama Pemilik Mobil: xxxxx', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Nomor Polisi: xxxxx', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('Nomor RFID: xxxxx', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('Tipe: xxxxx', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('Model: xxxxx', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('Tahun Pembuatan: xxxxx', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('Silinder: xxxxx', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('Warna: xxxxx', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('Nomor Rangka: xxxxx', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('Nomor Mesin: xxxxx', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('Catatan: xxxxx', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('Status: Selesai', style: TextStyle(fontSize: 16)),
              
              // Kondisi Mobil - Bisa diklik untuk melihat detail
              SizedBox(height: 16),
              Text('Kondisi Mobil', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              _buildKondisiMobil(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKondisiMobil(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Kondisi Sebelum
        GestureDetector(
          onTap: () {
            _showKondisiDialog(context, "Sebelum");
          },
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Icon(Icons.accessibility_new, color: Colors.blue, size: 30),
                  SizedBox(width: 10),
                  Text('Kondisi Sebelum', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 12),

        // Kondisi Sesudah
        GestureDetector(
          onTap: () {
            _showKondisiDialog(context, "Sesudah");
          },
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Icon(Icons.accessibility_new, color: Colors.green, size: 30),
                  SizedBox(width: 10),
                  Text('Kondisi Sesudah', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Dialog untuk melihat kondisi sebelum dan sesudah
  void _showKondisiDialog(BuildContext context, String kondisi) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Kondisi Mobil: $kondisi'),
          content: Text('Detail kondisi mobil $kondisi akan ditampilkan di sini.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
}
