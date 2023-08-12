import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';

textField({
  hint,
  image,
  maxLines,
  keyboardType,
  validator,
  minline,
  controller,
  suffixIcon,
  obscureText,
  prefixIcon,
  readOnly,
  onTap,
  inputFormatters,
  length,
  horizontalpadding,
  verticalpading,
  onEditingComplete,
  autovalidateMode,
  onChanged,
  autofocus,
  focusNode,
  backgroundcolor,
  textInputAction,
  child,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: horizontalpadding ?? 0, vertical: verticalpading ?? 7),
    child: TextFormField(
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      onTap: onTap,
      focusNode: focusNode,
      validator: validator,
      keyboardType: keyboardType,
      textInputAction: textInputAction ?? TextInputAction.done,
      controller: controller,
      maxLines: maxLines,
      minLines: minline,
      autofocus: autofocus ?? false,
      autovalidateMode:
      autovalidateMode ?? AutovalidateMode.onUserInteraction,
      readOnly: readOnly ?? false,
      cursorColor: AppColor.purple,
      obscureText: obscureText ?? false,
      style: const TextStyle(fontSize: 14, letterSpacing: 0.2),
      inputFormatters: [
        LengthLimitingTextInputFormatter(length),
      ],
      decoration: InputDecoration(
        fillColor: AppColor.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 14.0,horizontal: 15),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: AppColor.lightPurple,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: AppColor.lightPurple,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.secondary,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(8)),
        suffixIcon: suffixIcon,
        icon: prefixIcon,
        isDense: true,
        hintText: hint,
        errorMaxLines: 2,
        errorStyle: const TextStyle(height: 0, fontSize: 10),
        hintStyle: TextStyle(
          color: AppColor.purple,
          fontSize: 15,
          fontFamily: 'Rubik',
        ),
      ),
      // textCapitalization: TextCapitalization.sentences,
    ),
  );
}


textField2({
  hint,
  image,
  maxLines,
  keyboardType,
  validator,
  minline,
  controller,
  suffixIcon,
  obscureText,
  prefixIcon,
  readOnly,
  onTap,
  inputFormatters,
  length,
  horizontalpadding,
  verticalpading,
  onEditingComplete,
  autovalidateMode,
  onChanged,
  autofocus,
  focusNode,
  backgroundcolor,
  textInputAction,
  child,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: horizontalpadding ?? 0, vertical: verticalpading ?? 7),
    child: SizedBox(
      height: 150,
      child: TextFormField(
        onEditingComplete: onEditingComplete,
        onChanged: onChanged,
        onTap: onTap,
        focusNode: focusNode,
        validator: validator,
        keyboardType: keyboardType,
        textInputAction: textInputAction ?? TextInputAction.done,
        controller: controller,
        maxLines: maxLines,
        minLines: minline,
        autofocus: autofocus ?? false,
        autovalidateMode:
        autovalidateMode ?? AutovalidateMode.onUserInteraction,
        readOnly: readOnly ?? false,
        cursorColor: AppColor.purple,
        obscureText: obscureText ?? false,
        style: const TextStyle(fontSize: 14, letterSpacing: 0.2),
        inputFormatters: [
          LengthLimitingTextInputFormatter(length),
        ],
        decoration: InputDecoration(
          fillColor: AppColor.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: AppColor.lightPurple,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: AppColor.lightPurple,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColor.secondary,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(8)),
          suffixIcon: suffixIcon,
          icon: prefixIcon,
          isDense: true,
          hintText: hint,
          errorMaxLines: 2,
          errorStyle: const TextStyle(height: 0, fontSize: 10),
          hintStyle: TextStyle(
            color: AppColor.purple,
            fontSize: 15,
            fontFamily: 'Rubik',
          ),
        ),
        // textCapitalization: TextCapitalization.sentences,
      ),
    ),
  );
}
