enum GuardianRelation {
  Father,
  Mother,
  Sister,
  Brother,
  Other;

  static GuardianRelation getGuardianRelationFromString(String relation) {
    GuardianRelation? guardianRelation;
    for (var item in GuardianRelation.values) {
      if (item.name == relation) {
        guardianRelation = item;
      }
    }
    if (guardianRelation == null) {
      throw Exception(
        'failed to get Guardian Relation from this $relation string',
      );
    }
    return guardianRelation;
  }
}
