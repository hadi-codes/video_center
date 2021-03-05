import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({
    this.title,
    this.hasBorder,
    this.onPressed,
  });
  final String title;
  final bool hasBorder;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Material(
        child: Ink(
          decoration: BoxDecoration(
            color: hasBorder ? Colors.white : Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10.0.r),
            border: hasBorder
                ? Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 1.0,
                  )
                : const Border.fromBorderSide(BorderSide.none),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(10.0.r),
            child: Container(
              height: 60.0,
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: hasBorder
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
