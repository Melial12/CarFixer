import 'package:flutter/material.dart';

class TambahMK extends StatelessWidget {
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
          'Tambah Mekanik',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(  // Membungkus body dengan SingleChildScrollView
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField('Kode'),
              _buildTextField('Nama Lengkap'),
              _buildTextField('Alamat'),
              _buildTextField('Kota'),
              _buildTextField('Handphone'),
              _buildTextField('Email'),
              _buildTextField('Password', obscureText: true),
              _buildTextField('Keahlian'),
              _buildTextField('Catatan'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton(context, 'Batal', Colors.white, const Color.fromARGB(255, 107, 19, 12)),
                  SizedBox(width: 20),
                  _buildButton(context, 'Simpan', Colors.red, Colors.white),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: const Color.fromARGB(255, 110, 14, 8)),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: const Color.fromARGB(255, 126, 13, 5)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String label, Color bgColor, Color textColor) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          if (label == 'Batal') {
            Navigator.pop(context);
          } else {
            // Menampilkan pop-up setelah tombol Simpan diklik
            _showThankYouDialog(context);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          side: BorderSide(color: const Color.fromARGB(255, 124, 20, 12)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(vertical: 10),
        ),
        child: Text(label, style: TextStyle(fontSize: 16)),
      ),
    );
  }

  // Fungsi untuk menampilkan pop-up
  void _showThankYouDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Mencegah menutup dialog dengan mengetuk di luar
      builder: (context) {
        return AlertDialog(
          title: Text('Terima Kasih'),
          content: Text('Data Mekanik berhasil ditambahkan.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Menutup dialog
                Navigator.pop(context); // Kembali ke halaman sebelumnya
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
