import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/our_localizations.dart';
import 'package:learn_flutter_theme/our_options.dart';
import 'package:learn_flutter_theme/size.dart';
import 'package:learn_flutter_theme/themes/our_theme_data.dart';

import 'our_home_page.dart';

void main() {
  runApp(const OurApp());
}

class OurApp extends StatelessWidget {
  const OurApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ModelBinding(
      initialModel: OurOptions(
        themeMode: ThemeMode.system,
        textScaleFactor: systemTextScaleFactorOption,
        // locale: Locale('fa'),
        // locale: null,
        platform: defaultTargetPlatform,
      ),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: OurOptions.of(context)!.themeMode,
            theme: OurThemeData.lightThemeData(context)
                .copyWith(platform: OurOptions.of(context)!.platform),
            darkTheme: OurThemeData.darkThemeData(context)
                .copyWith(platform: OurOptions.of(context)!.platform),
            localizationsDelegates: OurLocalizations.localizationsDelegates,
            supportedLocales: OurLocalizations.supportedLocales,
            locale: OurOptions.of(context)!.locale,
            localeResolutionCallback: (locale, supportedLocales) {
              deviceLocale = locale;
              return locale;
            },
            home: const OurHomePage(),
          );
        },
      ),
    );
  }
}
