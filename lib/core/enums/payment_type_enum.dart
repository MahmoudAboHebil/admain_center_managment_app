enum PaymentTypeEnum {
  byMonth('اشتراك شهري', "Monthly Subscription"),
  byClass('بالحصة', "Per Class");

  final String arabic;
  final String english;

  const PaymentTypeEnum(this.arabic, this.english);

  static PaymentTypeEnum getPaymentFromString(String paymentType) {
    PaymentTypeEnum? edu;
    for (var item in PaymentTypeEnum.values) {
      if (item.name == paymentType) {
        edu = item;
      }
    }
    if (edu == null) {
      throw Exception(
        'failed to get Payment Type  from this $paymentType string',
      );
    }
    return edu;
  }
}
