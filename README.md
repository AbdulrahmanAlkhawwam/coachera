# coachera

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Core 

lib/
└── core/
    ├── error/
    │   ├── exceptions.dart
    │   └── failures.dart
    ├── usecases/
    │   └── usecase.dart
    ├── utils/
    │   ├── input_converter.dart
    │   └── date_formatter.dart
    ├── network/
    │   ├── network_info.dart
    │   └── connectivity_service.dart
    ├── constants/
    │   ├── strings.dart
    │   └── app_constants.dart
    └── theme/
        └── app_theme.dart



lib/
└── theme/
├── app_theme.dart             # الملف المركزي لدمج كل شيء (Light + Dark ThemeData)
├── light_theme.dart           # يحتوي ThemeData للثيم الفاتح
├── dark_theme.dart            # يحتوي ThemeData للثيم الداكن
├── color_schemes.dart         # يحتوي ColorScheme light & dark
├── app_colors.dart            # ألوان مخصصة إضافية
├── app_text_styles.dart       # TextStyle مخصصة
├── app_typography.dart        # يحتوي TextTheme light & dark
└── app_spacing.dart           # كل المسافات (padding, margin)