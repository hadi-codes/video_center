import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:gui/api/api.dart';
import 'package:gui/screens/videos/bloc/videos.dart';
import 'package:gui/theme/theme.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VideosTable extends StatelessWidget {
  const VideosTable({
    Key key,
    this.videos,
  }) : super(key: key);
  final List<Video> videos;
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
                  'Title',
                ),
              ),
              DataColumn(
                label: Text(
                  'kategorie',
                ),
              ),
              DataColumn(
                label: Text(
                  'FSK',
                ),
              ),
              DataColumn(
                label: Text(
                  'Medium',
                ),
              ),
              DataColumn(
                label: Text(
                  'Jahr',
                ),
              ),
              DataColumn(
                label: Text(
                  'Options',
                ),
              ),
            ],
            rows: videos
                .map((video) => DataRow(cells: [
                      DataCell(
                        Text(video.pvidnr.toString()),
                      ),
                      DataCell(
                        Text(video.vidtitle),
                      ),
                      DataCell(Text(video.vidkategorie)),
                      DataCell(
                        Text(video.vidfsk),
                      ),
                      DataCell(
                        Text(video.vidmedium),
                      ),
                      DataCell(
                        Text(video.vidjahr),
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
                                onPressed: () => addEditVideo(
                                    true, BlocProvider.of<VideosBloc>(context),
                                    oldVideo: video)),
                            IconButton(
                                tooltip: 'Delete',
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => context
                                    .read<VideosBloc>()
                                    .add(VideoDeleted(video))),
                          ],
                        ),
                      ),
                    ]))
                .toList()),
      ),
    );
  }
}

addEditVideo(bool isEditMode, VideosBloc bloc, {Video oldVideo}) {
  final _formKey = GlobalKey<FormState>();

  String title = '';
  String kategorie = '';
  String fsk = '';
  String medium = '';
  String jahr = '';
  Video _oldVideo = oldVideo ?? Video();
  if (isEditMode) {
    title = oldVideo.vidtitle;
    kategorie = oldVideo.vidkategorie;
    fsk = oldVideo.vidfsk;
    medium = oldVideo.vidmedium;
    jahr = oldVideo.vidjahr;
  }
  Get.dialog(
      AlertDialog(
        title: Text(isEditMode ? 'Edit Video' : 'Neu Video'),
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
                        initialValue: title,
                        decoration: InputDecoration(hintText: 'Title'),
                        onChanged: (val) => title = val,
                        validator: (value) =>
                            value.isEmpty ? 'Muss nicht leer sein' : null,
                      ),
                    ),
                    SizedBox(width: 5.0.w),
                    Flexible(
                      child: TextFormField(
                        initialValue: kategorie,
                        onChanged: (val) => kategorie = val,
                        decoration: InputDecoration(hintText: 'Kategorie'),
                        validator: (value) =>
                            value.isEmpty ? 'Muss nicht leer sein' : null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0.h),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        inputFormatters: [
                          MaskTextInputFormatter(
                              mask: '####', filter: {"#": RegExp(r'[0-9]')})
                        ],
                        initialValue: jahr,
                        decoration: InputDecoration(hintText: 'Jahr'),
                        onChanged: (val) => jahr = val,
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Muss nicht leer sein';
                          else if (value.length != 4)
                            return 'Jahr muss 4 character sein';
                          else
                            return null;
                        },
                      ),
                    ),
                    SizedBox(width: 5.0.w),
                    Flexible(
                      child: TextFormField(
                        inputFormatters: [
                          MaskTextInputFormatter(
                              mask: '##', filter: {"#": RegExp(r'[0-9]')})
                        ],
                        initialValue: fsk,
                        decoration: InputDecoration(hintText: 'fsk'),
                        onChanged: (val) => fsk = val,
                        validator: (value) =>
                            value.isEmpty ? 'Muss nicht leer sein' : null,
                      ),
                    ),
                    SizedBox(width: 5.0.w),
                    Flexible(
                      child: TextFormField(
                        initialValue: medium,
                        decoration: InputDecoration(hintText: 'Medium'),
                        onChanged: (val) => medium = val,
                        validator: (value) =>
                            value.isEmpty ? 'Muss nicht leer sein' : null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0.h),
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
                  Video newVideo = _oldVideo.copyWith(
                      vidtitle: title,
                      vidkategorie: kategorie,
                      vidfsk: fsk,
                      vidmedium: medium,
                      vidjahr: jahr);
                  if (isEditMode)
                    bloc.add(
                        VideoUpdated(oldVideo: _oldVideo, newVideo: newVideo));
                  else
                    bloc.add(VideoAdded(newVideo));
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
