import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carfixer/admin/pilihmk.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailOrderPage extends StatefulWidget {
    final GoogleSignInAccount? googleUser; // Tambahkan variabel ini
  final User? firebaseUser; // Tambahkan variabel ini

  DetailOrderPage({required this.googleUser, required this.firebaseUser});
  @override
  _DetailOrderPageState createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Pesanan',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Nama Pemilik Mobil', 'xxxxx'),
              _buildDetailRow('Nomor Polisi', 'xxxxx'),
              _buildDetailRow('Nomor RFID', 'xxxxx'),
              _buildDetailRow('Type', 'xxxxx'),
              _buildDetailRow('Model', 'xxxxx'),
              _buildDetailRow('Tahun Pembuatan', 'xxxxx'),
              _buildDetailRow('Silinder', 'xxxxx'),
              _buildDetailRow('Warna', 'xxxxx'),
              _buildDetailRow('Nomor Rangka', 'xxxxx'),
              _buildDetailRow('Nomor Mesin', 'xxxxx'),
              _buildDetailRow('Catatan', 'xxxxx'),
              SizedBox(height: 20),
              _buildConditionSection(),
              SizedBox(height: 20),
              _buildNoteForm(),
              SizedBox(height: 20),
              _buildAcceptButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildConditionSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          SizedBox(width: 8),
          Text(
            'Kondisi Mobil',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            Icons.car_repair, // Ganti dengan ikon yang sesuai
            color: Colors.blue,
            size: 40,
          ),
        ],
      ),
      SizedBox(height: 10),
    ],
  );
}

  Widget _buildNoteForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Catatan Baru',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        TextFormField(
          controller: _noteController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Tambahkan catatan baru...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAcceptButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          _showSuccessDialog(context);
        },
        child: Text(
          'Terima',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 60,
              ),
              SizedBox(height: 16),
              Text(
                'Pesanan Diterima',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Pesanan berhasil diterima. Anda dapat melanjutkan proses berikutnya.',
                style: GoogleFonts.poppins(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddMechanicPage(
                              googleUser: widget.googleUser, 
                              firebaseUser: widget.firebaseUser, 
                            ),
                          ),
                        );
                },
                child: Text(
                  'Pilih Mekanik',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
