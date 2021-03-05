import 'package:flutter/material.dart';

class LoadingErrorWidget extends StatelessWidget {
  const LoadingErrorWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Container(
          //     height: 150.w,
          //     width: 150.w,
          //     child: SvgPicture.asset('assets/icons/warning.svg')),
          Text(
            'Something gone wrong ...',
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}
