import 'package:app_cinema/apps/config/conf_colors.dart';
import 'package:app_cinema/widgets/button_item.dart';
import 'package:app_cinema/widgets/text_field_item.dart';
import 'package:app_cinema/widgets/touch_dismiss_keyboard_item.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/localiztions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late ThemeData _themeData;
  TextTheme get _textTheme => _themeData.textTheme;
  ColorScheme get _colorScheme => _themeData.colorScheme;

  @override
  void initState() {
    print("Đã gọi init");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);

    TextEditingController? usernameController = TextEditingController();
    TextEditingController? passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return TouchOutsideToDismissKeyboard(
      child: Scaffold(
        backgroundColor: ConfigColors().primaryColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset("assets/image/AppIcon.png"),
                  const SizedBox(height: 30),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormCustom(
                          hintText: translate(context).username,
                          errorCheck: "email",
                          controller: usernameController,
                        ),
                        const SizedBox(height: 15),
                        TextFormCustom(
                          hintText: "Password",
                          controller: passwordController,
                          iconPrefix: Icons.lock,
                          isPassword: true,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              style: const ButtonStyle(
                                  alignment: Alignment.centerRight),
                              onPressed: () {},
                              child: Text(
                                "Forgot password?",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: _colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ButtonCustom(
                          onTap: () {
                            print(usernameController.text);
                            print(passwordController.text);
                            if (formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                            }
                          },
                          textButton: 'Login',
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                          backgroundColor: _colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                  Column(
                    children: [
                      Text(
                        "Or sigin with",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/image/google_logo.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 50),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/image/facebook_logo.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
