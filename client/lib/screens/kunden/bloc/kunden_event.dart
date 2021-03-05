import 'package:equatable/equatable.dart';
import 'package:gui/api/api.dart';

abstract class KundenEvent extends Equatable {
  const KundenEvent();

  @override
  List<Object> get props => [];
}

class KundenLoaded extends KundenEvent {}

class KundenRefresh extends KundenEvent {}

class KundeAdded extends KundenEvent {
  final Kunde kunde;

  const KundeAdded(this.kunde);

  @override
  List<Object> get props => [kunde];

  @override
  String toString() => 'KundeAdded { Kunde: $kunde }';
}

class KundeUpdated extends KundenEvent {
  final Kunde newKunde;
  final Kunde oldKunde;
  const KundeUpdated({this.oldKunde, this.newKunde});

  @override
  List<Object> get props => [oldKunde, newKunde];

  @override
  String toString() => 'KundeUpdated { Updated Kunde: $newKunde }';
}

class KundeDeleted extends KundenEvent {
  final Kunde kunde;

  const KundeDeleted(this.kunde);

  @override
  List<Object> get props => [kunde];

  @override
  String toString() => 'KundeDeleted { Kunde: $kunde }';
}
