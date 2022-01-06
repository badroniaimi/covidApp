class MyFXFunctions {
  ///This will return if the value of the [timeOne] is after the value of [timeTo]
  static bool compair2DateTimeAsTheMonthAndTheYearAndTheDay(
      DateTime timeOne, DateTime timeTo) {
    bool R = false;
    if (timeOne.year >= timeTo.year) if (timeOne.month >=
        timeTo.month) if (timeOne.day >= timeTo.day) R = true;

    return R;
  }

  static String? validateMobile(String value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }
}
