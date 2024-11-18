import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carfixer/Page/loginscreen.dart';
import 'package:carfixer/Services/auth_services.dart';
import 'package:carfixer/Services/globals.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

class Registerscreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<Registerscreen> {
  bool _showPassword = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController(); // Added name controller

  void errorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/login.png',
                  width: 500,
                  height: 400,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Register',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              // Input Name
              Row(
                children: [
                  Icon(Icons.person, color: Color(0xFF6D1D1D)),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Input Email
              Row(
                children: [
                  Icon(Icons.email, color: Color(0xFF6D1D1D)),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Input Password
              Row(
                children: [
                  Icon(Icons.lock, color: Color.fromARGB(255, 122, 43, 9)),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _passwordController,
                      obscureText: !_showPassword,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _showPassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Input Confirm Password
              Row(
                children: [
                  Icon(Icons.lock, color: Color.fromARGB(255, 122, 43, 9)),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _confirmPasswordController,
                      obscureText: true, // Confirm password field hidden by default
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    backgroundColor: Color.fromARGB(255, 122, 43, 9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () async {
                    // Validasi input form
                    if (_nameController.text.isNotEmpty &&
                        _emailController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty &&
                        _passwordController.text == _confirmPasswordController.text) {
                      
                      // Panggil AuthService untuk registrasi
                      final response = await AuthServices.register(
                        _nameController.text,
                        _emailController.text,
                        _passwordController.text,
                      );

                      if (response.statusCode == 200) {
                        // Jika registrasi berhasil, simpan data ke SharedPreferences
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setString('name', _nameController.text);
                        await prefs.setString('email', _emailController.text);
                        
                        // Arahkan ke halaman login
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(), // Arahkan ke halaman login
                          ),
                        );
                      } else {
                        errorSnackBar(context, 'Registration failed: ${jsonDecode(response.body)['message']}');
                      }
                    } else {
                      // Jika validasi gagal
                      errorSnackBar(context, 'Please fill all fields correctly.');
                    }
                  },
                  child: Text(
                    'Register',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Already have an account? Login Here",
                    style: GoogleFonts.poppins(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
