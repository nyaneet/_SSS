import 'package:flutter/material.dart';
import 'package:sss/presentation/core/theme/app_theme_switch.dart';
import 'package:sss/presentation/info/info_page.dart';

///
class AppWidget extends StatefulWidget {
  final AppThemeSwitch _themeSwitch;

  ///
  const AppWidget({
    super.key,
    required AppThemeSwitch themeSwitch,
  }) : _themeSwitch = themeSwitch;

  ///
  @override
  State<AppWidget> createState() => _AppWidgetState(themeSwitch: _themeSwitch);
}

///
class _AppWidgetState extends State<AppWidget> {
  final AppThemeSwitch _themeSwitch;
  // late final StreamController<DsDataPoint<bool>> _appRefreshController;
  // late void Function() _fireRefreshEvent;
  // late final CalculationStatus _calculationStatusNotifier;

  ///
  _AppWidgetState({
    required AppThemeSwitch themeSwitch,
  }) : _themeSwitch = themeSwitch;
  //
  @override
  void initState() {
    _themeSwitch.addListener(_themeSwitchListener);
    super.initState();
  }

  //
  @override
  void dispose() {
    _themeSwitch.removeListener(_themeSwitchListener);
    super.dispose();
  }

  //
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _themeSwitch.themeData,
      home: InfoPage(),
    );
  }

  ///
  void _themeSwitchListener() {
    if (mounted) {
      setState(() {
        return;
      });
    }
  }
}
