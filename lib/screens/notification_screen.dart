import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keshflip_app/theme/text_styles.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _selectedTab = 1; // System tab selected by default

  final List<Map<String, dynamic>> notifications = [
    {
      'icon': 'assets/images/notification/wallet3.png',
      'title': 'Successful transfer of 0.00574 USDT',
      'timestamp': 'Aug 21, 2021 | 08:30AM',
    },
    {
      'icon': 'assets/images/notification/phone.png',
      'title': 'New device login authentication',
      'timestamp': 'July 10,2024 | 10:02AM',
    },
    {
      'icon': 'assets/images/notification/scan2.png',
      'title': 'Face ID biometrics successfully added',
      'timestamp': 'June 21, 2024 | 08:20PM',
    },
    {
      'icon': 'assets/images/notification/slash-circle.png',
      'title': '@ibraheem viewed offer to buy crypto',
      'timestamp': 'May 12, 2021 | 08:30AM',
    },
    {
      'icon': 'assets/images/notification/sale.png',
      'title': 'You cancelled order ID #TY5684',
      'timestamp': 'May 16, 2021 | 08:30AM',
    },
    {
      'icon': 'assets/images/notification/wallet3.png',
      'title': 'You cancelled order ID #TY5684',
      'timestamp': 'May 16, 2021 | 08:30AM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            kToolbarHeight + 40), // Default height + extra space
        child: Padding(
          padding: const EdgeInsets.only(top: 40), // Adds 40px space at the top
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notifications',
              style: CustomTextStyles.primaryTitle.copyWith(
                  fontWeight: FontWeight.w600, color: Color(0xff101928)),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTab('All', 0),
                _buildTab('System', 1),
                _buildTab('Account', 2),
              ],
            ),
            const SizedBox(height: 32),
            Expanded(
              child: ListView.builder(
                // padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0CCF5).withOpacity(0.5),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Image.asset(
                            notification['icon'],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification['title'],
                                style: CustomTextStyles.mediumText
                                    .copyWith(color: Color(0xff1D2739)),
                              ),
                              const SizedBox(height: 8),
                              Text(notification['timestamp'],
                                  style:
                                      CustomTextStyles.secondaryTitle.copyWith(
                                    fontSize: 14,
                                    color: Color(0xff667185),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Column(
        children: [
          Text(
            text,
            style: CustomTextStyles.mediumText.copyWith(
                color:
                    isSelected ? const Color(0xFF6600CC) : Color(0xff70707B)),
          ),
          const SizedBox(height: 8),
          Container(
            height: 3,
            width: 99,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF6600CC) : Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
