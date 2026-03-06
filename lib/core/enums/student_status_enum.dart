enum StudentStatus {
  active,
  inactive,
  stopped;

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
