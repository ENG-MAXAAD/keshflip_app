import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:keshflip_app/theme/text_styles.dart';
import 'package:country_flags/country_flags.dart';

class CircularCountryFlag extends StatelessWidget {
  final String countryCode;
  final double size;

  const CircularCountryFlag({
    Key? key,
    required this.countryCode,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CountryFlag.fromCountryCode(
        countryCode,
        height: size,
        width: size,
      ),
    );
  }
}

enum Language { NIG, ENG, FR }

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Language selectedLanguage = Language.NIG;
  String selectedTheme = 'Light';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(),
              SizedBox(height: 32),
              _buildSectionTitle('Preferences'),
              _buildPreferenceItem(
                  'Account Details', 'assets/images/profile/wallet.png'),
              _buildPreferenceItem(
                  'Account Activity', 'assets/images/profile/activity.png'),
              _buildPreferenceItem(
                  'Web Log in', 'assets/images/profile/webcam.png'),
              Divider(thickness: 0.5, color: Color(0xFFE4E4E7)),
              Gap(32),
              _buildSectionTitle('Security & Safety'),
              _buildPreferenceItem(
                  'Change Password', 'assets/images/profile/lock.png'),
              _buildPreferenceItem(
                  'Security Questions', 'assets/images/profile/shield.png'),
              _buildPreferenceItem('2A-Factor Authentication',
                  'assets/images/profile/file-lock.png'),
              Divider(thickness: 0.5, color: Color(0xFFE4E4E7)),
              Gap(32),
              _buildSectionTitle('Display'),
              _buildPreferenceItemWithTrailing(
                title: 'Language',
                iconPath: 'assets/images/profile/lang.png',
                trailing: _buildChip(languageToString(selectedLanguage),
                    getCountryCode(selectedLanguage)),
                onTap: () => _showLanguageBottomSheet(context),
              ),
              _buildPreferenceItemWithTrailing(
                title: 'Theme',
                iconPath: 'assets/images/profile/moon-star.png',
                trailing: _buildChip(selectedTheme, null,
                    iconPath: 'assets/images/profile/sun-setting.png'),
              ),
              _buildPreferenceItem(
                  'Notifications', 'assets/images/profile/bell.png'),
              Divider(thickness: 0.5, color: Color(0xFFE4E4E7)),
              Gap(32),
              _buildSectionTitle('Others'),
              _buildPreferenceItem(
                  'Contact Us', 'assets/images/profile/help-circle.png'),
              _buildPreferenceItem(
                  'Log Out', 'assets/images/profile/log-out.png'),
              _buildPreferenceItem(
                  'Delete Account', 'assets/images/profile/trash2.png',
                  titleColor: Color(0xFFF41F14)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: CustomTextStyles.secondaryTitle);
  }

  Widget _buildPreferenceItem(String title, String iconPath,
      {Color? titleColor}) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 10),
      leading: Image.asset(iconPath,
          width: 24, height: 24, color: titleColor ?? Colors.black),
      title: Text(
        title,
        style: CustomTextStyles.mediumText.copyWith(color: titleColor),
      ),
      onTap: () {},
    );
  }

  Widget _buildPreferenceItemWithTrailing({
    required String title,
    required String iconPath,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 10),
      leading:
          Image.asset(iconPath, width: 24, height: 24, color: Colors.black),
      title: Text(title, style: CustomTextStyles.mediumText),
      trailing: trailing,
      onTap: onTap,
    );
  }

  Widget _buildChip(String label, String? countryCode, {String? iconPath}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Color(0xFFE4E4E7)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (countryCode != null) ...[
            CircularCountryFlag(countryCode: countryCode, size: 16),
            SizedBox(width: 2),
          ],
          if (iconPath != null) ...[
            Image.asset(iconPath, width: 16, height: 16),
            SizedBox(width: 2),
          ],
          Text(label,
              style: CustomTextStyles.mediumText.copyWith(fontSize: 14)),
          SizedBox(width: 4),
          Image.asset('assets/images/profile/chevron.png',
              width: 12, height: 12, color: Color(0xff98A2B3)),
        ],
      ),
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Language', style: CustomTextStyles.primaryTitle),
            SizedBox(height: 16),
            _buildLanguageOption(Language.NIG, 'Nigerian (NIG)'),
            _buildLanguageOption(Language.ENG, 'English (US)'),
            _buildLanguageOption(Language.FR, 'French (FR)'),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(Language language, String label) {
    String countryCode = getCountryCode(language);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircularCountryFlag(countryCode: countryCode, size: 32),
      title: Text(label,
          style: CustomTextStyles.mediumText.copyWith(fontSize: 14)),
      trailing: selectedLanguage == language
          ? Icon(Icons.check, color: Color(0xFF4CAF50))
          : null,
      onTap: () {
        setState(() {
          selectedLanguage = language;
        });
        Navigator.pop(context);
      },
    );
  }

  String languageToString(Language language) {
    switch (language) {
      case Language.NIG:
        return 'NIG';
      case Language.ENG:
        return 'USA';
      case Language.FR:
        return 'FR';
    }
  }

  String getCountryCode(Language language) {
    switch (language) {
      case Language.NIG:
        return 'NG';
      case Language.ENG:
        return 'US';
      case Language.FR:
        return 'FR';
    }
  }
}

Widget _buildProfileHeader() {
  return Row(
    children: [
      CircleAvatar(
        radius: 40,
        backgroundImage: AssetImage('assets/images/profile/profile.png'),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Keshfliper, James', style: CustomTextStyles.primaryTitle),
            Gap(4),
            Text('keshflipd34@gmail.com', style: CustomTextStyles.subTitle),
          ],
        ),
      ),
      _buildEditButton(),
    ],
  );
}

Widget _buildEditButton() {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Color(0xFFD0D5DD)),
      borderRadius: BorderRadius.circular(100),
    ),
    child: IconButton(
      icon:
          Image.asset('assets/images/profile/edit.png', width: 20, height: 20),
      onPressed: () {},
    ),
  );
}
