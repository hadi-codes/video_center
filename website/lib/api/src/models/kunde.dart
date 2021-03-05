import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Kunde extends Equatable {
  final int pkunr;
  final String kuvorname;
  final String kunachname;
  final String addstrasse;
  final String addplz;
  final String addort;
  final List<int> videos;

  final DateTime kugeburtsdatum;
  Kunde({
    this.pkunr,
    this.kuvorname,
    this.kunachname,
    this.addstrasse,
    this.addplz,
    this.addort,
    this.videos,
    this.kugeburtsdatum,
  });

  Kunde copyWith({
    int pkunr,
    String kuvorname,
    String kunachname,
    String addstrasse,
    String addplz,
    String addort,
    List<int> videos,
    DateTime kugeburtsdatum,
  }) {
    return Kunde(
      pkunr: pkunr ?? this.pkunr,
      kuvorname: kuvorname ?? this.kuvorname,
      kunachname: kunachname ?? this.kunachname,
      addstrasse: addstrasse ?? this.addstrasse,
      addplz: addplz ?? this.addplz,
      addort: addort ?? this.addort,
      videos: videos ?? this.videos,
      kugeburtsdatum: kugeburtsdatum ?? this.kugeburtsdatum,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'pkunr': pkunr,
      'kuvorname': kuvorname,
      'kunachname': kunachname,
      'addstrasse': addstrasse,
      'addplz': addplz,
      'addort': addort,
      //  'videos': videos,

      'kugeburtsdatum': DateFormat('yyyy-MM-dd').format(kugeburtsdatum),
    };
  }

  Map<String, dynamic> dataMap() {
    return {
      'id': pkunr,
      'name': name,
      'addresse': address,
      'videos': videos.length,
      'geburstdatum': DateFormat('yyyy-MM-dd').format(kugeburtsdatum),
    };
  }

  factory Kunde.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Kunde(
      pkunr: map['Pkunr'],
      kuvorname: map['kuvorname'],
      kunachname: map['kunachname'],
      addstrasse: map['addstrasse'],
      addplz: map['addplz'],
      addort: map['addort'],
      videos: List<int>.from(map['videos'] ?? []),
      kugeburtsdatum: DateTime.parse(map['kugeburtsdatum']),
    );
  }

  String toJson() => json.encode(toMap());
  String get geburstDatum {
    String formatedDate = DateFormat('yyyy-MM-dd').format(kugeburtsdatum);
    return formatedDate != '0001-00-30' ? formatedDate : '';
  }

  String get name => '$kuvorname $kunachname';
  String get address =>
      addstrasse != null ? '$addstrasse, $addplz $addort' : '';

  factory Kunde.fromJson(String source) => Kunde.fromMap(json.decode(source));

  @override
  List<Object> get props {
    return [
      // pkunr,
      kuvorname,
      kunachname,
      addstrasse,
      addplz,
      addort,
      // videos,
      kugeburtsdatum,
    ];
  }
}
