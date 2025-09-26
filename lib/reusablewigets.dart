import 'package:flutter/material.dart';

class ScreenUtils {
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;
}


class AppColors {
  static const Color primaryColor = Color.fromARGB(255, 114, 26, 20);
  static const Color secondaryColor = Color.fromARGB(255, 100, 99, 99);
  static const Color backgroundColor = Color.fromARGB(250, 255, 250, 250);
  static const Color textColor = Color(0xFF333333);
  static const Color tertiaryColor =  Color.fromARGB(255, 180, 86, 86);
}
 class LabeledTextField extends StatelessWidget {
  final String labelText;
  final Widget? suffixIcon;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const LabeledTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
    required this.controller,
    this.suffixIcon,
    this.keyboardType,
  });
  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(labelText, style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: screenHeight * 0.005),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(),
            suffixIcon: suffixIcon,
            
          ),
        ),
      ],
    );
 }
 }

 class ReusableButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final bool isLoading;

  const ReusableButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: double.infinity,
      height: screenHeight*0.07,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondaryColor),
        onPressed: onPressed,
        child: isLoading
            ? CircularProgressIndicator(color: Colors.white)
            : Text(buttonText, style: TextStyle(fontSize: screenWidth * 0.05, color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }}
  class StyledTextField extends StatelessWidget {
    final String labelText;
    final Widget? suffixIcon;
    final String hintText;
    final bool obscureText;
    final TextEditingController controller;
    final TextInputType? keyboardType;

    const StyledTextField({
      super.key,
      required this.labelText,
      required this.hintText,
      this.obscureText = false,
      required this.controller,
      this.keyboardType,
      this.suffixIcon,
    });

    @override
    Widget build(BuildContext context) {
       final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(
          fontSize: screenWidth * 0.04,
          color: AppColors.textColor,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: screenWidth * 0.04,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.secondaryColor, width: screenWidth * 0.005),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
        ),
      ),
    );
  }
}

