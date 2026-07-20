# Implementation Plan - Update App Icons

This plan describes how to replace the current app icons with the new gold-edged logo across all supported platforms (Android, iOS, macOS, Windows, and Web).

## User Review Required

> [!IMPORTANT]
> This action will overwrite existing app icon files in the project. Please ensure you have a backup if needed, although these can be reverted via Git.

## Proposed Changes

We will copy the regenerated icon files from `C:/Users/PAVILION/Downloads/new-app-icons/` to their respective platform-specific locations in the project.

### Android
Replace `ic_launcher.png` in all mipmap density folders.
- **Source**: `android/mipmap-*/ic_launcher.png`
- **Destination**: `android/app/src/main/res/mipmap-*/ic_launcher.png`

### iOS
Replace all icon sizes in the AppIcon set.
- **Source**: `ios/*.png`
- **Destination**: `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

### macOS
Replace all icon sizes in the AppIcon set.
- **Source**: `macos/*.png`
- **Destination**: `macos/Runner/Assets.xcassets/AppIcon.appiconset/`

### Windows
Replace the application icon file.
- **Source**: `windows/app_icon.ico`
- **Destination**: `windows/runner/resources/app_icon.ico`

### Web
Replace the favicon and touch icons.
- **Source**: `web/favicon.png` -> **Destination**: `web/favicon.png`
- **Source**: `web/Icon-*.png` -> **Destination**: `web/icons/`

## Verification Plan

### Manual Verification
1.  **Check File Existence**: Verify that the files have been successfully copied to the destination paths.
2.  **Visual Inspection**: Open a few of the destination files in the IDE to confirm they are the new gold-edged logo.
3.  **Build**: Recommend the user to perform a full stop-and-restart (or `flutter build`) to see the changes on their device/emulator.
    - *Note*: On Android, a full uninstall/reinstall may be required to clear the OS icon cache.
