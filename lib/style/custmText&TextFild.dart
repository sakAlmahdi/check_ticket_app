import 'package:check_ticket_app/custmSnackBar.dart';
import 'package:check_ticket_app/style/color.dart';
import 'package:flutter/material.dart';


class MyTextInput extends StatelessWidget {
  const MyTextInput(
      {
      required this.textEditingController,
      this.labelText="",
        this.keyboardType:TextInputType.text,
  required this.errorTxt});

  final TextEditingController textEditingController;
  final String labelText;
  final TextInputType keyboardType;
  final FormFieldValidator<String> errorTxt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTextView(
            text: labelText,
          ),
          TextFormField(
            decoration: InputDecoration(
              filled: true,
              fillColor: CustomColor.whiteClr,
              errorMaxLines: 2,
              contentPadding: EdgeInsets.symmetric(horizontal: 2),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: CustomColor.primClr, width: 1.5)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: CustomColor.primClr, width: 1.5),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: CustomColor.primClr, width: 1.5)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: const BorderSide(width: 1.5, color: Colors.red)),
              errorStyle: CustomTextStyle(textClr:Colors.red,textSize: 11).txtStyle(),
              hintText: " ادخل $labelText",
              hintStyle: CustomTextStyle(textClr:Colors.red,textSize: 12).txtStyle(),
            ),
            style: CustomTextStyle(textClr:Colors.black,textSize: 14).txtStyle(),
            textInputAction: TextInputAction.next,
            keyboardType: keyboardType,
            controller: textEditingController,
            cursorColor:CustomColor.primClr,
            validator: (x) => x!.isEmpty ?"$labelText مطلوب ":null,
          ),
        ],
      ),
    );
  }
}

