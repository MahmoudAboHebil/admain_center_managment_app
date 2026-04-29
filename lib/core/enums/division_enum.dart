enum DivisionEnum {
  all('الكل', 'All'),
  Division('الشعبة', 'Division'),
  generalDivision('عام', 'General'),
  literarySection(' ادبي', "Literary"),
  scientificMathematicsSection(' علمي رياضة', "Scientific Mathematics"),
  scientificBiologySection(' علمي علوم', "Scientific Biology"),
  scientificSection(' علمي', "Scientific"),
  alAzharSection(' أزهر', "AlAzhar");

  final String arabic;
  final String english;

  const DivisionEnum(this.arabic, this.english);

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
