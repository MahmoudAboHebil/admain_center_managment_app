enum Gender {
  male,
  female;

  static Gender getGenderEnumFromString(String genderString) {
    Gender? genderEnum;
    for (var item in Gender.values) {
      if (item.name == genderString) {
        genderEnum = item;
      }
    }
    if (genderEnum == null) {
      throw Exception(
        'failed to get Gender Enum from this $genderString string',
      );
    }
    return genderEnum;
  }
}
