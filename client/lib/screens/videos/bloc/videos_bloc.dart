import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gui/api/api.dart';
import 'package:gui/utils/utils.dart';
import 'package:meta/meta.dart';

import 'videos.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  final VideoCenterApi videoCenterApi;

  VideosBloc({@required this.videoCenterApi}) : super(VideosLoadInProgress());
  @override
  Stream<VideosState> mapEventToState(VideosEvent event) async* {
    try {
      if (event is VideosLoaded)
        yield* _mapTodosLoadedToState();
      else if (event is VideoAdded)
        yield* _mapVideoAddedToState(event);
      else if (event is VideoUpdated)
        yield* _mapVideoUpdatedToState(event);
      else if (event is VideoDeleted)
        yield* _mapVideoDeletedToState(event);
      else if (event is VideosAusleihen)
        yield* _mapVideosAusleihenToState(event);
    } catch (err) {
      logger.e(' VideosBloc mapEventToState $err');
    }
  }

  Stream<VideosState> _mapTodosLoadedToState() async* {
    try {
      final videos = await this.videoCenterApi.getAllVideos();
      yield VideosLoadSuccess(
        videos,
      );
    } catch (error) {
      yield VideosLoadFailure();
    }
  }

  Stream<VideosState> _mapVideosAusleihenToState(VideosAusleihen event) async* {
    try {
      await this.videoCenterApi.videoAusleihen(event.videoID, event.kundenID);
      Utils.showSuccessSnackbar('Video Ausleihen');
    } on RequestError catch (err) {
      Utils.showErrorSnackbar(err.message);
    }
  }

  Stream<VideosState> _mapVideoAddedToState(VideoAdded event) async* {
    try {
      if (state is VideosLoadSuccess) {
        final Video video = await videoCenterApi.createVideo(event.video);

        final List<Video> updatedVideos =
            List.from((state as VideosLoadSuccess).videos)..add(video);
        yield VideosLoadSuccess(updatedVideos);
        Utils.showSuccessSnackbar('Video Eingefügt');
      }
    } on RequestError catch (err) {
      Utils.showErrorSnackbar(err.message);
    }
  }

  Stream<VideosState> _mapVideoDeletedToState(VideoDeleted event) async* {
    try {
      if (state is VideosLoadSuccess) {
        await this
            .videoCenterApi
            .deleteVideo(event.video.pvidnr, forceDelete: true);

        final List<Video> updatedVideos =
            List.from((state as VideosLoadSuccess).videos)..remove(event.video);
        yield VideosLoadSuccess(updatedVideos);
        Utils.showSuccessSnackbar('Video Gelöscht');
      }
    } on RequestError catch (err) {
      Utils.showErrorSnackbar(err.message);
    }
  }

  Stream<VideosState> _mapVideoUpdatedToState(VideoUpdated event) async* {
    try {
      if (state is VideosLoadSuccess) {
        await this
            .videoCenterApi
            .updateVideo(event.oldVideo.pvidnr, event.newVideo);
        final List<Video> kunden =
            List.from((state as VideosLoadSuccess).videos);
        int index = kunden
            .indexWhere((element) => element.pvidnr == event.oldVideo.pvidnr);
        kunden.removeAt(index);
        kunden.insert(index, event.newVideo);

        yield VideosLoadSuccess(kunden);
        Utils.showSuccessSnackbar('Video Aktulisert');
      }
    } on RequestError catch (err) {
      Utils.showErrorSnackbar(err.message);
    }
  }
}
