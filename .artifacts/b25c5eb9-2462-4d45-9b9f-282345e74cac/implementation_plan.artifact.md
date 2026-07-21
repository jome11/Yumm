# Fix RenderFlex Overflow in Login Screen

The goal is to resolve the `RenderFlex overflow` error occurring in the `LoginScreen` on the "Remember me" / "Forgot Password" row. This typically happens on narrow screens where the combined width of the checkbox, labels, and button exceeds the available horizontal space.

## Proposed Changes

### [MODIFY] [login_screen.dart](file:///C:/Users/PAVILION/Desktop/yumm/lib/views/login_screen.dart)
- Replace the `Row` containing the "Remember me" and "Forgot Password" widgets with a `Wrap` widget or use `Flexible` to allow the elements to adapt to smaller screen widths.
- Specifically, wrapping the "Remember me" group in a `Flexible` and ensuring the outer `Row` can handle its children's constraints will prevent the overflow.

#### Change details:
- Use `MainAxisAlignment.spaceBetween` in the outer `Row` only if there's enough space.
- Alternatively, use `Wrap` with `alignment: WrapAlignment.spaceBetween` and `crossAxisAlignment: WrapCrossAlignment.center`.

## Verification Plan

### Manual Verification
- Run the app on a narrow screen device or emulator (e.g., sw320dp).
- Verify that the "Remember me" checkbox and "Forgot Password" button are displayed correctly without any overflow errors.
- Ensure that if the screen is too narrow, the elements either scale down or stack gracefully.
