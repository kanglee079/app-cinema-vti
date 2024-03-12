import 'package:app_cinema/widgets/button_item.dart';
import 'package:app_cinema/widgets/text_field_item.dart';
import 'package:app_cinema/widgets/touch_dismiss_keyboard_item.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController? usernameController = TextEditingController();
    TextEditingController? passwordController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return TouchOutsideToDismissKeyboard(
      child: Scaffold(
        backgroundColor: const Color(0xff181f2b),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset("assets/image/AppIcon.png"),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormCustom(
                      hintText: "Username",
                      errorCheck: "email",
                      controller: usernameController,
                    ),
                    const SizedBox(height: 25),
                    TextFormCustom(
                      hintText: "Password",
                      controller: passwordController,
                      iconPrefix: Icons.lock,
                      isPassword: true,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          style: const ButtonStyle(
                              alignment: Alignment.centerRight),
                          onPressed: () {},
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.orangeAccent),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ButtonCustom(
                      onTap: () {
                        print(usernameController.text);
                        print(passwordController.text);
                        if (formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      textButton: 'Login',
                      textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                      backgroundColor: const Color(0xffff7238),
                    ),
                  ],
                ),
              ),
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
    );
  }
}
