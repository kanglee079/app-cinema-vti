import 'package:flutter/material.dart';

class TextFormCustom extends StatefulWidget {
  const TextFormCustom({
    super.key,
    this.hintText = 'Your Account',
    this.iconPrefix = Icons.person,
    this.isPassword = false,
    this.errorCheck,
    required this.controller,
  });

  final String hintText;
  final IconData iconPrefix;
  final bool isPassword;
  final String? errorCheck;
  final TextEditingController controller;

  @override
  State<TextFormCustom> createState() => _TextFormCustomState();
}

class _TextFormCustomState extends State<TextFormCustom> {
  late bool _isObscured;

  @override
  void initState() {
    _isObscured = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.orangeAccent),
      controller: widget.controller,
      obscureText: _isObscured,
      decoration: InputDecoration(
        labelText: widget.hintText,
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: Icon(widget.iconPrefix, color: Colors.orangeAccent),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null,
        filled: true,
        fillColor: const Color(0xFF1E1C24),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orangeAccent, width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orangeAccent),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Vui lòng nhập dữ liệu';
        }
        if (widget.errorCheck == 'email') {
          final bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value);
          if (!emailValid) {
            return 'Không phải là email';
          }
        }
        return null;
      },
    );
  }
}
