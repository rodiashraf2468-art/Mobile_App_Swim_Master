import 'package:flutter/material.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF6),
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
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 24),
              const Text(
                'Attendance',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E2E2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Row(
                    children: [
                      Text('Time', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text('9:00 PM', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E2E2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Row(
                    children: [
                      Text('Day', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text('17 May 2026', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: const BoxDecoration(
                          color: Color(0xFF1E88A8),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add, size: 60, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Press to attend',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Calendar',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 12),
              Table(
                children: [
                  const TableRow(
                    children: [
                      Center(child: Text('S', style: TextStyle(color: Colors.grey, fontSize: 12))),
                      Center(child: Text('S', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                      Center(child: Text('M', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                      Center(child: Text('T', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                      Center(child: Text('W', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                      Center(child: Text('T', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                      Center(child: Text('F', style: TextStyle(color: Colors.grey, fontSize: 12))),
                    ],
                  ),
                  const TableRow(children: [SizedBox(height: 8), SizedBox(height: 8), SizedBox(height: 8), SizedBox(height: 8), SizedBox(height: 8), SizedBox(height: 8), SizedBox(height: 8)]),
                  TableRow(
                    children: [
                      const Center(child: Text('', style: TextStyle(color: Colors.grey))),
                      const Center(child: Text('', style: TextStyle(color: Colors.grey))),
                      const Center(child: Text('', style: TextStyle(color: Colors.grey))),
                      const Center(child: Text('', style: TextStyle(color: Colors.grey))),
                      _buildCalendarDay('1', true),
                      _buildCalendarDay('2', true),
                      const Center(child: Text('3', style: TextStyle(color: Colors.grey))),
                    ],
                  ),
                  const TableRow(children: [SizedBox(height: 8), SizedBox(height: 8), SizedBox(height: 8), SizedBox(height: 8), SizedBox(height: 8), SizedBox(height: 8), SizedBox(height: 8)]),
                  TableRow(
                    children: [
                      const Center(child: Text('4', style: TextStyle(color: Colors.grey))),
                      _buildCalendarDay('5', true),
                      _buildCalendarDay('6', true),
                      _buildCalendarDay('7', true),
                      _buildCalendarDay('8', true),
                      _buildCalendarDay('9', true),
                      const Center(child: Text('10', style: TextStyle(color: Colors.grey))),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Text(
                'Attendance range',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: CircularProgressIndicator(
                          value: 0.65,
                          strokeWidth: 14,
                          backgroundColor: Colors.purple.shade100,
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.purple),
                        ),
                      ),
                      const Text(
                        '65%\nTotal Attend',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(width: 30),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.square, color: Colors.purple, size: 18),
                          SizedBox(width: 8),
                          Text('Attend', style: TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(Icons.square, color: Colors.pink, size: 18),
                          SizedBox(width: 8),
                          Text('Absent', style: TextStyle(fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 40),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                color: const Color(0xFFD2D2D2),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('id', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('Day', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('Month', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('State', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              ),
              Container(
                height: 150,
                width: double.infinity,
                color: const Color(0xFFE2E2E2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarDay(String day, bool isAttended) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isAttended ? const Color(0xFFDFF6FF) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Text(
          day,
          style: TextStyle(
            color: isAttended ? const Color(0xFF1E88A8) : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}