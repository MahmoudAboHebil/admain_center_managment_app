enum StudentStatus {
  active('نشط', "Active"),
  inactive('غير نشط', "Inactive"),
  latePayment('متأخر في الدفع', "Late Payment");

  final String arabic;
  final String english;

  const StudentStatus(this.arabic, this.english);

  static StudentStatus getStudentStatusEnumFromString(
    String studentStatusString,
  ) {
    StudentStatus? studentStatus;
    for (var item in StudentStatus.values) {
      if (item.name == studentStatusString) {
        studentStatus = item;
      }
    }
    if (studentStatus == null) {
      throw Exception(
        'failed to get Student Status Enum from this $studentStatusString string',
      );
    }
    return studentStatus;
  }
}
