import 'dart:convert';

import 'package:equatable/equatable.dart';

class Video extends Equatable {
  final int pvidnr;
  final String vidtitle;
  final String vidmedium;
  final String vidkategorie;
  final String vidfsk;
  final String vidjahr;
  final String vidimg;
  Video({
    this.pvidnr,
    this.vidtitle,
    this.vidmedium,
    this.vidkategorie,
    this.vidfsk,
    this.vidjahr,
    this.vidimg,
  });

  Video copyWith({
    int pvidnr,
    String vidtitle,
    String vidmedium,
    String vidkategorie,
    String vidfsk,
    String vidjahr,
    String vidimg,
  }) {
    return Video(
      pvidnr: pvidnr ?? this.pvidnr,
      vidtitle: vidtitle ?? this.vidtitle,
      vidmedium: vidmedium ?? this.vidmedium,
      vidkategorie: vidkategorie ?? this.vidkategorie,
      vidfsk: vidfsk ?? this.vidfsk,
      vidjahr: vidjahr ?? this.vidjahr,
      vidimg: vidimg ?? this.vidimg,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      //  'pvidnr': pvidnr,
      'vidtitle': vidtitle,
      'vidmedium': vidmedium,
      'vidkategorie': vidkategorie,
      'vidfsk': vidfsk,
      'vidjahr': vidjahr,
      // 'vidimg': vidimg,
    };
  }

  factory Video.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Video(
      pvidnr: map['Pvidnr'],
      vidtitle: map['vidtitle'],
      vidmedium: map['vidmedium'],
      vidkategorie: map['vidkategorie'],
      vidfsk: map['vidfsk'],
      vidjahr: map['vidjahr'].toString(),
      // vidimg: map['vidimg'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Video.fromJson(String source) => Video.fromMap(json.decode(source));

  @override
  List<Object> get props {
    return [
      // pvidnr,
      vidtitle,
      vidmedium,
      vidkategorie,
      vidfsk,
      vidjahr,
      // vidimg,
    ];
  }
}
