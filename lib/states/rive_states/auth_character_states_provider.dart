import 'dart:math';
import 'package:ffe_demo_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class AuthCharacterStatesProvider extends ChangeNotifier {
  SMIBool? _isChecking;
  SMITrigger? _trigSuccess;
  SMITrigger? _trigFail;
  SMIBool? _isHandsUp;
  SMINumber? _numLook;

  void onInit(Artboard artboard) {
    final controller =
        StateMachineController.fromArtboard(artboard, 'Login Machine');
    artboard.addController(controller!);

    _isChecking = controller.findInput<bool>('isChecking') as SMIBool;
    _isHandsUp = controller.findInput<bool>('isHandsUp') as SMIBool;
    _trigSuccess = controller.findInput<bool>('trigSuccess') as SMITrigger;
    _trigFail = controller.findInput<bool>('trigFail') as SMITrigger;
    _numLook = controller.findInput<double>('numLook') as SMINumber;
  }

  set isChecking(bool val) {
    _isChecking?.value = val;
    notifyListeners();
  }

  set isHandsUp(bool val) {
    _isHandsUp?.value = val;
    notifyListeners();
  }

  Future<void> success() async {
    _trigSuccess?.fire();

    notifyListeners();
    // Approximate time the fire takes
    await Future.delayed(const Duration(milliseconds: 1300));
  }

  Future<void> fail() async {
    _trigFail?.fire();

    notifyListeners();
    // Approximate time the fire takes
    await Future.delayed(const Duration(milliseconds: 1300));
  }

  Future<void> _animateLookValue(double newValue) async {
    if (_numLook == null) {
      _numLook?.value = newValue;
    } else {
      double current = _numLook!.value + 1;
      bool lookLeft = current > newValue;

      while ((lookLeft && current > newValue) ||
          (!lookLeft && current < newValue)) {
        _numLook?.value = current;
        if (lookLeft) {
          current--;
        } else {
          current++;
        }
        await Future.delayed(const Duration(milliseconds: 20));
      }
    }
  }

  Future<void> look({
    required String text,
    required TextStyle style,
    required double maxFieldWidth,
  }) async {
    double width = UIUtils.getTextSize(text: text, style: style).width;
    width = min(width, maxFieldWidth);
    await _animateLookValue((width / maxFieldWidth) * 100);
    notifyListeners();
  }
}
