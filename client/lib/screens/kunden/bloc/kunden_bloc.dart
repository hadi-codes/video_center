import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gui/api/api.dart';
import 'package:gui/utils/utils.dart';
import 'package:meta/meta.dart';

import 'kunden.dart';

class KundenBloc extends Bloc<KundenEvent, KundenState> {
  final VideoCenterApi videoCenterApi;

  KundenBloc({@required this.videoCenterApi}) : super(KundenLoadInProgress());
  @override
  Stream<KundenState> mapEventToState(KundenEvent event) async* {
    try {
      if (event is KundenLoaded)
        yield* _mapTodosLoadedToState();
      else if (event is KundeAdded)
        yield* _mapKundeAddedToState(event);
      else if (event is KundeUpdated)
        yield* _mapKundeUpdatedToState(event);
      else if (event is KundeDeleted)
        yield* _mapKundeDeletedToState(event);
      else if (event is KundenRefresh) yield* _mapKundenRefreshToState(event);
    } catch (err) {
      logger.wtf(err);
    }
  }

  Stream<KundenState> _mapTodosLoadedToState() async* {
    try {
      final kunden = await this.videoCenterApi.getAllKunden();
      yield KundenLoadSuccess(
        kunden,
      );
    } catch (error) {
      yield KundenLoadFailure();
    }
  }

  Stream<KundenState> _mapKundeAddedToState(KundeAdded event) async* {
    if (state is KundenLoadSuccess) {
      try {
        final kunden = await this.videoCenterApi.createKunden(event.kunde);

        final List<Kunde> updatedTodos =
            List.from((state as KundenLoadSuccess).kunden)..add(kunden);
        yield KundenLoadSuccess(updatedTodos);
        Utils.showSuccessSnackbar('Kunde Eingefügt');
      } on RequestError catch (err) {
        Utils.showErrorSnackbar(err.message);
      }
    }
  }

  Stream<KundenState> _mapKundeDeletedToState(KundeDeleted event) async* {
    try {
      if (state is KundenLoadSuccess) {
        await this
            .videoCenterApi
            .deleteKunde(event.kunde.pkunr, forceDelete: true);

        final List<Kunde> updatedTodos =
            List.from((state as KundenLoadSuccess).kunden)..remove(event.kunde);
        yield KundenLoadSuccess(updatedTodos);
        Utils.showSuccessSnackbar('Kunde Gelöscht');
      }
    } on RequestError catch (err) {
      Utils.showErrorSnackbar(err.message);
    }
  }

  Stream<KundenState> _mapKundenRefreshToState(KundenRefresh event) async* {
    yield KundenLoadInProgress();
    yield* _mapTodosLoadedToState();
  }

  Stream<KundenState> _mapKundeUpdatedToState(KundeUpdated event) async* {
    try {
      if (state is KundenLoadSuccess) {
        await this
            .videoCenterApi
            .updateKunde(event.oldKunde.pkunr, event.newKunde);
        final List<Kunde> kunden =
            List.from((state as KundenLoadSuccess).kunden);
        int index = kunden
            .indexWhere((element) => element.pkunr == event.oldKunde.pkunr);
        kunden.removeAt(index);
        kunden.insert(index, event.newKunde);

        yield KundenLoadSuccess(kunden);
        Utils.showSuccessSnackbar('Kunde Aktulisert');
      }
    } on RequestError catch (err) {
      Utils.showErrorSnackbar(err.message);
    }
  }
}
