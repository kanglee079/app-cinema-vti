import 'package:app_cinema/apps/config/conf_colors.dart';
import 'package:app_cinema/widgets/date_picker_widget.dart';
import 'package:app_cinema/widgets/language_toggle_item.dart';
import 'package:app_cinema/widgets/touch_dismiss_keyboard_item.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/gender_item.dart';
import '../../../../widgets/infor_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isReceiveNotification = false;
  DateTime _selectedDate = DateTime.now();
  Gender _selectedGender = Gender.Male;
  String dropdownValue = "Ho Chi Minh City";
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    super.dispose();
  }

  // late ThemeData _themeData;

  void _handleDateChanged(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _handleGenderChanged(Gender gender) {
    setState(() {
      _selectedGender = gender;
    });
  }

  void saveProfile() {
    DateTime selectedDate = DateTime.now();
    String selectedGender = "Male";

    print("Full Name: ${fullNameController.text}");
    print("Phone Number: ${phoneNumberController.text}");
    print("Email: ${emailController.text}");
    print(
        "Date of Birth: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}");
    print("Gender: $selectedGender");
    print("City: $dropdownValue");
  }

  final List<String> listCity = <String>[
    "Ho Chi Minh City",
    "Hanoi",
    "Da Nang",
    "Can Tho",
    "Hue"
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextTheme textTheme = themeData.textTheme;
    final ColorScheme colorScheme = themeData.colorScheme;

    return TouchOutsideToDismissKeyboard(
      child: Scaffold(
        backgroundColor: ConfigColors().primaryColor,
        appBar: AppBar(
          backgroundColor: ConfigColors().appBarColor,
          leading: IconButton(
            padding: const EdgeInsets.only(left: 15),
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: themeData.colorScheme.primaryContainer,
            ),
          ),
          title: Center(
            child: Text(
              'Profile',
              style: textTheme.titleLarge,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.logout,
                color: themeData.colorScheme.primaryContainer,
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 30,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage('assets/image/AppIcon.png'),
                ),
                const SizedBox(height: 20),
                Text(
                  'Wayne Jackson',
                  style: textTheme.titleLarge,
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Information",
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.primaryContainer,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Column(
                  children: [
                    InfoRow(
                      title: "Fullname",
                      controller: fullNameController,
                      titleStyle: textTheme.bodyMedium,
                    ),
                    InfoRow(
                      isDeco: false,
                      title: "Date of birth",
                      titleStyle: textTheme.bodyMedium,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child:
                            DatePickerWidget(onDateChanged: _handleDateChanged),
                      ),
                    ),
                    InfoRow(
                      title: "Phone number",
                      titleStyle: textTheme.bodyMedium,
                      isPhone: true,
                      controller: phoneNumberController,
                    ),
                    InfoRow(
                      title: "Email",
                      controller: emailController,
                      titleStyle: textTheme.bodyMedium,
                    ),
                    InfoRow(
                      isDeco: false,
                      title: "Gender",
                      titleStyle: textTheme.bodyMedium,
                      child: GenderItem(onGenderChanged: _handleGenderChanged),
                    ),
                    InfoRow(
                      isDeco: false,
                      title: "City",
                      titleStyle: textTheme.bodyMedium,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 1,
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_drop_down,
                                  color: Colors.white),
                              style: const TextStyle(color: Colors.white),
                              dropdownColor: ConfigColors().primaryColor,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: listCity.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        saveProfile();
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: colorScheme.primary,
                        ),
                        child: Center(
                          child: Text(
                            "SAVE",
                            style: textTheme.titleMedium,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Settings",
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.primaryContainer,
                    ),
                  ),
                ),
                Column(
                  children: [
                    InfoRow(
                      title: "Language",
                      titleStyle: textTheme.bodyMedium,
                      isDeco: false,
                      child: const LanguageToggle(),
                    ),
                    InfoRow(
                      title: "Receive notification",
                      titleStyle: textTheme.bodyMedium,
                      isDeco: false,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Switch(
                          value: isReceiveNotification,
                          activeColor: Colors.orange,
                          onChanged: (bool value) {
                            setState(() {
                              isReceiveNotification = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
