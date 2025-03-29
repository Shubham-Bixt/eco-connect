import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return; // User canceled

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      print("Google Sign-In Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF4D8D6E)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Color(0xFFE8F0EC),
                              child: Image.asset(
                                'assets/logo.png',
                                width: 50,
                                height: 50,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Eco Connect',
                              style: TextStyle(
                                color: Color(0xFF4D8D6E),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'green. connect. grow',
                              style: TextStyle(
                                color: Color(0xFF4D8D6E),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      _buildTextField(_nameController, 'Full Name'),
                      SizedBox(height: 14),
                      _buildTextField(_emailController, 'Email'),
                      SizedBox(height: 14),
                      _buildTextField(_passwordController, 'Password', obscureText: true),
                      SizedBox(height: 14),
                      _buildTextField(_confirmPasswordController, 'Confirm Password', obscureText: true),
                      SizedBox(height: 18),
                      _buildSignUpButton(),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  _buildGoogleSignUpButton(),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Login Now',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, {bool obscureText = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFE8F0EC),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF4D8D6E),
          padding: EdgeInsets.symmetric(vertical: 16),
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/home');
        },
        child: Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleSignUpButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14),
          side: BorderSide(color: Colors.black54),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        onPressed: signInWithGoogle,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/google.png', width: 24, height: 24),
            SizedBox(width: 10),
            Text(
              'Sign Up with Google',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}























//
// import 'package:flutter/material.dart';
//
// class SignupScreen extends StatefulWidget {
//   @override
//   _SignupScreenState createState() => _SignupScreenState();
// }
//
// class _SignupScreenState extends State<SignupScreen> {
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Color(0xFF4D8D6E)),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Center(
//                         child: Column(
//                           children: [
//                             CircleAvatar(
//                               radius: 40,
//                               backgroundColor: Color(0xFFE8F0EC),
//                               child: Image.asset(
//                                 'assets/logo.png',
//                                 width: 50,
//                                 height: 50,
//                               ),
//                             ),
//                             SizedBox(height: 10),
//                             Text(
//                               'Eco Connect',
//                               style: TextStyle(
//                                 color: Color(0xFF4D8D6E),
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Text(
//                               'green. connect. grow',
//                               style: TextStyle(
//                                 color: Color(0xFF4D8D6E),
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 30),
//                       Text(
//                         'Create Account',
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       _buildTextField(_nameController, 'Full Name'),
//                       SizedBox(height: 14),
//                       _buildTextField(_emailController, 'Email'),
//                       SizedBox(height: 14),
//                       _buildTextField(_passwordController, 'Password', obscureText: true),
//                       SizedBox(height: 14),
//                       _buildTextField(_confirmPasswordController, 'Confirm Password', obscureText: true),
//                       SizedBox(height: 18),
//                       _buildSignUpButton(),
//                       SizedBox(height: 16),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 children: [
//                   _buildGoogleSignUpButton(),
//                   SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Already have an account?",
//                         style: TextStyle(
//                           color: Colors.black54,
//                           fontSize: 12,
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         child: Text(
//                           'Login Now',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(TextEditingController controller, String hintText, {bool obscureText = false}) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Color(0xFFE8F0EC),
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: TextField(
//         controller: controller,
//         obscureText: obscureText,
//         decoration: InputDecoration(
//           hintText: hintText,
//           contentPadding: EdgeInsets.symmetric(horizontal: 16),
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSignUpButton() {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Color(0xFF4D8D6E),
//           padding: EdgeInsets.symmetric(vertical: 16),
//         ),
//         onPressed: () {
//           Navigator.pushReplacementNamed(context, '/home');
//         },
//         child: Text(
//           'Sign Up',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildGoogleSignUpButton() {
//     return SizedBox(
//       width: double.infinity,
//       child: OutlinedButton(
//         style: OutlinedButton.styleFrom(
//           padding: EdgeInsets.symmetric(vertical: 14),
//           side: BorderSide(color: Colors.black54),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//         ),
//         onPressed: () {
//           // Handle Google Sign-Up
//         },
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset('assets/google.png', width: 24, height: 24),
//             SizedBox(width: 10),
//             Text(
//               'Sign Up with Google',
//               style: TextStyle(fontSize: 14, color: Colors.black54),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
