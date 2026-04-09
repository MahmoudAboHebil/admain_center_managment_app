enum Language {
  ar("Arabic"),
  en("English");

  final String description;
  const Language(this.description);

  static Language? stringToLanguage(String? languageString) {
    if (languageString == null) {
      return null;
    }
    try {
      return Language.values.firstWhere((lan) => (lan.name == languageString));
    } catch (e) {
      return null;
    }
  }
}
