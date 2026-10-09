import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

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
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Booking',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(
                    maxWidth: 320,
                  ),
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCDCDC),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'Credit details',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Card Number
                      const Text('Card Number', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                      const SizedBox(height: 6),
                      _buildTextField(_cardNumberController, '', TextInputType.number, 16, [
                        FilteringTextInputFormatter.digitsOnly,
                      ]),
                      const SizedBox(height: 16),

                      // Card Holder's Name (English Only & 4 Names Max)
                      const Text("Card Holder's Name", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                      const SizedBox(height: 6),
                      _buildTextField(_nameController, '', TextInputType.text, null, [
                        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')), // حروف إنجليزية ومسافات فقط
                        FourWordsLimitFormatter(),
                      ]),
                      const SizedBox(height: 16),

                      // Expire date & CVC/CVV
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Expire date', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
                                const SizedBox(height: 6),
                                _buildTextField(_expiryController, 'MM/YY', TextInputType.number, 5, [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CardExpiryInputFormatter(),
                                ]),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('CVC/CVV', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black)),
                                const SizedBox(height: 6),
                                _buildTextField(_cvvController, '', TextInputType.number, 3, [
                                  FilteringTextInputFormatter.digitsOnly,
                                ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 35),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E88A8),
                            padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            elevation: 0,
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Payment Processed Successfully!'),
                                backgroundColor: Color(0xFF1E88A8),
                              ),
                            );
                          },
                          child: const Text(
                            'pay now',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String hint,
      TextInputType keyType,
      int? maxLength,
      List<TextInputFormatter>? formatters,
      ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: controller,
        keyboardType: keyType,
        maxLength: maxLength,
        inputFormatters: formatters,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black26, fontSize: 14),
          counterText: "",
          border: InputBorder.none,
        ),
      ),
    );
  }
}


class FourWordsLimitFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // نقوم بعدّ الكلمات بناءً على المسافات
    List<String> words = newValue.text.trim().split(RegExp(r'\s+'));
    if (words.length > 4) {

      return oldValue;
    }
    return newValue;
  }
}


class CardExpiryInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;

      if (nonZeroIndex == 2 && nonZeroIndex != text.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
      text: string,
      selection: TextSelection.collapsed(offset: string.length),
    );
  }
}