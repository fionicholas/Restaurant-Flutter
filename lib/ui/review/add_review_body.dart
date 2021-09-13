import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restaurant_app/bloc/restaurant/restaurant.dart';
import 'package:restaurant_app/data/model/request/customer_review_request.dart';
import 'package:restaurant_app/ui/shared/custom_button.dart';
import 'package:restaurant_app/utils/colors.dart';
import 'package:restaurant_app/utils/dialog_utils.dart';
import 'package:restaurant_app/utils/validation_helper.dart';

class AddReviewBody extends StatefulWidget {
  final String id;

  const AddReviewBody({Key? key, required this.id}) : super(key: key);

  @override
  _AddReviewBodyState createState() => _AddReviewBodyState();
}

class _AddReviewBodyState extends State<AddReviewBody> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _reviewController = TextEditingController();
  final _addReviewKey = new GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _reviewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RestaurantBloc, RestaurantState>(
      listener: (context, state) {
        if (state is AddCustomerReviewLoadingState) {
          showLoading(context);
        } else if (state is AddCustomerReviewSuccessState) {
          _doubleBackPressed();
          Fluttertoast.showToast(msg: 'Reviews successfully added');
        } else if (state is AddCustomerReviewErrorState) {
          hideLoading(context);
          Fluttertoast.showToast(msg: 'something wrong');
        }
      },
      child: _buildForm(),
    );
  }

  _buildForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _addReviewKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              Text(
                'Name',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                style: Theme.of(context).textTheme.caption,
                controller: _nameController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  return validationFieldMinMaxRequired(
                      value: value!, fieldName: "Name", maxValue: 265);
                },
                decoration: InputDecoration(hintText: "Name"),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Review',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                style: Theme.of(context).textTheme.caption,
                controller: _reviewController,
                keyboardType: TextInputType.multiline,
                minLines: 4,
                maxLines: 100,
                validator: (value) {
                  return validationFieldMinMaxRequired(
                      value: value!, fieldName: "Review", maxValue: 265);
                },
                decoration: InputDecoration(hintText: "Review"),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: CustomButton(
                  btnColor: primaryColor,
                  textColor: Colors.white,
                  textButton: 'Add Review',
                  onPressed: () {
                    if (_addReviewKey.currentState!.validate()) {
                      _addReviewKey.currentState!.save();
                      var _request = CustomerReviewRequest(
                          id: widget.id,
                          review: _reviewController.text,
                          name: _nameController.text);

                      context.read<RestaurantBloc>().add(
                          AddedCustomerReviewsEvent(
                              customerReviewRequest: _request));
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _doubleBackPressed() {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
}
