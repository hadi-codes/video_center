import 'package:equatable/equatable.dart';
import 'package:gui/api/api.dart';

abstract class KundenState extends Equatable {
  const KundenState();

  @override
  List<Object> get props => [];
}

class KundenLoadInProgress extends KundenState {}

class KundenLoadSuccess extends KundenState {
  final List<Kunde> kunden;
  const KundenLoadSuccess([this.kunden = const []]);

  @override
  List<Object> get props => [kunden];

  @override
  String toString() => 'KundenLoadSuccess { Kunden: $kunden }';
}

class KundenLoadFailure extends KundenState {}
