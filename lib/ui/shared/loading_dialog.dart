import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key, this.message = 'Please wait'})
      : super(key: key);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ColoredBox(
        color: Colors.white,
        child: SizedBox(
          height: 100.0,
          width: 100.0,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 32.0,
                      width: 32.0,
                      child: CircularProgressIndicator()),
                  SizedBox(width: 32.0),
                  Text(
                    message,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
