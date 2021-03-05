import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    Key key,
    this.imgUrl,
    this.borderRadius,
  }) : super(key: key);
  final BorderRadius borderRadius;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    //TODO: fix images
    return Container();
    // return ExtendedImage.network(imgUrl,
    //     shape: BoxShape.rectangle,
    //     borderRadius: borderRadius ?? BorderRadius.circular(10.0.r),
    //     loadStateChanged: (ExtendedImageState state) {
    //   switch (state.extendedImageLoadState) {
    //     case LoadState.loading:
    //       return Container(
    //         decoration: BoxDecoration(
    //             borderRadius: borderRadius ?? BorderRadius.circular(10.0.r)),
    //         child: Shimmer.fromColors(
    //           baseColor: Colors.grey[300],
    //           highlightColor: Colors.grey[100],
    //           enabled: true,
    //           child: Container(),
    //         ),
    //       );
    //       break;
    //     case LoadState.completed:
    //       return ExtendedRawImage(
    //         fit: BoxFit.cover,
    //         image: state.extendedImageInfo?.image,
    //       );
    //       break;
    //     case LoadState.failed:
    //       return const Icon(Icons.error);
    //       break;
    //     default:
    //       return Container(
    //           decoration: BoxDecoration(
    //         borderRadius: borderRadius ?? BorderRadius.circular(10.0.r),
    //         border: Border.all(color: Theme.of(context).accentColor),
    //         color: Colors.black,
    //       ));
    //       break;
    //   }
    // });
  }
}
