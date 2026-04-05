enum DivisionEnum {
  all('الكل'),
  Division('الشعبة'),
  literarySection(' ادبي'),
  scientificMathematicsSection(' علمي رياضة'),
  scientificBiologySection(' علمي علوم'),
  scientificSection(' علمي'),
  alAzharSection(' أزهر');

  final String description;

  const DivisionEnum(this.description);

  static DivisionEnum getDivisionFromString(String divisionString) {
    DivisionEnum? edu;
    for (var item in DivisionEnum.values) {
      if (item.name == divisionString) {
        edu = item;
      }
    }
    if (edu == null) {
      throw Exception(
        'failed to get Division from this $divisionString string',
      );
    }
    return edu;
  }
}
