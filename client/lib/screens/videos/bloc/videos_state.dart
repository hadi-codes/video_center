import 'package:equatable/equatable.dart';
import 'package:gui/api/api.dart';

abstract class VideosState extends Equatable {
  const VideosState();

  @override
  List<Object> get props => [];
}

class VideosLoadInProgress extends VideosState {}

class VideosLoadSuccess extends VideosState {
  final List<Video> videos;
  const VideosLoadSuccess([this.videos = const []]);

  @override
  List<Object> get props => [videos];

  @override
  String toString() => 'VideosLoadSuccess { Videos: $videos }';
}

class VideosLoadFailure extends VideosState {}
