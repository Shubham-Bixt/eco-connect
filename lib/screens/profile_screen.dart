import 'package:eco/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'signup_screen.dart';
import 'package:eco/screens/past_event.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'recycling_center.dart';
import 'under_process.dart'; // Import the UnderProcessPage

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 3; // Profile tab should be selected by default
  File? _profileImage;
  String? _profileImagePath;
  String? _googleProfileImageUrl;
  final ImagePicker _picker = ImagePicker();

  // User information
  String _userName = "Eco Connect"; // Default value
  String _userEmail = "ecoconnect@gmail.com"; // Default value

  @override
  void initState() {
    super.initState();
    // Load user information
    _loadUserInfo();
    // Check if user is signed in with Google
    _checkGoogleSignIn();
  }

  Future<void> _loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('user_name') ?? _userName;
      _userEmail = prefs.getString('user_email') ?? _userEmail;
      _profileImagePath = prefs.getString('profile_image_path');

      // If we have a saved image path, load the image
      if (_profileImagePath != null) {
        _profileImage = File(_profileImagePath!);
        // Make sure the file exists before setting it
        if (!_profileImage!.existsSync()) {
          _profileImage = null;
          _profileImagePath = null;
          prefs.remove('profile_image_path');
        }
      }
    });
  }

  Future<void> _checkGoogleSignIn() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? account = await googleSignIn.signInSilently();
      if (account != null) {
        setState(() {
          _googleProfileImageUrl = account.photoUrl;
          _userName = account.displayName ?? _userName;
          _userEmail = account.email;

          // Save user info to SharedPreferences
          _saveUserInfo(account.displayName, account.email);
        });
      }
    } catch (e) {
      print('Error checking Google sign-in: $e');
    }
  }

  Future<void> _saveUserInfo(String? name, String email) async {
    if (name == null) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
    await prefs.setString('user_email', email);
  }

  Future<String> _saveImageToAppDirectory(File image) async {
    try {
      // Get the app's documents directory
      final directory = await getApplicationDocumentsDirectory();

      // Create a unique filename based on timestamp
      final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savedImagePath = '${directory.path}/$fileName';

      // Copy the image to the new location
      final File savedImage = await image.copy(savedImagePath);

      return savedImage.path;
    } catch (e) {
      print('Error saving image: $e');
      throw e;
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        final File imageFile = File(pickedFile.path);

        // Save the image to app's directory
        final String savedImagePath = await _saveImageToAppDirectory(imageFile);

        // Update shared preferences with the new image path
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('profile_image_path', savedImagePath);

        setState(() {
          _profileImage = File(savedImagePath);
          _profileImagePath = savedImagePath;
          // Clear Google profile image when user selects their own
          _googleProfileImageUrl = null;
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Profile Picture'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: ListTile(
                    leading: Icon(Icons.photo_library, color: Color(0xFF4D8D6E)),
                    title: Text('Choose from Gallery'),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
                GestureDetector(
                  child: ListTile(
                    leading: Icon(Icons.camera_alt, color: Color(0xFF4D8D6E)),
                    title: Text('Take a Photo'),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProfileImage() {
    if (_profileImage != null && _profileImage!.existsSync()) {
      // Use locally selected image
      return CircleAvatar(
        radius: 60,
        backgroundImage: FileImage(_profileImage!),
      );
    } else if (_googleProfileImageUrl != null) {
      // Use Google profile image
      return CircleAvatar(
        radius: 60,
        backgroundImage: NetworkImage(_googleProfileImageUrl!),
        onBackgroundImageError: (exception, stackTrace) {
          // This callback doesn't expect a return value
          print('Error loading profile image: $exception');
        },
        child: null, // We'll handle fallback in a different way
      );
    } else {
      // Use initials as fallback
      return _buildInitialsAvatar();
    }
  }

  Widget _buildInitialsAvatar() {
    // Get initials from user name
    String initials = _userName
        .split(' ')
        .map((name) => name.isNotEmpty ? name[0] : '')
        .join('')
        .toUpperCase();

    // Limit to 2 characters
    if (initials.length > 2) {
      initials = initials.substring(0, 2);
    } else if (initials.isEmpty) {
      initials = 'EC'; // Default fallback
    }

    return CircleAvatar(
      radius: 60,
      backgroundColor: Color(0xFF4D8D6E),
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontSize: 42,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<void> _clearProfileImage() async {
    // Show confirmation dialog
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remove Profile Picture'),
          content: Text('Are you sure you want to remove your profile picture?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text('Remove', style: TextStyle(color: Colors.red)),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      final prefs = await SharedPreferences.getInstance();

      // If we have a saved image, delete the file
      if (_profileImagePath != null) {
        try {
          final file = File(_profileImagePath!);
          if (await file.exists()) {
            await file.delete();
          }
        } catch (e) {
          print('Error deleting image file: $e');
        }
      }

      // Clear the saved path in SharedPreferences
      await prefs.remove('profile_image_path');

      setState(() {
        _profileImage = null;
        _profileImagePath = null;
      });
    }
  }

  void _showProfileImageOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Profile Picture Options'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: ListTile(
                    leading: Icon(Icons.add_photo_alternate, color: Color(0xFF4D8D6E)),
                    title: Text('Change Picture'),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _showImageSourceDialog();
                  },
                ),
                GestureDetector(
                  child: ListTile(
                    leading: Icon(Icons.delete, color: Colors.red),
                    title: Text('Remove Picture', style: TextStyle(color: Colors.red)),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _clearProfileImage();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Navigate to UnderProcessPage
  void _navigateToUnderProcess(String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UnderDevelopmentPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),

              // Profile Section (Simple, no card elevation)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    // Centered profile picture
                    GestureDetector(
                      onTap: _profileImage != null || _googleProfileImageUrl != null
                          ? _showProfileImageOptions
                          : _showImageSourceDialog,
                      child: Stack(
                        children: [
                          _buildProfileImage(),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Color(0xFF4D8D6E),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 25),

                    // User name and email
                    Text(
                      _userName,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 6),

                    Text(
                      _userEmail,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Points Card - Added GestureDetector
              GestureDetector(
                onTap: () => _navigateToUnderProcess('Points'),
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Color(0xFF4D8D6E).withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '⭐',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Points',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '1,000',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4D8D6E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Help & Support and Security & Privacy Card
              Card(
                margin: EdgeInsets.symmetric(horizontal: 20),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    // Help & Support - Added GestureDetector
                    GestureDetector(
                      onTap: () => _navigateToUnderProcess('Help & Support'),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        leading: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xFF4D8D6E).withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '❓',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        title: Text(
                          'Help & Support',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      ),
                    ),

                    // Divider
                    Divider(
                      color: Colors.grey[300],
                      height: 1,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),

                    // Security & Privacy - Added GestureDetector
                    GestureDetector(
                      onTap: () => _navigateToUnderProcess('Security & Privacy'),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        leading: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Color(0xFF4D8D6E).withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '🔒',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        title: Text(
                          'Security & Privacy',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Log out Card
              Card(
                margin: EdgeInsets.symmetric(horizontal: 20),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: GestureDetector(
                  onTap: () async {
                    // Sign out from Google if signed in
                    final GoogleSignIn googleSignIn = GoogleSignIn();
                    await googleSignIn.signOut();

                    // Navigate to Signup Screen & Clear Navigation Stack
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                          (route) => false, // Clears navigation history
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.logout,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Log out',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });

          // Navigate to the appropriate screen based on the tapped item
          if (index == 0) {
            // Clear the stack and set home as the only route
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
                  (route) => false, // This removes all previous routes
            );
          } else if (index == 1 ) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RecyclingHomePage()),
            );
          } else if (index == 2) {
            // History icon
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PastEventsPage()),
            );
          }
        },
        selectedItemColor: const Color(0xFF4D8D6E),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Text('🏠', style: TextStyle(fontSize: 24)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Text('🗺️', style: TextStyle(fontSize: 24)),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Text('⏱️', style: TextStyle(fontSize: 24)),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Text('👤', style: TextStyle(fontSize: 24)),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}