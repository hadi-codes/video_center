import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:gui/api/api.dart';
import 'package:gui/theme/theme.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/kunden.dart';

class KundenTable extends StatelessWidget {
  const KundenTable({
    Key key,
    this.kunden,
  }) : super(key: key);
  final List<Kunde> kunden;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: EdgeInsets.all(20.0),
        height: MediaQuery.of(context).size.height * 3 / 4,
        child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'Id',
                ),
              ),
              DataColumn(
                label: Text(
                  'Name',
                ),
              ),
              DataColumn(
                label: Text(
                  'Addresse',
                ),
              ),
              DataColumn(
                label: Text(
                  'Gebustdatum',
                ),
              ),
              DataColumn(
                label: Text(
                  'Videos',
                ),
              ),
              DataColumn(
                label: Text(
                  'Options',
                ),
              ),
            ],
            rows: kunden
                .map((kunde) => DataRow(cells: [
                      DataCell(
                        Text(kunde.pkunr.toString()),
                      ),
                      DataCell(
                        Text(kunde.name),
                      ),
                      DataCell(
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(kunde.addstrasse),
                            SizedBox(height: 2.0.h),
                            Text('${kunde.addplz} ${kunde.addort}')
                          ],
                        ),
                      ),
                      DataCell(
                        Text(kunde.geburstDatum),
                      ),
                      DataCell(
                        Text(kunde.videos?.length.toString()),
                      ),
                      DataCell(
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                tooltip: 'Edit',
                                icon: Icon(
                                  EvaIcons.editOutline,
                                  color: AppTheme.blue,
                                ),
                                onPressed: () => addEditKunde(
                                    true, BlocProvider.of<KundenBloc>(context),
                                    oldKunde: kunde)),
                            IconButton(
                                tooltip: 'Delete',
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => context
                                    .read<KundenBloc>()
                                    .add(KundeDeleted(kunde))),
                          ],
                        ),
                      ),
                    ]))
                .toList()),
      ),
    );
  }
}

addEditKunde(bool isEditMode, KundenBloc bloc, {Kunde oldKunde}) {
  final _formKey = GlobalKey<FormState>();

  String vorname = '';
  String nachname = '';
  String strasse = '';
  String ort = '';
  String plz = '';
  String geburstdatum = '';
  Kunde _oldKunde = oldKunde ?? Kunde();
  if (isEditMode) {
    vorname = oldKunde.kuvorname;
    nachname = oldKunde.kunachname;
    strasse = oldKunde.addstrasse;
    ort = oldKunde.addort;
    plz = oldKunde.addplz;
    geburstdatum = oldKunde.geburstDatum;
  }
  Get.dialog(
      AlertDialog(
        title: Text(isEditMode ? 'Edit Kunde' : 'Neu Kunde'),
        content: SizedBox(
          width: 700,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        initialValue: vorname,
                        decoration: InputDecoration(hintText: 'Vorname'),
                        onChanged: (val) => vorname = val,
                        validator: (value) =>
                            value.isEmpty ? 'Muss nicht leer sein' : null,
                      ),
                    ),
                    SizedBox(width: 5.0.w),
                    Flexible(
                      child: TextFormField(
                        initialValue: nachname,
                        onChanged: (val) => nachname = val,
                        decoration: InputDecoration(hintText: 'Nachname'),
                        validator: (value) =>
                            value.isEmpty ? 'Muss nicht leer sein' : null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0.h),
                TextFormField(
                  initialValue: strasse,
                  decoration: InputDecoration(hintText: 'Straße'),
                  onChanged: (val) => strasse = val,
                  validator: (value) =>
                      value.isEmpty ? 'Muss nicht leer sein' : null,
                ),
                SizedBox(height: 10.0.h),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        inputFormatters: [
                          MaskTextInputFormatter(
                              mask: '#####', filter: {"#": RegExp(r'[0-9]')})
                        ],
                        initialValue: plz,
                        decoration: InputDecoration(hintText: 'PLZ'),
                        onChanged: (val) => plz = val,
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Muss nicht leer sein';
                          else if (value.length != 5)
                            return 'PLZ muss 5 character sein';
                          else
                            return null;
                        },
                      ),
                    ),
                    SizedBox(width: 5.0.w),
                    Flexible(
                      child: TextFormField(
                        initialValue: ort,
                        decoration: InputDecoration(hintText: 'Ort'),
                        onChanged: (val) => ort = val,
                        validator: (value) =>
                            value.isEmpty ? 'Muss nicht leer sein' : null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0.h),
                TextFormField(
                  initialValue: geburstdatum,
                  onChanged: (val) => geburstdatum = val,
                  validator: (value) {
                    if (value.isEmpty)
                      return 'Muss nicht leer sein';
                    else if (value.length != 10)
                      return 'Not vaild date';
                    else
                      return null;
                  },
                  decoration: InputDecoration(hintText: 'Geburtsdatum'),
                  inputFormatters: [
                    MaskTextInputFormatter(
                        mask: '####-##-##', filter: {"#": RegExp(r'[0-9]')})
                  ],
                )
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
              onPressed: Get.back,
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              )),
          TextButton(
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  Kunde newkunde = _oldKunde.copyWith(
                    kuvorname: vorname,
                    kunachname: nachname,
                    kugeburtsdatum: DateTime.tryParse(geburstdatum),
                    addort: ort,
                    addplz: plz,
                    addstrasse: strasse,
                  );
                  if (isEditMode)
                    bloc.add(
                        KundeUpdated(oldKunde: _oldKunde, newKunde: newkunde));
                  else
                    bloc.add(KundeAdded(newkunde));
                  Get.back();
                } else
                  print('not vaild');
              },
              child: Text(
                isEditMode ? 'Update' : 'Add',
                style: TextStyle(color: AppTheme.blue),
              )),
        ],
      ),
      barrierColor: Colors.transparent);
}
