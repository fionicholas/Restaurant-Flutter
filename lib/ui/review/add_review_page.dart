import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/review/add_review_body.dart';
import 'package:restaurant_app/utils/colors.dart';

class AddReviewPage extends StatelessWidget {
  static const String routeName = '/add_review';
  final String id;

  const AddReviewPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Add Review'),
      ),
      body: AddReviewBody(id: id),
    );
  }
}
