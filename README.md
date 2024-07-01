# Guternberg Book

Generate by Very Good CLI.

## Getting Started 🚀

first run pub get to generate build
```sh
$ flutter pub get
```
after that run build_runner to generate model in terminal
```sh
$ dart run build_runner build 
```

run unit test in terminal :
```sh
$ flutter test --coverage
```

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```
