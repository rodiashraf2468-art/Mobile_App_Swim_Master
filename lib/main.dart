import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isFemale = true;
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Profile Photo Options', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              if (_profileImage != null)
                ListTile(
                  leading: const Icon(Icons.fullscreen, color: Color(0xFF1E88A8)),
                  title: const Text('View Current Photo'),
                  onTap: () {
                    Navigator.pop(context);
                    _viewFullImage();
                  },
                ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Color(0xFF1E88A8)),
                title: Text(_profileImage != null ? 'Change from Gallery' : 'Add from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xFF1E88A8)),
                title: const Text('Take a New Photo (Camera)'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              if (_profileImage != null)
                ListTile(
                  leading: const Icon(Icons.delete_forever, color: Colors.red),
                  title: const Text('Delete Photo', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      _profileImage = null;
                    });
                  },
                ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  void _viewFullImage() {
    if (_profileImage == null) return;
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Center(
              child: ClipOval(
                child: Image.file(
                  _profileImage!,
                  width: 280,
                  height: 280,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showGenderOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text('Select Gender', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: const Icon(Icons.male, color: Color(0xFF1E88A8)),
                title: const Text('Male'),
                trailing: !_isFemale ? const Icon(Icons.check, color: Color(0xFF1E88A8)) : null,
                onTap: () {
                  setState(() {
                    _isFemale = false;
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.female, color: Color(0xFF1E88A8)),
                title: const Text('Female'),
                trailing: _isFemale ? const Icon(Icons.check, color: Color(0xFF1E88A8)) : null,
                onTap: () {
                  setState(() {
                    _isFemale = true;
                  });
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4EFF2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                color: Colors.white,
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFF1E88A8),
                  padding: const EdgeInsets.all(12),
                  shape: const CircleBorder(),
                ),
                onPressed: () {},
              ),
              const SizedBox(height: 24),
              const Text('Profile', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: _showImageOptions,
                  child: Container(
                    width: 160,
                    height: 160,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC4C4C4),
                      shape: BoxShape.circle,
                    ),
                    child: _profileImage != null
                        ? ClipOval(
                      child: Image.file(
                        _profileImage!,
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    )
                        : const Icon(Icons.add_a_photo, size: 50, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              const Text('Username', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
                  border: InputBorder.none,
                ),
              ),
              const Divider(color: Colors.black12, thickness: 1),
              const SizedBox(height: 12),
              const Text('Gender', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              GestureDetector(
                onTap: _showGenderOptions,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _isFemale ? 'Female' : 'Male',
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Icon(Icons.arrow_drop_down, color: Colors.black.withOpacity(0.5)),
                    ],
                  ),
                ),
              ),
              const Divider(color: Colors.black12, thickness: 1),
              const SizedBox(height: 12),
              const Text('Phone', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 11,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: '01xxxxxxxxx',
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
                  counterText: "",
                  border: InputBorder.none,
                ),
              ),
              const Divider(color: Colors.black12, thickness: 1),
              const SizedBox(height: 45),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E88A8),
                    padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                  },
                  child: const Text('Save & Go to Settings', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}