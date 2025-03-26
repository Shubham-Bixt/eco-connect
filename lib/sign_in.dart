// import 'package:flutter/material.dart';
//
// class SignInScreen extends StatelessWidget {
//   const SignInScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.white,
//               const Color(0xFF8BC34A).withOpacity(0.3),
//               const Color(0xFF8BC34A).withOpacity(0.5),
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(
//                   Icons.recycling,
//                   size: 80,
//                   color: Color(0xFF8BC34A),
//                 ),
//                 const SizedBox(height: 40),
//                 const Text(
//                   "Sign In",
//                   style: TextStyle(
//                     color: Color(0xFF8BC34A),
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     hintText: "Email",
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                     prefixIcon: const Icon(Icons.email, color: Color(0xFF8BC34A)),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 TextFormField(
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     hintText: "Password",
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: BorderSide.none,
//                     ),
//                     prefixIcon: const Icon(Icons.lock, color: Color(0xFF8BC34A)),
//                   ),
//                 ),
//                 const SizedBox(height: 30),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pushReplacementNamed(context, '/home');
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF8BC34A),
//                     padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   child: const Text(
//                     "Sign In",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/sign_up');
//                   },
//                   child: const Text(
//                     "Don't have an account? Sign Up",
//                     style: TextStyle(color: Color(0xFF8BC34A)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }