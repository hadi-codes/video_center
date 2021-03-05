import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui/api/api.dart';
import 'package:gui/screens/videos/bloc/videos.dart';
import 'package:gui/screens/videos/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gui/widgets/widgets.dart';

class VideosPage extends StatelessWidget {
  const VideosPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 5.0.w),
            child: ElevatedButton(
                onPressed: () =>
                    addEditVideo(false, BlocProvider.of<VideosBloc>(context)),
                child: Text('Neu Video')),
          ),
          BlocBuilder<VideosBloc, VideosState>(
            builder: (context, state) {
              if (state is VideosLoadSuccess) {
                List<Video> videos = state.videos;

                return VideosTable(
                  videos: videos,
                );
              } else if (state is VideosLoadInProgress) {
                return LoadingIndicator();
              } else if (state is VideosLoadFailure) {
                return LoadingErrorWidget();
              } else
                return Text('idk');
            },
          )
        ],
      ),
    );
  }
}
