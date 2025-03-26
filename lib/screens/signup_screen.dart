import 'package:flutter/material.dart';

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo section
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
                    ],
                  ),
                ),
                SizedBox(height: 40),

                Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),

                // Name field
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFE8F0EC),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Full Name',
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 16),

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
                SizedBox(height: 16),

                // Confirm Password field
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFE8F0EC),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Sign Up button
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
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Login link
                Center(
                  child: Row(
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
