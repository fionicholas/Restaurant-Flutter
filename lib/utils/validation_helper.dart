String? validationFieldMinMaxRequired(
    {required String value,
      String? fieldName,
      int minValue = 1,
      required int maxValue}) {
  if (value.length == 0) {
    return "$fieldName is required";
  } else if (value.length < minValue) {
    return 'Minimum $minValue character';
  } else if (value.length > maxValue) {
    return 'Maximum $maxValue character';
  } else {
    return null;
  }
}