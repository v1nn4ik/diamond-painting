import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? isPassword;
  final String? obscureCharacter;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  const CustomTextField({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.obscureCharacter = '*',
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isHidden = false;

  @override
  void initState() {
    isHidden = widget.isPassword ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return TextFormField(
      controller: widget.controller,
      obscureText: isHidden,
      keyboardType: widget.keyboardType,
      obscuringCharacter: widget.obscureCharacter!,
      enableSuggestions: false,
      autocorrect: false,
      style: GoogleFonts.montserrat(
          fontSize: 14, color: Colors.black, fontWeight: FontWeight.normal),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 12.0),
        constraints: BoxConstraints(
          maxHeight: height * 0.065,
          maxWidth: width,
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hintText,
        hintStyle: const TextStyle(
            fontWeight: FontWeight.normal, fontSize: 14, color: Colors.black54),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword!
            ? IconButton(
                icon: isHidden
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: () {
                  setState(() {
                    isHidden = !isHidden;
                  });
                },
              )
            : widget.suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(12, 109, 160, 100),
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(12, 109, 160, 100),
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Color.fromRGBO(12, 109, 160, 100),
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
