import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gui/screens/screens.dart';
import 'package:gui/theme/theme.dart';
import 'package:gui/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index;
  List<HamburgerMenuItem> _menuItems = [
    //  new HamburgerMenuItem('Overview', EvaIcons.pieChartOutline),
    new HamburgerMenuItem('Kunden', EvaIcons.peopleOutline),
    new HamburgerMenuItem('Videos', EvaIcons.videoOutline),
    new HamburgerMenuItem('Ausleihen', Icons.article_rounded)
  ];
  @override
  void initState() {
    _index = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HamburgerScaffold(
      body: IndexedStack(
        index: _index,
        children: [
          // OverviewPage(),
          KundenPage(),
          VideosPage(),
          AusleihenPage(),
        ],
      ),
      hamburgerMenu: new HamburgerMenu(
        onClick: (int val) => setState(() => _index = val),
        indicatorColor: AppTheme.grey1.withOpacity(0.3),
        selectedColor: AppTheme.whitePink,
        unselectedColor: AppTheme.grey2,
        children: _menuItems,
      ),
      backgroundColor: AppTheme.menuBackground,
    );
  }
}
