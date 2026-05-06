import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
AppTheme._();

// ============ DARK THEME ============
static ThemeData get darkTheme {
return ThemeData(
useMaterial3: true,
brightness: Brightness.dark,

  colorScheme: const ColorScheme.dark(
    primary: AppColors.accent,
    onPrimary: AppColors.primaryDark,
    primaryContainer: AppColors.accentDark,
    onPrimaryContainer: AppColors.textPrimaryDark,
    secondary: AppColors.primaryLight,
    onSecondary: AppColors.textPrimaryDark,
    secondaryContainer: AppColors.surfaceCard,
    onSecondaryContainer: AppColors.textPrimaryDark,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.textPrimaryDark,
    surfaceContainerHighest: AppColors.surfaceElevated,
    error: AppColors.error,
    onError: Colors.white,
  ),

  scaffoldBackgroundColor: AppColors.surfaceDark,

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    titleTextStyle: TextStyle(
      fontFamily: 'SF Pro Display',
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryDark,
    ),
    iconTheme: IconThemeData(color: AppColors.textPrimaryDark),
  ),

  // ✅ FIXED
  cardTheme: CardThemeData(
    color: AppColors.surfaceCard,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    margin: EdgeInsets.zero,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.accent,
      foregroundColor: AppColors.primaryDark,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: AppTypography.labelLarge,
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.accent,
      side: const BorderSide(color: AppColors.accent, width: 1.5),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: AppTypography.labelLarge,
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.accent,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      textStyle: AppTypography.labelLarge,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceCard,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: AppColors.textTertiaryDark.withOpacity(0.2),
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.accent, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.error, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.error, width: 2),
    ),
    labelStyle: AppTypography.bodyMedium.copyWith(
      color: AppColors.textSecondaryDark,
    ),
    hintStyle: AppTypography.bodyMedium.copyWith(
      color: AppColors.textTertiaryDark,
    ),
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.surfaceElevated,
    selectedItemColor: AppColors.accent,
    unselectedItemColor: AppColors.textTertiaryDark,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
    selectedLabelStyle: AppTypography.labelSmall,
    unselectedLabelStyle: AppTypography.labelSmall,
  ),

  // ✅ FIXED
  tabBarTheme: TabBarThemeData(
    labelColor: AppColors.accent,
    unselectedLabelColor: AppColors.textSecondaryDark,
    labelStyle: AppTypography.labelLarge,
    unselectedLabelStyle: AppTypography.labelLarge,
    indicator: const BoxDecoration(
      border: Border(
        bottom: BorderSide(color: AppColors.accent, width: 2),
      ),
    ),
    dividerColor: Colors.transparent,
  ),

  chipTheme: ChipThemeData(
    backgroundColor: AppColors.surfaceCard,
    labelStyle: AppTypography.labelMedium.copyWith(
      color: AppColors.textPrimaryDark,
    ),
    side: BorderSide.none,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),

  textTheme: _buildTextTheme(isDark: true),
);

}

// ============ LIGHT THEME ============
static ThemeData get lightTheme {
return ThemeData(
useMaterial3: true,
brightness: Brightness.light,

  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: Colors.white,
    primaryContainer: AppColors.primaryLight,
    onPrimaryContainer: Colors.white,
    secondary: AppColors.accentDark,
    onSecondary: Colors.white,
    secondaryContainer: AppColors.surfaceLightCard,
    onSecondaryContainer: AppColors.textPrimaryLight,
    surface: AppColors.surfaceLight,
    onSurface: AppColors.textPrimaryLight,
    surfaceContainerHighest: AppColors.surfaceLightElevated,
    error: AppColors.error,
    onError: Colors.white,
  ),

  scaffoldBackgroundColor: AppColors.surfaceLight,

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    titleTextStyle: TextStyle(
      fontFamily: 'SF Pro Display',
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.textPrimaryLight,
    ),
    iconTheme: IconThemeData(color: AppColors.textPrimaryLight),
  ),

  // ✅ FIXED
  cardTheme: CardThemeData(
    color: AppColors.surfaceLightCard,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    margin: EdgeInsets.zero,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: AppTypography.labelLarge,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.surfaceLightCard,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  ),

  textTheme: _buildTextTheme(isDark: false),
);


}

static TextTheme _buildTextTheme({required bool isDark}) {
final Color primaryColor =
isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;

final Color secondaryColor =
    isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

return TextTheme(
  displayLarge: AppTypography.displayLarge.copyWith(color: primaryColor),
  bodyMedium: AppTypography.bodyMedium.copyWith(color: secondaryColor),
  labelLarge: AppTypography.labelLarge.copyWith(color: primaryColor),
);

}
}
