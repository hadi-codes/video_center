import 'package:equatable/equatable.dart';
import 'package:gui/api/api.dart';

abstract class VideosEvent extends Equatable {
  const VideosEvent();

  @override
  List<Object> get props => [];
}

class VideosLoaded extends VideosEvent {}

class VideoAdded extends VideosEvent {
  final Video video;

  const VideoAdded(this.video);

  @override
  List<Object> get props => [video];

  @override
  String toString() => 'VideoAdded { Video: $video }';
}

class VideoUpdated extends VideosEvent {
  final Video newVideo;
  final Video oldVideo;
  const VideoUpdated({this.oldVideo, this.newVideo});

  @override
  List<Object> get props => [oldVideo, newVideo];

  @override
  String toString() => 'VideoUpdated { Updated Video: $newVideo }';
}

class VideoDeleted extends VideosEvent {
  final Video video;

  const VideoDeleted(this.video);

  @override
  List<Object> get props => [video];

  @override
  String toString() => 'VideoDeleted { Video: $video }';
}
