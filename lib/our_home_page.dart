import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/our_localizations.dart';
import 'package:learn_flutter_theme/helper.dart';

class OurHomePage extends StatefulWidget {
  const OurHomePage({Key? key}) : super(key: key);

  @override
  State<OurHomePage> createState() => _OurHomePageState();
}

class _OurHomePageState extends State<OurHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(OurLocalizations.of(context)!.ourTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              OurLocalizations.of(context)!.ourText,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () => Helper.onLocalChanged(context),
            tooltip: OurLocalizations.of(context)!.changeLocale,
            child: const Icon(Icons.edit),
          ),
          const SizedBox(height: 5.0),
          FloatingActionButton(
            onPressed: () => Helper.onThemeChanged(context),
            tooltip: OurLocalizations.of(context)!.changeTheme,
            child: const Icon(Icons.style),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
