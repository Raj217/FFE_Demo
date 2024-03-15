import 'package:flutter/cupertino.dart';

class UIUtils {
  const UIUtils._();

  static Size getTextSize({
    required String text,
    required TextStyle style,
  }) {
    TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(
        minWidth: 0,
        maxWidth: double.infinity,
      );
    return Size(textPainter.width, textPainter.height);
  }

  /// Returns the size of the widget only if it is painted on the screen.
  static Size? getWidgetSize(GlobalKey key) {
    final keyContext = key.currentContext;
    if (keyContext != null) {
      // widget is visible
      final box = keyContext.findRenderObject() as RenderBox;
      return box.size;
    }
    return null;
  }
}
