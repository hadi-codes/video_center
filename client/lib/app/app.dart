import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gui/api/api.dart';
import 'package:gui/routes/app_pages.dart';
import 'package:gui/screens/kunden/bloc/kunden.dart';
import 'package:gui/screens/videos/bloc/videos.dart';
import 'package:gui/theme/theme.dart';
import 'package:gui/utils/locator.dart';

class App extends StatelessWidget {
  const App({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              KundenBloc(videoCenterApi: locator.get<VideoCenterApi>())
                ..add(KundenLoaded()),
        ),
        BlocProvider(
          create: (context) =>
              VideosBloc(videoCenterApi: VideoCenterApi())..add(VideosLoaded()),
        ),
      ],
      child: AppView(),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360.0, 692.0),
      allowFontScaling: true,
      builder: () => GetMaterialApp(
        theme: AppTheme.themeData,
        debugShowCheckedModeBanner: false,
        navigatorKey: _navigatorKey,
        initialRoute: UserRoutes.home,
        getPages: AppPages.routes,
      ),
    );
  }
}
