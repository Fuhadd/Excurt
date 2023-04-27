import 'package:escurt/widgets/loader.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final onTap;
  final Color color;
  final Color textcolor;
  final bool isLoading;

  const CustomButton({
    required this.title,
    this.onTap,
    this.isLoading = false,
    this.color = Colors.black,
    this.textcolor = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (onTap == null) ? () {} : onTap,
      child: Container(
        height: 45,
        // padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(35)),
        width: double.infinity,
        child: Center(
          child: isLoading
              ? const FittedBox(child: Loader())
              : Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: textcolor),
                ),
        ),
      ),
    );
  }
}
