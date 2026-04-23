import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/isar_database.dart';
import 'package:pay_tempo/data/local/services/user_settings_service.dart';
import 'package:pay_tempo/features/dashboard/dashboard_screen.dart';
import 'package:pay_tempo/features/onboarding/onboarding_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDatabase.instance.open();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      builder: (BuildContext context, Widget? child) {
        final Brightness brightness = Theme.of(context).brightness;
        final SystemUiOverlayStyle overlayStyle = brightness == Brightness.dark
            ? AppTheme.darkSystemUi
            : AppTheme.lightSystemUi;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: overlayStyle,
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const _AppBootstrapScreen(),
    );
  }
}

class _AppBootstrapScreen extends StatefulWidget {
  const _AppBootstrapScreen();

  @override
  State<_AppBootstrapScreen> createState() => _AppBootstrapScreenState();
}

class _AppBootstrapScreenState extends State<_AppBootstrapScreen> {
  final UserSettingsService _settingsService = UserSettingsService();
  late Future<bool> _hasBaseCurrency;

  @override
  void initState() {
    super.initState();
    _hasBaseCurrency = _settingsService.hasBaseCurrency();
  }

  Future<void> _refreshStatus() async {
    final bool hasBaseCurrency = await _settingsService.hasBaseCurrency();
    if (!mounted) {
      return;
    }

    setState(() {
      _hasBaseCurrency = Future<bool>.value(hasBaseCurrency);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _hasBaseCurrency,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if ((snapshot.data ?? false) == false) {
          return OnboardingScreen(
            onCompleted: _refreshStatus,
          );
        }

        return FutureBuilder<String>(
          future: _settingsService
              .getSettings()
              .then((settings) => settings?.baseCurrency ?? 'USD'),
          builder: (BuildContext context, AsyncSnapshot<String> currencySnap) {
            if (currencySnap.connectionState != ConnectionState.done) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }

            return DashboardScreen(
              baseCurrency: currencySnap.data ?? 'USD',
            );
          },
        );
      },
    );
  }
}
