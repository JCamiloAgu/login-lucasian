import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Function onTap;

  const AuthButton({@required this.text, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final gradientColors = [
      onTap != null ? Color(0xfffbb448) : Colors.grey,
      onTap != null ? Color(0xfff7892b) : Colors.grey
    ];
    return InkWell(
      onTap: onTap,
      child: Center(
          child: Container(
        width: screenWidth * .8,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: gradientColors)),
        child: Text(
          text,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      )),
    );
  }
}
