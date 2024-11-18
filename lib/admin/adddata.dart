import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddDataPage extends StatefulWidget {
  @override
  _AddDataPageState createState() => _AddDataPageState();
}

class _AddDataPageState extends State<AddDataPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  late GoogleMapController _mapController;
  LatLng _initialPosition = LatLng(-7.6298, 111.5239);
  LatLng? _selectedPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Lokasi Bengkel',
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
            children: [
              _buildTextField(_nameController, 'Nama Cabang'),
              SizedBox(height: 16),
              _buildTextField(_addressController, 'Alamat Lengkap'),
              SizedBox(height: 16),
              _buildCoordinateFields(),
              SizedBox(height: 16),
              _buildGoogleMap(),
              SizedBox(height: 16),
              _buildTextField(_phoneController, 'Nomor Telepon Cabang'),
              SizedBox(height: 16),
              _buildUploadPhotoField(),
              SizedBox(height: 32),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: const Color.fromARGB(255, 88, 9, 4)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: const Color.fromARGB(255, 107, 17, 10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: const Color.fromARGB(255, 117, 14, 6)),
        ),
      ),
    );
  }

  Widget _buildCoordinateFields() {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(_latitudeController, 'Latitude'),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _buildTextField(_longitudeController, 'Longitude'),
        ),
      ],
    );
  }

  Widget _buildGoogleMap() {
    return Container(
      height: 200,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 14.0,
        ),
        onMapCreated: (controller) {
          _mapController = controller;
        },
        onTap: (position) {
          setState(() {
            _selectedPosition = position;
            _latitudeController.text = position.latitude.toString();
            _longitudeController.text = position.longitude.toString();
          });
        },
        markers: _selectedPosition != null
            ? {
                Marker(
                  markerId: MarkerId('selected-location'),
                  position: _selectedPosition!,
                ),
              }
            : {},
      ),
    );
  }

  Widget _buildUploadPhotoField() {
    return GestureDetector(
      onTap: () {
        // Logika untuk unggah foto
        print("Unggah Foto ditekan");
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: const Color.fromARGB(255, 97, 14, 8)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Unggah Foto',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            Icon(Icons.upload_file, color: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Batal',
            style: GoogleFonts.poppins(
              color: Colors.red,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            side: BorderSide(color: Colors.red),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Logika simpan data
            print("Data disimpan");

            // Tampilkan dialog sukses
            showSuccessDialog(context);
          },
          child: Text(
            'Simpan',
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 45, 214, 39),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }

  void showSuccessDialog(BuildContext context) {
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
                'Terima Kasih!',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Data berhasil disimpan.',
                style: GoogleFonts.poppins(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Tutup dialog
                  Navigator.pop(context); // Kembali ke halaman sebelumnya
                },
                child: Text(
                  'Oke',
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
