enum PaymentTypeEnum {
  byMonth('اشتراك شهري'),
  byClass('بالحصة');

  final String description;

  const PaymentTypeEnum(this.description);

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
