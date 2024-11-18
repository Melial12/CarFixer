import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carfixer/Page/loginscreen.dart';
import 'package:carfixer/Page/regscreen.dart';




class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  bool _isHoveredLogin = false;
  bool _isHoveredSignUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 120, 24, 45),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top-left logo
                Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'assets/images/logo2.png',
                    width: 100,
                    height: 100,
                  ),
                ),
                SizedBox(height: 0), // Space between logo and text

                // Main headline text
                Text(
                  'Quick and Efficient Automotive Solutions',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w800,
                    fontSize: 27,
                    color: Color(0xFF000000),
                  ),
                ),
                SizedBox(height: 0), // Space between text and buttons

                // Positioned image
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/start.png',
                    width: 338,
                    height: 326,
                  ),
                ),
                SizedBox(height: 0), // Space between image and buttons

                // Login button
                Align(
                  alignment: Alignment.center,
                  child: MouseRegion(
                    onEnter: (_) {
                      setState(() {
                        _isHoveredLogin = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        _isHoveredLogin = false;
                      });
                    },
                    child: GestureDetector(
                      onTap: () {
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => LoginScreen(),
                           ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _isHoveredLogin
                              ? Color(0xFF6D1D1D) // Darker color on hover
                              : Color.fromARGB(255, 122, 43, 9), // Default color
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 303,
                        padding: EdgeInsets.symmetric(vertical: 13),
                        alignment: Alignment.center,
                        child: Text(
                          'Log in',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20), // Space between login and sign up buttons

                // Sign up button
                Align(
                  alignment: Alignment.center,
                  child: MouseRegion(
                    onEnter: (_) {
                      setState(() {
                        _isHoveredSignUp = true;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        _isHoveredSignUp = false;
                      });
                    },
                    child: GestureDetector(
                      onTap: () {
                         Navigator.push(
                           context,
                           MaterialPageRoute(
                             builder: (context) => Registerscreen(),
                           ),
                         );
                      },
                      child: Container(
                        width: 303,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _isHoveredSignUp
                              ? Colors.grey[200] // Light grey color on hover
                              : Colors.white, // Default color
                          border: Border.all(
                            color: _isHoveredSignUp
                                ? Colors.black // Darker border on hover
                                : Color.fromARGB(255, 122, 43, 9), // Default border color
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Register',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: _isHoveredSignUp
                                ? Colors.black // Darker text on hover
                                : Color.fromARGB(255, 122, 43, 9), // Default text color
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 100), // Space between buttons and footer text

                // Footer text
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Copyright@2024 Carfixer 1.0.',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 11,
                      height: 1.1,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
