import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

final class Messages {
  static void showError(String message, BuildContext context) {
    showTopSnackBar(Overlay.of(context), CustomSnackBar.error(message: message));
  }

  static void showInfo(String message, BuildContext context) {
    showTopSnackBar(Overlay.of(context), CustomSnackBar.info(message: message));
  }

  static void showSuccess(String message, BuildContext context) {
    showTopSnackBar(Overlay.of(context), CustomSnackBar.success(message: message));
  }
}

mixin MessageStateMixin {
  final _errorMessage = ValueNotifier<String?>(null);
  String? get errorMessage => _errorMessage.value;

  final _infoMessage = ValueNotifier<String?>(null);
  String? get infoMessage => _infoMessage.value;

  final _successMessage = ValueNotifier<String?>(null);
  String? get successMessage => _successMessage.value;

  void clearError() => _errorMessage.value = null;
  void clearInfo() => _infoMessage.value = null;
  void clearSuccess() => _successMessage.value = null;

  void showError(String message) {
    clearError();
    _errorMessage.value = message;
  }

  void showInfo(String message) {
    _infoMessage.value = message;
  }

  void showSuccess(String message) {
    _successMessage.value = message;
  }
}
mixin MessageViewMixin<T extends StatefulWidget> on State<T> {
  void messageListener(MessageStateMixin state) {
    state._errorMessage.addListener(() {
      if (state.errorMessage != null) Messages.showError(state.errorMessage!, context);
    });
    state._infoMessage.addListener(() {
      if (state.infoMessage != null) Messages.showError(state.infoMessage!, context);
    });
    state._successMessage.addListener(() {
      if (state.successMessage != null) Messages.showError(state.successMessage!, context);
    });
  }

  void onErrorMessageChanged(String? message) {
    // Implement your logic here
    print('Error message: $message');
  }

  void onInfoMessageChanged(String? message) {
    // Implement your logic here
    print('Info message: $message');
  }

  void onSuccessMessageChanged(String? message) {
    // Implement your logic here
    print('Success message: $message');
  }
}
