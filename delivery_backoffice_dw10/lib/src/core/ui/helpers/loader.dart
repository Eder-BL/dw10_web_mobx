import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

mixin Loader<T extends StatefulWidget> on State<T> {
  var _isOpen = false;

  bool get isOpen => _isOpen;

  void showLoader() {
    if (!_isOpen) {
      _isOpen = true;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Center(
          child: LoadingAnimationWidget.threeArchedCircle(
            color: Colors.white,
            size: 60,
          ),
        ),
      );
    }
  }

  void hideLoader() {
    if (_isOpen) {
      _isOpen = false;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  void dispose() {
    hideLoader();
    super.dispose();
  }
}
