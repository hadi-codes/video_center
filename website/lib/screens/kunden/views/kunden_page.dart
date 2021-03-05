import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gui/api/api.dart';
import 'package:gui/screens/kunden/bloc/kunden.dart';
import 'package:gui/screens/kunden/bloc/kunden_bloc.dart';
import 'package:gui/screens/kunden/widgets/widgets.dart';

import 'package:gui/widgets/loading_error.dart';
import 'package:gui/widgets/loading_indicator.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class KundenPage extends StatefulWidget {
  const KundenPage({Key key}) : super(key: key);

  @override
  _KundenPageState createState() => _KundenPageState();
}

class _KundenPageState extends State<KundenPage> {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kunden'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0.h, horizontal: 5.0.w),
            child: ElevatedButton(
                onPressed: () =>
                    addEditKunde(false, BlocProvider.of<KundenBloc>(context)),
                child: Text('Neu Kunde')),
          ),
          BlocBuilder<KundenBloc, KundenState>(
            builder: (context, state) {
              if (state is KundenLoadSuccess) {
                List<Kunde> kunden = state.kunden;

                return KundenTable(
                  kunden: kunden,
                );
              } else if (state is KundenLoadInProgress) {
                return LoadingIndicator();
              } else if (state is KundenLoadFailure) {
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
