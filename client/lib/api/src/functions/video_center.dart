import 'package:dio/dio.dart';
import 'package:gui/api/api.dart';
import 'package:gui/utils/constants.dart';

class VideoCenterApi {
  Dio dio = Dio(BaseOptions(baseUrl: apiServer));

  Future<List<Kunde>> getAllKunden() async {
    try {
      Response response = await dio.get("/kunde/all");
      return List.from(response.data).map((e) => Kunde.fromMap(e)).toList();
    } on DioError catch (err) {
      throw RequestError.fromMap(err.response.data);
    }
  }

  Future<Kunde> getKundeByNr(int number) async {
    try {
      Response response = await dio.get("/kunde/$number");
      return Kunde.fromMap((response.data));
    } on DioError catch (err) {
      throw RequestError.fromMap(err.response.data);
    }
  }

  Future<void> deleteKunde(int number, {bool forceDelete}) async {
    try {
      await dio.delete("/kunde/$number",
          data: {'force_delete': forceDelete ?? false});
    } on DioError catch (err) {
      throw RequestError.fromMap(err.response.data);
    }
  }

  Future<void> updateKunde(int number, Kunde kunde) async {
    try {
      await dio.patch("/kunde/$number", data: kunde.toMap());
    } on DioError catch (err) {
      throw RequestError.fromMap(err.response.data);
    }
  }

  /// Create new Kunden

  /// Get a list of all the Vidoes Information
  Future<List<Video>> getAllVideos() async {
    try {
      Response response = await dio.get("/video/all");
      return List.from(response.data).map((e) => Video.fromMap(e)).toList();
    } on DioError catch (err) {
      throw RequestError.fromMap(err.response.data);
    }
  }

  Future<Kunde> createKunden(Kunde kunde) async {
    try {
      Response response = await dio.post("/kunde/create", data: kunde.toMap());
      return Kunde.fromMap((response.data));
    } on DioError catch (err) {
      throw RequestError.fromMap(err.response.data);
    }
  }

  Future<Video> createVideo(Video video) async {
    try {
      print(video.toMap());
      Response response = await dio.post("/video/create", data: video.toMap());

      return Video.fromMap((response.data));
    } on DioError catch (err) {
      throw RequestError.fromMap(err.response.data);
    }
  }

  Future<Video> getVideoByNr(int number) async {
    try {
      Response response = await dio.get("/video/$number");
      return Video.fromMap((response.data));
    } on DioError catch (err) {
      throw RequestError.fromMap(err.response.data);
    }
  }

  Future<void> deleteVideo(int number, {bool forceDelete}) async {
    try {
      await dio.delete("/video/$number",
          data: {'force_delete': forceDelete ?? false});
    } on DioError catch (err) {
      throw RequestError.fromMap(err.response.data);
    }
  }

  Future<void> videoAusleihen(int videoID, int kundenID) async {
    try {
      await dio
          .post("/video/leihen", data: {"Fkunr": kundenID, "Fvidnr": videoID});
    } catch (err) {
      throw RequestError(message: "Error");
    }
  }

  Future<void> videoZurckGeben(List<int> videosIDs) async {
    try {
      await dio.delete("/video/return", data: {"videos": videosIDs});
    } on DioError catch (err) {
      throw RequestError.fromMap(err.response.data);
    }
  }

  Future<void> updateVideo(int number, Video video) async {
    try {
      await dio.patch("/video/$number", data: video.toMap());
    } on DioError catch (err) {
      throw RequestError.fromMap(err.response.data);
    }
  }
}
