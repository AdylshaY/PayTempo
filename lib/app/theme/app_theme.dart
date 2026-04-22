import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppColors {
  const AppColors._();

  static const Color primary = Color(0xFF4F46E5);
  static const Color secondaryHighlight = Color(0xFF818CF8);
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color backgroundDark = Color(0xFF0B1020);
  static const Color surfaceDark = Color(0xFF111827);
  static const Color textPrimaryDark = Color(0xFFE2E8F0);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color inactive = Color(0xFFCBD5E1);
  static const Color inactiveDark = Color(0xFF334155);
}

class AppSpacing {
  const AppSpacing._();

  static const double xs = 8;
  static const double sm = 16;
  static const double md = 24;
}

class AppRadii {
  const AppRadii._();

  static const double button = 12;
  static const double card = 16;
  static const double hero = 24;
}

class AppTypography {
  const AppTypography._();

  static const String fontFamily = 'Roboto';

  static const TextStyle h1 = TextStyle(
    fontSize: 36,
    height: 40 / 36,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle body1 = TextStyle(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );
}

class AppTheme {
  const AppTheme._();

  static const SystemUiOverlayStyle lightSystemUi = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: AppColors.background,
    systemNavigationBarIconBrightness: Brightness.dark,
  );

  static const SystemUiOverlayStyle darkSystemUi = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: AppColors.backgroundDark,
    systemNavigationBarIconBrightness: Brightness.light,
  );

  static ThemeData get light {
    const ColorScheme colorScheme = ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondaryHighlight,
      surface: AppColors.surface,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.textPrimary,
      onError: Colors.white,
    );

    return _buildTheme(
      colorScheme: colorScheme,
      scaffoldBackground: AppColors.background,
      cardColor: AppColors.surface,
      textPrimary: AppColors.textPrimary,
      textSecondary: AppColors.textSecondary,
      inactiveColor: AppColors.inactive,
      appBarOverlay: lightSystemUi,
      isDark: false,
    );
  }

  static ThemeData get dark {
    const ColorScheme colorScheme = ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondaryHighlight,
      surface: AppColors.surfaceDark,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.textPrimaryDark,
      onError: Colors.white,
    );

    return _buildTheme(
      colorScheme: colorScheme,
      scaffoldBackground: AppColors.backgroundDark,
      cardColor: AppColors.surfaceDark,
      textPrimary: AppColors.textPrimaryDark,
      textSecondary: AppColors.textSecondaryDark,
      inactiveColor: AppColors.inactiveDark,
      appBarOverlay: darkSystemUi,
      isDark: true,
    );
  }

  static ThemeData _buildTheme({
    required ColorScheme colorScheme,
    required Color scaffoldBackground,
    required Color cardColor,
    required Color textPrimary,
    required Color textSecondary,
    required Color inactiveColor,
    required SystemUiOverlayStyle appBarOverlay,
    required bool isDark,
  }) {
    final TextTheme textTheme = const TextTheme(
      displayLarge: AppTypography.h1,
      headlineMedium: AppTypography.h2,
      titleMedium: AppTypography.h3,
      bodyMedium: AppTypography.body1,
      bodySmall: AppTypography.caption,
    ).apply(
      bodyColor: textPrimary,
      displayColor: textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: AppTypography.fontFamily,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: scaffoldBackground,
      splashFactory: InkRipple.splashFactory,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: textPrimary,
        titleTextStyle: AppTypography.h2.copyWith(color: textPrimary),
        systemOverlayStyle: appBarOverlay,
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        shadowColor: isDark
            ? Colors.black.withValues(alpha: 0.2)
            : Colors.black.withValues(alpha: 0.05),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.card),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: cardColor,
        elevation: 0,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: textSecondary,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.button),
          borderSide: BorderSide(color: inactiveColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.button),
          borderSide: BorderSide(color: inactiveColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.button),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.2),
        ),
        hintStyle: AppTypography.body1.copyWith(color: textSecondary),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          textStyle: AppTypography.body1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.button),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(48, 48),
          foregroundColor: AppColors.primary,
          textStyle: AppTypography.body1,
        ),
      ),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        minVerticalPadding: AppSpacing.xs,
      ),
    );
  }
}
