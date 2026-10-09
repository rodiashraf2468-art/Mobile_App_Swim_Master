import 'package:flutter/material.dart';
import 'payment_screen.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  final List<String> standardPackages = const [
    '70 /day',
    '330 /Half month',
    '550 /month',
  ];

  final List<Map<String, String>> offerPackages = const [
    {
      'duration': '3 months',
      'currentPrice': '1500',
      'oldPrice': '1650',
      'savedAmount': '150 L.E.'
    },
    {
      'duration': '6 months',
      'currentPrice': '3000',
      'oldPrice': '3300',
      'savedAmount': '300 L.E.'
    },
    {
      'duration': 'a Year',
      'currentPrice': '6150',
      'oldPrice': '6600',
      'savedAmount': '450 L.E.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDF6),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
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
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Booking',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            const SizedBox(height: 30),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: standardPackages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14.0),
                  child: _buildStandardPriceButton(context, standardPackages[index]),
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1E88A8),
                  ),
                  child: const Text(
                    'offers%',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                CustomPaint(
                  size: const Size(24, 41),
                  painter: SharpArrowPainter(),
                ),
              ],
            ),
            const SizedBox(height: 25),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: offerPackages.length,
              itemBuilder: (context, index) {
                final offer = offerPackages[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: _buildOfferCard(
                    context,
                    offer['duration']!,
                    offer['currentPrice']!,
                    offer['oldPrice']!,
                    offer['savedAmount']!,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStandardPriceButton(BuildContext context, String text) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PaymentScreen()),
          );
        },
        child: Container(
          width: 280,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFDCDCDC),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOfferCard(BuildContext context, String duration, String currentPrice, String oldPrice, String savedAmount) {
    return Center(
      child: Container(
        width: 280,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFDCDCDC),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Column(
          children: [
            Text(
              duration,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 16),
            Text(
              currentPrice,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            const SizedBox(height: 2),
            Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  oldPrice,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Transform.rotate(
                  angle: -0.15,
                  child: Container(width: 45, height: 2, color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'save $savedAmount',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E88A8),
                padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaymentScreen()),
                );
              },
              child: const Text(
                'Book',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SharpArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xFF1E88A8)
      ..style = PaintingStyle.fill;
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}