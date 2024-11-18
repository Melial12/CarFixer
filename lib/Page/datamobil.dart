import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carfixer/Page/maps.dart';

class IsiDataKendaraanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DATA MOBIL',
          style: GoogleFonts.getFont('Poppins'),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField('Nama Pemilik Mobil'),
              _buildTextField('Nomor Polisi (Plat Nomor)'),
              _buildTextField('Nomor RFID'),
              _buildTextField('Type'),
              _buildTextField('Model'),
              _buildTextField('Tahun Pembentukan'),
              _buildTextField('Silinder'),
              _buildTextField('Warna'),
              _buildTextField('Nama Rangka'),
              _buildTextField('Nomor Mesin'),
              _buildTextField('Catatan'),
              SizedBox(height: 20), // Tambahkan jarak sebelum Unggah Kondisi Mobil
              _buildUploadCondition(),
              SizedBox(height: 30), // Tambahkan jarak sebelum tombol SIMPAN
              Center( // Tambahkan Center di sini
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
                    _showConfirmationDialog(context);
                  },
                  child: Text(
                    'SIMPAN',
                    style: GoogleFonts.getFont(
                      'Poppins',
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
    );
  }

  Widget _buildTextField(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF5B1010), width: 2.0),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadCondition() {
    return GestureDetector(
      onTap: () {
        // Logika untuk mengunggah kondisi mobil
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Unggah Kondisi Mobil',
                style: GoogleFonts.getFont(
                  'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              Icon(Icons.upload_file, color: Color(0xFF5B1010)),
            ],
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Data telah disimpan. Apa yang ingin Anda lakukan selanjutnya?'),
          actions: [
            TextButton(
              onPressed: () {
                // Logika untuk navigasi ke rute
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FullMapPage()),
                );
              },
              child: Text('RUTE'),
            ),
            TextButton(
              onPressed: () {
                // Logika untuk navigasi ke rute
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FullMapPage()),
                );
              },
              child: Text('PICK UP'),
            ),
          ],
        );
      },
    );
  }
}
