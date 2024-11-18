import 'dart:convert'; // Import untuk jsonDecode
import 'package:firebase_auth/firebase_auth.dart'; // Tambahkan ini
import 'package:firebase_core/firebase_core.dart'; // Tambahkan ini
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:carfixer/Page/profil.dart'; // Pastikan untuk mengimpor halaman profil
import 'package:carfixer/Page/regscreen.dart';
import 'package:carfixer/admin/dashboar.dart';
import 'package:carfixer/Services/auth_services.dart'; // Import AuthServices
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Memastikan Flutter telah diinisialisasi
  await Firebase.initializeApp(); // Inisialisasi Firebase
  runApp(MyApp()); // Memulai aplikasi
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  GoogleSignInAccount? _currentUser; // Untuk menangani Google user

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  // Metode Google sign-in
  Future<void> _handleGoogleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // Pengguna membatalkan login

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Gunakan FirebaseAuth untuk login dengan kredensial Google
      await FirebaseAuth.instance.signInWithCredential(credential);

      setState(() {
        _currentUser = googleUser;
      });

      // Pindah ke halaman profil setelah login sukses
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            googleUser: googleUser, // Meneruskan GoogleSignInAccount ke halaman profil
            firebaseUser: FirebaseAuth.instance.currentUser, // Meneruskan Firebase User
          ),
        ),
      );
    } catch (error) {
      print('Google Sign-In Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login gagal: $error')),
      );
    }
  }

  bool _isLoading = false;

  Future<void> _handleEmailSignIn() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Silakan masukkan email dan password.')),
      );
      return;
    }

    setState(() {
      _isLoading = true; // Tampilkan loading
    });

    try {
      // Call your AuthServices for login
      final response = await AuthServices.login(
        _emailController.text,
        _passwordController.text,
      );

      if (response.statusCode == 200) {
        // Login sukses, pindah ke halaman profil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPage(
              googleUser: null, // Google User tidak ada
              firebaseUser: FirebaseAuth.instance.currentUser, // Meneruskan Firebase User
            ),
          ),
        );
      } else {
        // Tampilkan pesan error jika login gagal
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login gagal: ${jsonDecode(response.body)['message']}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false; // Sembunyikan loading
      });
    }
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
                'Login',
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              // Input Email dengan underline dan icon
              Row(
                children: [
                  Icon(Icons.email, color: Color.fromARGB(255, 122, 43, 9)),
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
              // Input Password dengan underline dan icon
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
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _showPassword,
                    onChanged: (bool? value) {
                      setState(() {
                        _showPassword = value ?? false;
                      });
                    },
                  ),
                  Text('Show Password'),
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
                  onPressed: _handleEmailSignIn, // Panggil fungsi sign-in email
                  child: Text(
                    'Login dengan Email',
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
                      MaterialPageRoute(builder: (context) => Registerscreen()),
                    );
                  },
                  child: Text(
                    "Don't have an account? Register Here",
                    style: GoogleFonts.poppins(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Tombol Google Sign-In
              
              Center(
  child: InkWell(
    onTap: _handleGoogleSignIn, // Panggil fungsi Google sign-in
    child: Material(
      elevation: 0, // Menghilangkan elevasi untuk tampilan datar
      borderRadius: BorderRadius.circular(20), // Membulatkan sudut
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 231, 224, 221), // Warna latar belakang
          borderRadius: BorderRadius.circular(20), // Membulatkan sudut
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [          
            FaIcon(
              FontAwesomeIcons.google, // Ikon Google dari Font Awesome
              color: const Color.fromARGB(255, 226, 38, 38), // Warna ikon
              size: 24, // Ukuran ikon
            ),
            SizedBox(width: 10), // Spasi antara ikon dan teks
            Text(
              'Login dengan Google',
              style: GoogleFonts.poppins(
                color: const Color.fromARGB(255, 236, 15, 15),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
),

              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
