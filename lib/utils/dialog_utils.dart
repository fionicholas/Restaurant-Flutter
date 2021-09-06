import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/shared/loading_dialog.dart';

void showLoading(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => LoadingDialog(),
  );
}

void hideLoading(BuildContext context){
  Navigator.pop(context);
}