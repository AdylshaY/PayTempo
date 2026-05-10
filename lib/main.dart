import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_tempo/app/theme/app_theme.dart';
import 'package:pay_tempo/data/local/isar_database.dart';
import 'package:pay_tempo/features/navigation/app_shell_screen.dart';
import 'package:pay_tempo/features/onboarding/onboarding_screen.dart';
import 'package:pay_tempo/features/onboarding/data/user_settings_service.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pay_tempo/l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDatabase.instance.open();
  await UserSettingsService().initializeSettings();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: UserSettingsService.appThemeNotifier,
      builder: (context, themeMode, _) {
        return ValueListenableBuilder<String?>(
          valueListenable: UserSettingsService.appLanguageNotifier,
          builder: (context, languageCode, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeMode,
              locale: languageCode != null ? Locale(languageCode) : null,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
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
          },
        );
      },
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

            return AppShellScreen(
              baseCurrency: currencySnap.data ?? 'USD',
            );
          },
        );
      },
    );
  }
}
