enum EducationSystem {
  General,
  Azhar,
  International;

  static EducationSystem getEducationSystemFromString(String educationSystem) {
    EducationSystem? edu;
    for (var item in EducationSystem.values) {
      if (item.name == educationSystem) {
        edu = item;
      }
    }
    if (edu == null) {
      throw Exception(
        'failed to get Education System from this $educationSystem string',
      );
    }
    return edu;
  }
}
