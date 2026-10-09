import 'package:flutter/material.dart';
import 'booking_screen.dart';
import 'attendance_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF6),
      body: SafeArea(
        child: Padding(
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
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 24),


              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Settings',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              const SizedBox(height: 40),


              Center(
                child: Column(
                  children: [

                    _buildSettingButton(
                      context,
                      text: 'Booking',
                      textColor: Colors.black,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const BookingScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 18),

                    _buildSettingButton(
                      context,
                      text: 'Edit profile',
                      textColor: Colors.black,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 18),


                    _buildSettingButton(
                      context,
                      text: 'Attendance',
                      textColor: Colors.black,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AttendanceScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 35),


                    _buildSettingButton(
                      context,
                      text: 'Delete account',
                      textColor: Colors.red,
                      onTap: () {
                        _showDeleteAccountDialog(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildSettingButton(
      BuildContext context, {
        required String text,
        required Color textColor,
        required VoidCallback onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 240,
        height: 54,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }


  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Delete Account', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
          content: const Text('Are you sure you want to delete your account permanently?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.black54)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Account Deleted Successfully'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: const Text('Delete', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}