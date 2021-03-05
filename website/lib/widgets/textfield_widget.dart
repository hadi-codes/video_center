import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({
    this.title,
    this.hint,
    this.maxLines,
    this.textEditingController,
    this.onChange,
    this.helperText,
    this.errorText,
  });

  final String title;
  final String hint;
  final int maxLines;
  final Function(String) onChange;
  final TextEditingController textEditingController;
  final String helperText;
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                title,
              )),
          TextField(
            onChanged: onChange,
            controller: textEditingController,
            maxLines: maxLines,
            style: Theme.of(context).textTheme.bodyText2,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              errorText: errorText,
              helperText: helperText,
              contentPadding: const EdgeInsets.all(20),
              labelStyle: const TextStyle(color: Colors.red),
              focusColor: Theme.of(context).primaryColor,
              hintText: hint,
              filled: true,
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(10.0.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0.r),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
