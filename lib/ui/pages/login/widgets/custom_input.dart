import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final bool isPassword;
  final String errorText;
  final Function(String value) onChange;

  const CustomInput(
      {@required this.icon,
      @required this.placeholder,
      @required this.textEditingController,
      this.errorText,
      this.textInputType = TextInputType.name,
      this.isPassword = false,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            top: 5, left: errorText != null ? 15 : 5, bottom: 5, right: 20),
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.05),
                  offset: Offset(0, 5),
                  blurRadius: 5)
            ]),
        child: TextField(
          autocorrect: false,
          controller: textEditingController,
          keyboardType: textInputType,
          obscureText: isPassword,
          onChanged: onChange,
          decoration: InputDecoration(
              prefixIcon: Icon(icon),
              errorText: errorText,
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: placeholder),
        ));
  }
}
