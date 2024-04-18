# tudotaichinh

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)


This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Config build apk
copy file `android\key.properties.example` to `android\key.properties`
then edit key.properties with correct info

# RUN app
run app with flavor: "flutter run --flavor staging/dev/prod"

# build app
build apk  with flavor: "flutter build apk --flavor dev"
build app bundle for release to store with flavor: "flutter build appbundle --flavor prod"

# if change model, need run again  JSON serilization
Run JSON serilization "flutter