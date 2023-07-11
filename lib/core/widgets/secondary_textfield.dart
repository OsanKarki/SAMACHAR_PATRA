import 'package:flutter/material.dart';

class SecondaryTextField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final double height;
  final bool isPassword;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final double borderRadius;
  final TextEditingController? controller;
  final Color? fillColor;
  final String? Function(String?)? validator;

  const SecondaryTextField({
    super.key,
    this.label,
    this.hintText,
    this.height = 15,
    this.isPassword = false,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.borderRadius = 11,
    this.controller,
    this.fillColor,
    this.validator,
  });

  @override
  State<SecondaryTextField> createState() => _SecondaryTextFieldState();
}

class _SecondaryTextFieldState extends State<SecondaryTextField> {
  bool isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (widget.label != null)
          Column(
            children: [
              Text(
                widget.label!,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        TextFormField(
          validator: widget.validator,
          controller: widget.controller,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          obscureText: widget.isPassword ? isHidden : false,
          decoration: InputDecoration(
            filled: true,
            fillColor: widget.fillColor,
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: Colors.black38,
                  )
                : null,
            suffixIcon: widget.isPassword
                ? InkWell(
                    onTap: () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    },
                    child: Icon(
                      isHidden ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ))
                : null,
            contentPadding:
                EdgeInsets.symmetric(vertical: widget.height, horizontal: 10),
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(11),
                borderSide: const BorderSide(color: Colors.orange, width: 1.6)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: const BorderSide(
                width: 1.6,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
