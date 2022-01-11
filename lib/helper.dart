import 'package:flutter/material.dart';
import 'package:learn_flutter_theme/our_options.dart';

bool isFarsiLocale(BuildContext context) {
  return (OurOptions.of(context)!.locale?.languageCode ?? false) == 'fa';
}

class Helper {
  static void onLocalChanged(BuildContext context) {
    final option = OurOptions.of(context)!;
    void enLanguage() =>
        OurOptions.update(context, option.copyWith(locale: const Locale('en')));
    void faLanguage() =>
        OurOptions.update(context, option.copyWith(locale: const Locale('fa')));

    option.locale!.languageCode == 'en' ? faLanguage() : enLanguage();
  }

  static void onThemeChanged(BuildContext context) {
    final option = OurOptions.of(context)!;

    option.themeMode == ThemeMode.system
        ? OurOptions.update(context,
            OurOptions.of(context)!.copyWith(themeMode: ThemeMode.dark))
        : option.themeMode == ThemeMode.dark
            ? OurOptions.update(context,
                OurOptions.of(context)!.copyWith(themeMode: ThemeMode.light))
            : OurOptions.update(context,
                OurOptions.of(context)!.copyWith(themeMode: ThemeMode.system));
  }
}
