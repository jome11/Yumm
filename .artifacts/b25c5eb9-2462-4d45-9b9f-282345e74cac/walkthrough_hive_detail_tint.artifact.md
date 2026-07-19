# Walkthrough: Tint Hive Detail Cards by Status

The Hive Detail screen now provides better visual context by tinting its glass cards according to the hive's current status (e.g., amber for Harvest Ready, red for Warning, teal for Optimal).

## Changes Made

### 1. Enhanced `GlassCard` Widget
Updated `lib/views/widgets/glass_card.dart` to support an optional `tintColor`. This allows individual cards to deviate from the standard white frosted look while maintaining the same blur and edge effects.

```dart
class GlassCard extends StatelessWidget {
  // ...
  final Color? tintColor; // New optional parameter

  @override
  Widget build(BuildContext context) {
    // ...
    final base = tintColor ?? Colors.white;
    final tint = isDark ? base.withOpacity(...) : base.withOpacity(...);
    // ...
  }
}
```

### 2. Status-Aware Hive Detail Screen
Updated `lib/views/hive_detail_screen.dart` to pass the hive's status accent color to all relevant cards:

- **Metric Info Boxes**: The Temp, Humidity, Activity, and Model boxes now use the status-based tint.
- **Productivity Analysis**: The chart container is now tinted.
- **Hive ID / QR Code**: The identifier card also adopts the status tint.

The `_InfoBox` helper widget was also updated to support this new parameter.

## Verification Results

### UI Consistency
- The tint is subtle and does not interfere with text readability.
- The effect correctly adapts to both Light and Dark modes, with adjusted opacities for each.
- Other screens using `GlassCard` (like Overview) remain unchanged with the default neutral white tint.

### Manual Verification Steps
1. Open a hive with a **Warning** status. Observe the reddish tint on all detail cards.
2. Open a hive with a **Harvest Ready** status. Observe the amber tint.
3. Open an **Optimal** hive. Observe the teal/greenish tint.
