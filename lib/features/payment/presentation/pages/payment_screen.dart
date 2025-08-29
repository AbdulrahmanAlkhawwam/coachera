import 'package:coachera/core/utils/app_context.dart';
import 'package:coachera/core/utils/app_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/res.dart';
import 'payment_sheet.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  int selectedIndex = 0; // البطاقة المختارة

  final cards = [
    {
      "icon": Res.googlePay,
      "name": "Google Pay",
      "type": "",
      "number": "Master Card",
    },
    {
      "icon": Res.masterCardPay,
      "name": "Master Card",
      "type": "",
      "number": "Master Card",
    },
    {
      "icon": Res.visaPay,
      "name": "Visa Card",
      "type": "",
      "number": "Master Card",
    },
    {
      "icon": Res.applePay,
      "name": "Apple Pay",
      "type": "",
      "number": "Master Card",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Payments"),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          bottom: 8 + context.bottomPadding,
          top: 16,
          left: 16,
          right: 16,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => _PaymentCard(
                  icon: cards[index]["icon"] as String,
                  name: cards[index]["name"] as String,
                  number: cards[index]["number"] as String,
                  type: cards[index]["type"] as String,
                  isSelected: selectedIndex == index,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 8.0),
                itemCount: cards.length,
              ),
            ),
            FilledButton(
              onPressed: () {
                showStripePaymentBottomSheet(context);
                // هنا بتستخدم البطاقة المختارة
                // final selectedCard = cards[selectedIndex];
                // debugPrint("Selected Card: ${selectedCard["name"]}");
                // TODO : add payment sheet which get the card data
              },
              child: const Center(
                child: Text(
                  "Continue",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  final String icon;
  final String name;
  final String number;
  final String type;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentCard({
    required this.icon,
    required this.name,
    required this.number,
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colors.primaryContainer,
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: AppImage(
            icon,
            width: 32,
          ),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Icon(
          isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
          color: isSelected ? context.colors.primary : context.colors.outline,
        ),
        onTap: onTap,
      ),
    );
  }
}
