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

## APK
For the APK of the project:

- [Click here](https://drive.google.com/file/d/1sU1iwHhynzPEl5iHbpvoBZ9E4BDuqsB8/view?usp=sharing)

## iOS
For the IPA of the project:

- [Click here](https://drive.google.com/file/d/1wcgO10zmjQIgot1N3FMw16k4VS_a9MYh/view?usp=sharing)

## Build for iOS and Android
For the Builds of the project:

- [Click here](https://drive.google.com/drive/folders/14Meq2zz4liAeEy-elm2_1T0UKOfQ6n-y?usp=sharing)


## Note
Please note that API key expires after a maximum of 10000 quotas daily

## Screenshot

![Simulator Screen Shot - iPhone SE (3rd generation) - 2022-10-05 at 10 23 03](https://user-images.githubusercontent.com/54381642/194028235-dd762cad-789e-4276-86e7-08046ee9d3e0.png)

![Simulator Screen Shot - iPhone SE (3rd generation) - 2022-10-05 at 10 23 09](https://user-images.githubusercontent.com/54381642/194028391-668bed2a-e0d9-45cf-99b3-ec000b28c220.png)

![Simulator Screen Shot - iPhone SE (3rd generation) - 2022-10-05 at 10 23 24](https://user-images.githubusercontent.com/54381642/194028553-f60d2ddd-b6dd-4630-9651-48693d71e2cb.png)

![Simulator Screen Shot - iPhone SE (3rd generation) - 2022-10-05 at 10 23 27](https://user-images.githubusercontent.com/54381642/194028570-19c26bd1-549b-462f-9019-70b73f8c2f9b.png)

![Simulator Screen Shot - iPhone SE (3rd generation) - 2022-10-05 at 10 23 55](https://user-images.githubusercontent.com/54381642/194028809-79d582c3-0b70-4707-aea0-a63da914ef18.png)

![Simulator Screen Shot - iPhone SE (3rd generation) - 2022-10-05 at 10 23 14](https://user-images.githubusercontent.com/54381642/194029124-88688e89-e38e-4d45-95f5-fed751ffcde8.png)

![Simulator Screen Shot - iPhone SE (3rd generation) - 2022-10-05 at 10 24 07](https://user-images.githubusercontent.com/54381642/194029334-f21eee29-66e4-43c1-b32a-ada65afaaa09.png)

![Simulator Screen Shot - iPhone SE (3rd generation) - 2022-10-05 at 10 25 07](https://user-images.githubusercontent.com/54381642/194029538-2564fccc-4620-458c-b07c-83e40f1a5b07.png)

![Simulator Screen Shot - iPhone SE (3rd generation) - 2022-10-05 at 10 24 53](https://user-images.githubusercontent.com/54381642/194029606-89d987f7-f106-47c9-b718-909c0f4ab750.png)

![Simulator Screen Shot - iPhone SE (3rd generation) - 2022-10-05 at 10 35 31](https://user-images.githubusercontent.com/54381642/194029943-4743b8e7-c3c8-4cc1-a129-72e3cbc0c856.png)

![Simulator Screen Shot - iPhone SE (3rd generation) - 2022-10-05 at 10 35 57](https://user-images.githubusercontent.com/54381642/194029988-3ae40283-811f-499d-8351-385fd343984c.png)
