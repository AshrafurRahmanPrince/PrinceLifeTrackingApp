# Assets Directory

This folder contains image and media assets for the Prince's Lifestyle Matrix app.

## Required Assets

### Profile Image
- **File**: `prince_profile.png`
- **Purpose**: User profile avatar displayed in the header
- **Specifications**:
  - Format: PNG (square, transparent background recommended)
  - Recommended Size: 256x256 pixels or higher
  - Quality: High resolution for crisp display
  - Size: < 500KB recommended

## Fallback Behavior

If `prince_profile.png` is missing or fails to load:
- A circular container with the initial "P" will be displayed
- Color: Bright Cyan (#00D4FF)
- This ensures the app works even without the asset

## Adding Your Profile Image

1. Prepare your profile image (PNG, JPG, or WebP)
2. Rename it to `prince_profile.png` (if using PNG)
3. Place it in this `assets/` folder
4. The app will automatically load it on next run
5. No code changes needed!

## Asset References in Code

The app references assets using:
```dart
Image.asset(
  'assets/prince_profile.png',
  width: 80,
  height: 80,
  fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) {
    // Falls back to "P" text if asset not found
  },
)
```

## Additional Assets (Future)

You can add more assets here for future features:
- Custom icons
- Background images
- Logo variations
- Habit-specific emoji or icons

Just add them to this folder and update `pubspec.yaml` accordingly.
