import 'package:flutter/material.dart';

class EcoField extends StatelessWidget {
  final double suffixPadding;
  final double prefixPadding;
  final TextEditingController controller;
  final String hintText;
  final String fontFamily;
  final double fontsize;
  final FontWeight txtweight;
  final FontWeight hintweight;
  final double hintSize;
  final Color hintColor;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? filledColor;
  final Color? iconColor;
  final Color? textColor;
  final bool pass;
  final bool readOnly;
  final bool changeicon;
  final bool isFilledColor;
  final Function()? onTap;
  final Function()? textOnTap;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String prefixUrl;
  final String suffixUrl;
  final TextInputType inputType;
  final int minLines;
  final double? broderWidth;
  final double? focusBroderWidth;
  final int? maxLength;
  const EcoField({
    Key? key,
    required this.controller,
    this.isFilledColor = false,
    this.hintText = '',
    this.suffixPadding = 7.5,
    this.prefixPadding = 7.5,
    this.hintSize = 15.0,
    this.fontsize = 15.0,
    this.textColor = Colors.black,
    this.borderColor,
    this.maxLength,
    this.broderWidth,
    this.focusBorderColor,
    this.focusBroderWidth,
    this.readOnly = false,
    this.iconColor,
    this.fontFamily = 'Roboto',
    this.minLines = 1,
    this.onTap,
    this.textOnTap,
    this.filledColor = Colors.white,
    this.onChanged,
    this.validator,
    this.changeicon = false,
    this.prefixUrl = "",
    this.inputType = TextInputType.text,
    this.suffixUrl = "",
    this.pass = false,
    this.txtweight = FontWeight.w500,
    this.hintweight = FontWeight.w500,
    this.hintColor = Colors.grey,
    required String? Function(dynamic v) validate,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        obscureText: pass,
        readOnly: readOnly,
        minLines: minLines,
        maxLines: minLines,
        maxLength: maxLength,
        onTap: textOnTap,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textAlignVertical: TextAlignVertical.top,
        style: TextStyle(
            color: textColor,
            fontFamily: fontFamily,
            fontWeight: txtweight,
            fontSize: fontsize),
        onChanged: onChanged,
        decoration: InputDecoration(
          fillColor: filledColor,
          filled: isFilledColor,
          hintText: hintText,
          suffixIcon: suffixUrl.isNotEmpty
              ? GestureDetector(
                  onTap: onTap,
                  child: Container(
                    width: 45,
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      suffixUrl,
                      height: 20,
                      width: 20,
                    ),
                  ),
                )
              : const SizedBox(),
          prefixIcon: prefixUrl.isNotEmpty
              ? GestureDetector(
                  onTap: onTap,
                  child: Container(
                    width: 45,
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      prefixUrl,
                      width: 20,
                      height: 20,
                      color: iconColor,
                    ),
                  ),
                )
              : const SizedBox(),
          prefixIconConstraints: prefixUrl.isNotEmpty
              ? const BoxConstraints(minWidth: 50)
              : const BoxConstraints(maxWidth: 10, minWidth: 10),
          suffixIconConstraints: suffixUrl.isNotEmpty
              ? const BoxConstraints(maxWidth: 35, minWidth: 35)
              : const BoxConstraints(maxWidth: 0, minWidth: 0),
          contentPadding:
              const EdgeInsets.only(right: 15.0, top: 18, bottom: 14),
          hintStyle: TextStyle(
              color: hintColor,
              fontFamily: fontFamily,
              fontSize: hintSize,
              fontWeight: hintweight),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            // border: Border.all(color: borderColor, width: .85)
            borderSide: BorderSide(
              width: focusBroderWidth ?? 1,
              color: focusBorderColor ?? Colors.grey.shade300,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            // border: Border.all(color: borderColor, width: .85)
            borderSide: BorderSide(
              width: broderWidth ?? 1,
              color: borderColor ?? Colors.grey.shade300,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            // border: Border.all(color: borderColor, width: .85)
            borderSide: BorderSide(
              width: broderWidth ?? 1,
              color: borderColor ?? Colors.grey.shade300,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            // border: Border.all(color: borderColor, width: .85)
            borderSide: BorderSide(
              width: focusBroderWidth ?? 1,
              color: focusBorderColor ?? Colors.grey.shade300,
            ),
          ),
          alignLabelWithHint: true,
        ),
      ),
    );
  }
}
