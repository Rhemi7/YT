# youtube_data_api

[![Dart](https://github.com/Rhemi7/YT/actions/workflows/dart.yml/badge.svg)](https://github.com/Rhemi7/YT/actions/workflows/dart.yml)  [![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)


A new Flutter project that interacts with the Youtube Data API

## Getting Started

This project is a starting point for a Flutter application.


## Installing
To install this app

```
git clone https://github.com/Rhemi7/YT.git
```

And then in terminal install the required dependencies

```
flutter pub get
```
Run the app in the project's root folder of the terminal

```
flutter run 
```

## Running the tests
Open a test file and run test cases in terminal

```
flutter test --no-sound-null-safety
```

## App Development Info
Folder Structure

  - Core: This contains things that were reused throughout the project.
  - Feature: This is where every major feature in the project is located.
     - data: all calls made to the remote data/api are included here.
     - domain: represents bridge between the data layer and presentation layer, here all abstractions are made before being sent to the presentation layer
     - presentation: includes all classes and methods that make up the screens/pages of the app.
     
## Plugins
| Name | Description |
| --- | --- |
| Hooks Riverpod | Used for state management |
| Get it | Dependency Injection |
| Dartz | Functional programming in Dart |
| Mockito | Used for testing |
| Http | Used for making network requests|
| Equatable | used for showing equality between objects |
| Shared preferences | Used for local storage on device |
| Internet Connection Checker | Used for checking the connectivity of internet on the device |
| Youtube Player Flutter | Used to play youtube videos |
| Flags | Displays country flags according to ISO code |
