<img src="https://raw.githubusercontent.com/fluffycatware/coolcats_crypto/master/assets/project-banner.jpg" data-canonical-src="https://raw.githubusercontent.com/fluffycatware/coolcats_crypto/master/assets/project-banner.jpg" align="center"/>

<div align = "center">
    <h1>CoolCats <em>Crypto Viewer</em></h1>
    <p>Because good app needs cats to make it great!</p>
    <a href="https://www.dartlang.org/" target="_blank"><img src="https://img.shields.io/badge/Dart-2.0.0-ff69b4.svg?longCache=true&style=for-the-badge" alt="Dart"></a>
    <a href="https://flutter.io/" target="_blank"><img src="https://img.shields.io/badge/Flutter-SDK-3BB9FF.svg?longCache=true&style=for-the-badge" alt="Flutter"></a>
</div>

A CryptoCurrency value tracker application written in Dart for Flutter

## Building

You can follow these instructions to build the coolcats app
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

The `flutter run --release` command both builds and installs the coolcats app.

If you are debugging the application on a simulator, run the following to launch the iOS simulator

```bash
open -a Simulator
```

Then run the following to debug with live reloading

```bash
flutter run --debug
```

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
