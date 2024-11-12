import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/text_styles.dart';

class TransactionHistoryScreen extends StatelessWidget {
  TransactionHistoryScreen({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> transactions = [
    {
      'type': 'Received BNB',
      'date': 'Mar 21, 2023',
      'time': '10:32AM',
      'amount': '0.0057USDT',
      'amountUSD': '\$40.00',
      'status': 'success',
    },
    {
      'type': 'Received BTC',
      'date': 'Jan 30, 2023',
      'time': '08:21 AM',
      'amount': '0.0057USDT',
      'amountUSD': '\$40',
      'status': 'failed',
    },
    {
      'type': 'Received BTC',
      'date': 'Jan 30, 2023',
      'time': '08:21 AM',
      'amount': '0.0057USDT',
      'amountUSD': '\$40',
      'status': 'success',
    },
    {
      'type': 'Received BTC',
      'date': 'Jan 30, 2023',
      'time': '08:21 AM',
      'amount': '0.0057USDT',
      'amountUSD': '\$40',
      'status': 'failed',
    },
    {
      'type': 'Received BTC',
      'date': 'Jan 30, 2023',
      'time': '08:21 AM',
      'amount': '0.0057USDT',
      'amountUSD': '\$40',
      'status': 'failed',
    },
    {
      'type': 'Received BTC',
      'date': 'Jan 30, 2023',
      'time': '08:21 AM',
      'amount': '0.0057USDT',
      'amountUSD': '\$40',
      'status': 'success',
    },
    {
      'type': 'Received BTC',
      'date': 'Jan 30, 2023',
      'time': '08:21 AM',
      'amount': '0.0057USDT',
      'amountUSD': '\$40',
      'status': 'success',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            kToolbarHeight + 30), // Default height + extra space
        child: Padding(
          padding: const EdgeInsets.only(top: 45), // Adds 40px space at the top
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: Colors.transparent,
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 24),
              child: IconButton(
                icon: Icon(
                  Icons.chevron_left,
                  size: 20,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            title: const SizedBox.shrink(),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
            child: Text(
              'Transaction History',
              style: CustomTextStyles.primaryTitle.copyWith(
                  fontWeight: FontWeight.w600, color: Color(0xff101928)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xFFE4E4E7)
                      .withOpacity(0.5), // Sets the border color
                  width: 1.0, // Sets the border width
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  SizedBox(width: 16),
                  Image.asset(
                    'assets/images/transaction/search.png',
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search assets',
                        hintStyle: CustomTextStyles.secondaryTitle
                            .copyWith(fontSize: 14, color: Color(0xffA0A0AB)),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Image.asset(
                      'assets/images/transaction/filter.png',
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xffF7F7F7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: transaction['status'] == 'success'
                                ? const Color(0xFF6E56F8).withOpacity(0.15)
                                : Colors.red.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset(
                            transaction['status'] == 'success'
                                ? 'assets/images/transaction/success.png'
                                : 'assets/images/transaction/unsuccess.png',
                            color: transaction['status'] == 'success'
                                ? const Color(0xFF6E56F8)
                                : Colors.red,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(transaction['type'],
                                  style: CustomTextStyles.mediumText
                                      .copyWith(color: Color(0xff1D2739))),
                              const SizedBox(height: 4),
                              Text(
                                  '${transaction['date']} | ${transaction['time']}',
                                  style: CustomTextStyles.secondaryTitle
                                      .copyWith(
                                          fontSize: 14,
                                          color: Color(0xff667185))),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(transaction['amount'],
                                style: CustomTextStyles.mediumText.copyWith(
                                    fontSize: 14, color: Color(0xff1D2739))),
                            const SizedBox(height: 4),
                            Text(transaction['amountUSD'],
                                style: CustomTextStyles.secondaryTitle.copyWith(
                                    fontSize: 14, color: Color(0xff475367))),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
