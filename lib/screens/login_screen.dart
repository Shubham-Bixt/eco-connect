//
//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _isLoading = false;
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _signInWithGoogle() async {
//     setState(() => _isLoading = true);
//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       if (googleUser == null) return;
//
//       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );
//
//       await FirebaseAuth.instance.signInWithCredential(credential);
//       Navigator.pushReplacementNamed(context, '/home');
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Google sign in failed: ${e.toString()}')),
//       );
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(height: 60),
//                 // Logo section
//                 CircleAvatar(
//                   radius: 40,
//                   backgroundColor: Color(0xFFE8F0EC),
//                   child: Image.asset(
//                     'assets/logo.png',
//                     width: 50,
//                     height: 50,
//                   ),
//                 ),
//                 SizedBox(height: 12),
//                 Text(
//                   'Eco Connect',
//                   style: TextStyle(
//                     color: Color(0xFF4D8D6E),
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'green. connect. grow',
//                   style: TextStyle(
//                     color: Color(0xFF4D8D6E),
//                     fontSize: 14,
//                   ),
//                 ),
//                 SizedBox(height: 60),
//
//                 // Email field
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Color(0xFFE8F0EC),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   child: TextField(
//                     controller: _emailController,
//                     decoration: InputDecoration(
//                       hintText: 'Email',
//                       contentPadding: EdgeInsets.symmetric(horizontal: 16),
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//
//                 // Password field
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Color(0xFFE8F0EC),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                   child: TextField(
//                     controller: _passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       hintText: 'Password',
//                       contentPadding: EdgeInsets.symmetric(horizontal: 16),
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//
//                 // Forgot password link
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () {},
//                     child: Text(
//                       'Forgot Password?',
//                       style: TextStyle(
//                         color: Colors.black54,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 // Sign in button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF4D8D6E),
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                     ),
//                     onPressed: () {
//                       Navigator.pushReplacementNamed(context, '/home');
//                     },
//                     child: Text(
//                       'Sign In',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 // Divider with "OR" text
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 20),
//                   child: Row(
//                     children: [
//                       Expanded(child: Divider(thickness: 1)),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                         child: Text('OR', style: TextStyle(color: Colors.grey)),
//                       ),
//                       Expanded(child: Divider(thickness: 1)),
//                     ],
//                   ),
//                 ),
//
//                 // Google Sign-In Button
//                 SizedBox(
//                   width: double.infinity,
//                   child: OutlinedButton(
//                     style: OutlinedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       side: BorderSide(color: Colors.grey.shade300),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                     ),
//                     onPressed: _isLoading ? null : _signInWithGoogle,
//                     child: _isLoading
//                         ? CircularProgressIndicator()
//                         : Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Image.asset(
//                           'assets/google.png',
//                           width: 24,
//                           height: 24,
//                         ),
//                         SizedBox(width: 12),
//                         Text(
//                           'Sign in with Google',
//                           style: TextStyle(
//                             color: Colors.black87,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 // Register link
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Don't have an account yet?",
//                       style: TextStyle(
//                         color: Colors.black54,
//                         fontSize: 12,
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pushNamed(context, '/signup');
//                       },
//                       child: Text(
//                         'Register Now',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 40),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }










import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        setState(() => _isLoading = false);
        return; // User canceled the login
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-in failed: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 60),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xFFE8F0EC),
                  child: Image.asset(
                    'assets/logo.png',
                    width: 50,
                    height: 50,
                  ),
                ),
                SizedBox(height: 12),
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
                SizedBox(height: 60),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFE8F0EC),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFE8F0EC),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(
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
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Expanded(child: Divider(thickness: 1)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('OR', style: TextStyle(color: Colors.grey)),
                      ),
                      Expanded(child: Divider(thickness: 1)),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: _isLoading ? null : _signInWithGoogle,
                    child: _isLoading
                        ? CircularProgressIndicator()
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/google.png',
                          width: 24,
                          height: 24,
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Sign in with Google',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account yet?",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text(
                        'Register Now',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
