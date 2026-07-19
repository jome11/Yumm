# Fix Fleet Status Card Styling

The goal is to update the styling of Fleet Status cards in the Overview screen and the My Hives screen to be more theme-aware and visually subtle.

## User Review Required

> [!NOTE]
> The cards will transition from solid, bold background colors to a subtle tint with a colored dot indicator. This will significantly improve readability in light mode.

## Proposed Changes

### [MODIFY] [overview_screen.dart](file:///C:/Users/PAVILION/Desktop/yumm/lib/views/overview_screen.dart)
- Update `_fleetCard` widget:
    - Use `AppColors.statusAccent(label).withOpacity(0.12)` for background.
    - Use `AppColors.statusAccent(label).withOpacity(0.4)` for border.
    - Add a colored circle indicator before the hive name.
    - Replace hardcoded `Colors.white` with `AppColors.textPrimary(context)` and `AppColors.textSecondary(context)`.
    - Change right-side percentage from `humidityPercent` to `healthPercent`.
- Add a "Feed >" link next to the "Latest Alert" section title.

### [MODIFY] [hive_list_tile.dart](file:///C:/Users/PAVILION/Desktop/yumm/lib/views/widgets/hive_list_tile.dart)
- Update the card decoration:
    - Use `AppColors.statusAccent(label).withOpacity(0.12)` for background.
    - Use `AppColors.statusAccent(label).withOpacity(0.4)` for border.
- Add a colored circle indicator before the hive name.
- Replace hardcoded `Colors.white` with theme-aware text colors.
- Ensure the progress bar (`LinearProgressIndicator`) uses status accent colors.

## Verification Plan

### Manual Verification
- **Overview Screen**: Verify the 3-item fleet preview shows the new tinted cards with dot indicators and the "Feed >" link.
- **My Hives Screen**: Verify the full list of hives uses the updated `HiveListTile` styling.
- **Theming**: Toggle between Light and Dark modes to ensure text is legible and the tint looks good on both backgrounds.
