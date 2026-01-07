import 'package:flutter/material.dart';

class AppPallete {
  // ===========================================================================
  // 1. THE CORE 4-COLOR PALETTE
  // ===========================================================================

  // The canvas/scaffold background
  static const Color _background = Color(0xFF232323);

  // The primary brand color (Buttons, Headers)
  static const Color _mainWidget = Color(0xFF896CFE);

  // The secondary/accent color (Borders, Secondary Text)
  static const Color _subWidget = Color(0xFFB3A0FF);

  // The highlight color (Active states, Success, Alerts)
  static const Color _selectedWidget = Color(0xFFE2F163);
  static const Color transparentColor = Colors.transparent;

  static const Color text_color_dark_background = Color(0xFFFFFFFF);
  static const Color text_color_light_background = Color(0xFF232323);



  // ===========================================================================
  // 2. MAPPING OLD NAMES TO THE NEW PALETTE
  // (This keeps your existing code working while enforcing the new look)
  // ===========================================================================

  // Backgrounds
  static const Color backgroundColor = _background;

  // Gradients (Flattened to your Main/Selected colors)
  static const Color gradient1 = _mainWidget;
  static const Color gradient2 = _mainWidget;
  static const Color gradient3 = _selectedWidget; // Used primarily for high contrast

  // Widgets & Borders
  static const Color widgetColor = _mainWidget;
  static const Color borderColor = _subWidget; // Borders use the lighter purple

  // Text Colors
  // "White" is replaced by SubWidget (Light Purple) for better contrast on dark backgrounds
  static const Color whiteColor = _subWidget;
  // "Dark Text" maps to the Background color (useful if text is inside a Lime button)
  static const Color textColor_dark = text_color_light_background;
  // "Light Text" (from your old code) mapped to background to stay consistent with dark theme logic
  static const Color textColor_light = text_color_dark_background;

  // States
  static const Color selectedColor = _selectedWidget;
  static const Color greyColor = _mainWidget; // Inactive items fade into the Main color
  static const Color errorColor = _selectedWidget; // Errors/Alerts use the Lime High-Contrast color

}