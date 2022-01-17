![Preview](./preview.gif)

# learn_flutter_theme

Learn flutter theme in this project. This project has a web app:
https://app.yazdi.dev/learn_flutter_theme/

### What is this project

This project contains dark and light themes, plus English and Persian localizations.

### How we can change the app based on the selected theme?
You can change the current state of localization or theme by wrapping `MaterialApp` with `InheritedWidget` or anything else like `provider` or even `setState` the `MaterialApp` widget. Here we used an inherited widget:
```dart
class _ModelBindingScope extends InheritedWidget {
  const _ModelBindingScope({
    Key? key,
    required this.modelBindingState,
    required Widget child,
  }) : super(key: key, child: child);

  final _ModelBindingState modelBindingState;

  @override
  bool updateShouldNotify(_ModelBindingScope oldWidget) => true;
}
```

and made it as a MaterialApp parent
```dart
ModelBinding(
  initialModel: OurOptions(
    themeMode: ThemeMode.system,
    textScaleFactor: systemTextScaleFactorOption,
    platform: defaultTargetPlatform,
  ),
  child: Builder(
    builder: (context) {
      return MaterialApp(
        home: const OurHomePage(),
      );
    },
  ),
);
```

### How to create the dark and light theme?
It's so simple, just create a class and define your theme's properties based on your design for example like this in Figma:
![Figma](./figma.png)

We have two options here:
Create the whole `MaterialTheme` with all properties or just change what you need by `copyWith` the `MaterialTheme`, here we used the second option by overriding what we need:
```dart
static const _lightFillColor = Colors.black;
static const _darkFillColor = Colors.white;

static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

static final ThemeData _lightThemeData = ThemeData.light();
static final ThemeData _darkThemeData = ThemeData.dark();

static ThemeData lightThemeData(BuildContext context) =>
  themeData(_lightThemeData, context, lightColorScheme, _lightFocusColor);

static ThemeData darkThemeData(BuildContext context) =>
  themeData(_darkThemeData, context, darkColorScheme, _darkFocusColor);

static ThemeData themeData(ThemeData themeData, BuildContext context,
  ColorScheme colorScheme, Color focusColor) {
    return themeData.copyWith(
      colorScheme: colorScheme,
      textTheme: isFarsiLocale(context)
          ? _faTextTheme(themeData.textTheme, colorScheme.onPrimary)
          : _textTheme(themeData.textTheme, colorScheme.onPrimary),
    );
}
```
As you can see we passed flutter`ThemeData.light()` and `ThemeData.dark()` with our `colorScheme` and `_faTextTheme` and `_textTheme` based on the localization, and finally used `themeData.copyWith` to change what we need. 

We have two main properties that we have to customize, otherwise our theme is nothing but a MaterialTheme:
- `ColorSchema`'s:
```dart
static ColorScheme lightColorScheme = const ColorScheme.dark().copyWith(
    primary: const Color(0xFFB93C5D),
    primaryVariant: const Color(0xFF117378),
    secondary: const Color(0xFFEFF3F3),
    secondaryVariant: const Color(0xFFFAFBFB),
    background: const Color(0xFFE6EBEB),
    onSurface: const Color(0xFF241E30),
    brightness: Brightness.light,
);

static ColorScheme darkColorScheme = const ColorScheme.light().copyWith(
    primary: const Color(0xFFFF8383),
    primaryVariant: const Color(0xFF1CDEC9),
    secondary: const Color(0xFF4D1F7C),
    secondaryVariant: const Color(0xFF451B6F),
    background: const Color(0xFF241E30),
    surface: const Color(0xFF1F1929),
    onBackground: Colors.white.withOpacity(0.05),
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
);
```
As you can see there are multiple colors that each one of them used for multiple purposes for flutter widgets and again we override what we need to change of flutter's light and dark `colorScheme`.

- `TextTheme` that we separated based on localization since we wanted to use a Persian font:
```dart
static const _regular = FontWeight.w400;
static const _medium = FontWeight.w500;
static const _semiBold = FontWeight.w600;
static const _bold = FontWeight.w700;

static TextTheme _textTheme(TextTheme textTheme, Color color) {
  return textTheme
      .copyWith(
        bodyText1: GoogleFonts.montserrat(
          fontWeight: _regular,
          fontSize: 14.0,
          textStyle: textTheme.bodyText1,
        ),
        headline4: GoogleFonts.montserrat(
          fontWeight: _bold,
          fontSize: 20.0,
          textStyle: textTheme.headline4,
        ),
        subtitle1: GoogleFonts.montserrat(
          fontWeight: _medium,
          fontSize: 16.0,
          textStyle: textTheme.subtitle1,
        ),
        caption: GoogleFonts.oswald(
          fontWeight: _semiBold,
          fontSize: 16.0,
          textStyle: textTheme.caption,
        ),
        button: GoogleFonts.montserrat(
          fontWeight: _semiBold,
          fontSize: 14.0,
          textStyle: textTheme.button,
        ),
      )
      .apply(bodyColor: color);
}
static TextTheme _faTextTheme(TextTheme textTheme, Color color) {
  return textTheme
      .copyWith(
        bodyText1: textTheme.bodyText1!.copyWith(
          fontWeight: _regular,
          fontSize: 14.0,
          fontFamily: 'IRANSans-Regular',
        ),
        headline4: textTheme.headline4!.copyWith(
          fontWeight: _bold,
          fontSize: 20.0,
          fontFamily: 'IRANSans-Bold',
        ),
        subtitle1: textTheme.subtitle1!.copyWith(
          fontWeight: _medium,
          fontSize: 16.0,
          fontFamily: 'IRANSans-Medium',
        ),
        caption: textTheme.caption!.copyWith(
          fontWeight: _semiBold,
          fontSize: 16.0,
          fontFamily: 'IRANSans-SemiBold',
        ),
        button: textTheme.button!.copyWith(
          fontWeight: _semiBold,
          fontSize: 14.0,
          fontFamily: 'IRANSans-Medium',
        ),
      )
      .apply(bodyColor: color);
}
```
This is the place where we need to import our custom fonts. We used a `GoogleFont` package for our English text and a Persian font for our Persian text. Just don't remember to put your font in the `pubspec.yaml`:
```yaml
assets:
  - fonts/google_fonts/
fonts:
  - family: IRANSans-Medium
    fonts:
      - asset: fonts/IRANSans-Medium.ttf
  - family: IRANSans-Regular
    fonts:
      - asset: fonts/IRANSans-Regular.ttf
  - family: IRANSans-SemiBold
    fonts:
      - asset: fonts/IRANSans-SemiBold.ttf
  - family: IRANSans-Bold
    fonts:
      - asset: fonts/IRANSans-Bold.ttf
```
and don't remember if you have multiple `FontWeight`, you should also add the other big fonts like `IRANSans-SemiBold` and `IRANSans-Bold`

Everything else should be defined by your requirements in Figma like
```dart
themeData.copyWith(
  appBarTheme: AppBarTheme(
    textTheme: isFarsiLocale(context)
        ? _faTextTheme(themeData.textTheme, colorScheme.onPrimary)
        : _textTheme(themeData.textTheme, colorScheme.onPrimary),
    color: colorScheme.background,
    elevation: 0,
    iconTheme: IconThemeData(color: colorScheme.primary),
    brightness: colorScheme.brightness,
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    color: colorScheme.primary,
  ),
  buttonTheme: ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
    colorScheme: colorScheme,
  ),
  floatingActionButtonTheme: themeData.floatingActionButtonTheme
      .copyWith(foregroundColor: colorScheme.primary),
  iconTheme: IconThemeData(color: colorScheme.onPrimary),
  toggleableActiveColor: colorScheme.primary,
  indicatorColor: colorScheme.onPrimary,
  primaryColor: colorScheme.primary,
  scaffoldBackgroundColor: colorScheme.background,
  highlightColor: Colors.transparent,
  accentColor: colorScheme.primary,
  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Color.alphaBlend(
      _lightFillColor.withOpacity(0.80),
      _darkFillColor,
    ),
    contentTextStyle: isFarsiLocale(context)
        ? _faTextTheme(themeData.textTheme, colorScheme.onPrimary)
            .subtitle1!
            .apply(color: _darkFillColor)
        : _textTheme(themeData.textTheme, colorScheme.onPrimary)
            .subtitle1!
            .apply(color: _darkFillColor),
  ),
);
```

### How we can know about localization in our theme?
Here we have a helper method:
```dart
bool isFarsiLocale(BuildContext context) {
  return (OurOptions.of(context)!.locale?.languageCode ?? false) == 'fa';
}
```

If you pass a `context` to the theme, you can check localization based on an inherited widget that we created at the first step  It could be a `provider` or a `bloc` but you definitely need a `context` to access your selected localization (Or maybe you're using `getX` which I haven't tried :D).

Then all you have to do is a simple if else:
```dart
themeData.copyWith(
  colorScheme: colorScheme,
  textTheme: isFarsiLocale(context)
      ? _faTextTheme(themeData.textTheme, colorScheme.onPrimary)
      : _textTheme(themeData.textTheme, colorScheme.onPrimary),
);
```

### Is there any way to change the theme for a specific widget and its children

Yes, just wrap your widget by a `Theme` widget and you can define everything again:
```dart
Theme(
    data: ThemeData(backgroundColor: Colors.red),
    child: OurChild(),
),
```
You could also again use your previous `ThemeData` by using `Theme.of(context)` and change it what you need by using `Theme.of(context).copyWith()`. Flutter always looks for your closet `ThemeData` that's why it returned the one you define in you `MaterialApp` not the flutter's `ThemeData`.

You can always use style or theme properties like `ButtonTheme` widget and flutter apply them first, for example if we want to change one text's style:
```dart
Text(
  OurLocalizations.of(context)!.ourText,
  style: Theme.of(context).textTheme.headline1,
)
```

### Final Speech

In this project, I tried to explain theming as simply as I could. The flutter theme is simple as well as powerful. So clone this project and try to customize it with new ideas and don't forget the PRs are most welcomed.
By the way, it is so much better to read flutter documentation: [Use themes to share colors and font styles](https://docs.flutter.dev/cookbook/design/themes), [Theme class API](https://api.flutter.dev/flutter/material/Theme-class.html) and [ThemeData class API](https://api.flutter.dev/flutter/material/ThemeData-class.html)

Thanks for your support by starring this repository, sorry I made this explanation in English, believe me, I tried but it's way hard to say all this stuff in Persian, but who knows maybe a nice guy will make a PR containing a `README-fa.md`.
