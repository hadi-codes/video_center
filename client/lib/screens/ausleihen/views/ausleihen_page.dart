import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gui/api/api.dart';
import 'package:gui/screens/videos/bloc/videos.dart';
import 'package:gui/theme/theme.dart';
import 'package:gui/utils/locator.dart';
import 'package:gui/utils/utils.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AusleihenPage extends StatelessWidget {
  const AusleihenPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ausleihen'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          height: MediaQuery.of(context).size.height * 3 / 4,
          child: Padding(
            padding: EdgeInsets.all(50),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () =>
                        ausleihen(BlocProvider.of<VideosBloc>(context)),
                    child: Text(
                      'Ausleihen',
                    ),
                  ),
                ),
                SizedBox(width: 50),
                SizedBox(
                  height: 100,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: zurckgeben,
                    child: Text(
                      'Zürckgeben',
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ausleihen(VideosBloc videosBloc) {
    final _formKey = GlobalKey<FormState>();

    String kundeID = '';
    String videoID = '';

    Get.dialog(
        AlertDialog(
          title: Text('Ausleihen'),
          content: SizedBox(
            width: 500,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          initialValue: kundeID,
                          decoration:
                              InputDecoration(hintText: 'Kunden Nummer'),
                          onChanged: (val) => kundeID = val,
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Muss nicht leer sein';
                            else if (value.length != 4)
                              return 'Muss 4 character sein';
                            else
                              return null;
                          },
                          inputFormatters: [
                            MaskTextInputFormatter(
                                mask: '####', filter: {"#": RegExp(r'[0-9]')})
                          ],
                        ),
                      ),
                      SizedBox(width: 5.0.w),
                      Flexible(
                        child: TextFormField(
                          initialValue: videoID,
                          onChanged: (val) => videoID = val,
                          decoration: InputDecoration(hintText: 'Video Nummer'),
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Muss nicht leer sein';
                            else if (value.length != 5)
                              return 'Muss 5 character sein';
                            else
                              return null;
                          },
                          inputFormatters: [
                            MaskTextInputFormatter(
                                mask: '#####', filter: {"#": RegExp(r'[0-9]')})
                          ],
                        ),
                      ),
                    ],
                  ),
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
                    Get.back();
                    videosBloc.add(VideosAusleihen(
                        int.tryParse(kundeID), int.tryParse(videoID)));
                  } else
                    print('not vaild');
                },
                child: Text(
                  'Ausleihen',
                  style: TextStyle(color: AppTheme.blue),
                )),
          ],
        ),
        barrierColor: Colors.transparent);
  }

  zurckgeben() {
    final _formKey = GlobalKey<FormState>();

    String videoID = '';

    Get.dialog(
        AlertDialog(
          title: Text('Zürckgeben'),
          content: SizedBox(
            width: 500,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 5.0.w),
                  Flexible(
                    child: TextFormField(
                      initialValue: videoID,
                      onChanged: (val) => videoID = val,
                      decoration: InputDecoration(hintText: 'Video Nummer'),
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Muss nicht leer sein';
                        else if (value.length != 5)
                          return 'Muss 5 character sein';
                        else
                          return null;
                      },
                      inputFormatters: [
                        MaskTextInputFormatter(
                            mask: '#####', filter: {"#": RegExp(r'[0-9]')})
                      ],
                    ),
                  ),
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
                    Get.back();
                    try {
                      locator.get<VideoCenterApi>().videoZurckGeben(
                          List<int>.from([int.tryParse(videoID)]));
                      Utils.showSuccessSnackbar("Video Zürckgeben");
                    } catch (err) {
                      logger.e(err);
                      Utils.showErrorSnackbar(err.message);
                    }
                  } else
                    print('not vaild');
                },
                child: Text(
                  'Zürckgeben',
                  style: TextStyle(color: AppTheme.blue),
                )),
          ],
        ),
        barrierColor: Colors.transparent);
  }
}
