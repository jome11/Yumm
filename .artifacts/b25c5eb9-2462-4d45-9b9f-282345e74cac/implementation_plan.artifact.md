# Add Honeycomb-Textured Cards

The goal is to replace the current `GlassCard` (frosted glass) hero panels with a new `HexPatternCard` that features a solid background and a subtle honeycomb texture watermark, as seen in the app's reference screenshots.

## Proposed Changes

### New Widget

#### [NEW] [hex_pattern_card.dart](file:///C:/Users/PAVILION/Desktop/yumm/lib/views/widgets/hex_pattern_card.dart)
- Create a new file `lib/views/widgets/hex_pattern_card.dart` and paste the content from `C:/Users/PAVILION/Documents/hex/hex-card-files/hex_pattern_card.dart`.
- This widget uses a `CustomPaint` to draw the honeycomb pattern and a `ShaderMask` to fade it out.

### Apply to Hero Cards

#### [MODIFY] [overview_screen.dart](file:///C:/Users/PAVILION/Desktop/yumm/lib/views/overview_screen.dart)
- Replace the `GlassCard` used for the **Season Yield** card with `HexPatternCard`.
- Keep the `borderRadius` at `22` and `padding` at `20`.

#### [MODIFY] [analytics_screen.dart](file:///C:/Users/PAVILION/Desktop/yumm/lib/views/analytics_screen.dart)
- Replace the `GlassCard` used for the **Total Yield** hero card with `HexPatternCard`.
- Keep the `borderRadius` at `20` and `padding` at `20`.

### UI Components to Maintain

As per the instructions, we will **NOT** modify:
- Small stat boxes (Hives / Temp / Alerts).
- Status-colored rows or cards (Fleet Status, Hive Detail status cards).
- Insights cards (which have meaningful background colors).
- Settings tiles (which remain glass-style or standard).

## Verification Plan

### Manual Verification
- **Overview Screen**: Verify that the "Season Yield" card now has a subtle honeycomb pattern in the top-left corner that fades out.
- **Analytics Screen**: Verify that the "Total Yield" card also features the honeycomb texture.
- **Theming**: Check both Light and Dark themes. The pattern lines should adjust their color to remain subtle and integrated with the theme.
- **Consistency**: Ensure other UI elements (like the glass-style settings tiles) are not affected.
