import 'package:flutter/material.dart';

class InputWithLabel extends StatelessWidget {
  final label;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final bool isPassword;
  final String errorText;
  final Function(String value) onChange;

  const InputWithLabel(
      {@required this.label,
      @required this.textEditingController,
      @required this.textInputType,
      this.errorText,
      this.isPassword = false,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        width: screenWidth * .8,
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(label,
                        style: TextStyle(fontWeight: FontWeight.bold)))),
            TextField(
              autocorrect: false,
              controller: textEditingController,
              keyboardType: textInputType,
              obscureText: isPassword,
              onChanged: onChange,
              decoration: InputDecoration(
                  errorText: errorText,
                  fillColor: Color(0xffF3F3F3),
                  filled: true,
                  border: InputBorder.none),
            )
          ],
        ),
      ),
    );
  }
}
