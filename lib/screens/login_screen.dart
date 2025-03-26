import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                // Logo section
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

                // Email field
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

                // Password field
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

                // Forgot password link
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

                // Sign in button
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

                // Register link
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