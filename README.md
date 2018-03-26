# coolcats_crypto Crypto Viewer

Demo app for the material design widgets and other features provided by Flutter.

## Building

You can follow these instructions to build the stocks app
and install it onto your device.

### Prerequisites

If you are new to Flutter, please first follow
the [Flutter Setup](https://flutter.io/setup/) guide.

### Building and installing the stocks demo app

```bash
cd coolcats_crypto
flutter upgrade
flutter run --release
```

The `flutter run --release` command both builds and installs the Flutter app.

## Interationalization

This app has been internationalized (just enough to show how it's
done). It's an example of how one can do so with the
[Dart intl package](https://pub.dartlang.org/packages/intl).

The [Flutter Internationalization Tutorial](https://flutter.io/tutorials/internationalization/)
covers Flutter app internationalization in general.

See [regenerate.md](lib/i18n/regenerate.md) for an explanation
of how the Dart interationalization tools, like
`intl_translation:generate_from_arb`, were used to generate
localizations for this app.

## Icon

Icon was created using: https://pub.dartlang.org/packages/flutter_launcher_icons

```bash
flutter pub get
flutter pub pub run flutter_launcher_icons:main
```
