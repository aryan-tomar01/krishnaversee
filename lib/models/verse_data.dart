class VerseData {
  final int verseNumber;
  final String sanskrit;
  final String transliteration;
  final String translation;
  final String? meaning;

  const VerseData({
    required this.verseNumber,
    required this.sanskrit,
    required this.transliteration,
    required this.translation,
    this.meaning,
  });

  factory VerseData.fromJson(Map<String, dynamic> json) {
    return VerseData(
      verseNumber: json['verseNumber'] as int,
      sanskrit: json['sanskrit'] as String,
      transliteration: json['transliteration'] as String? ?? '',
      translation: json['translation'] as String,
      meaning: json['meaning'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'verseNumber': verseNumber,
    'sanskrit': sanskrit,
    'transliteration': transliteration,
    'translation': translation,
    if (meaning != null) 'meaning': meaning,
  };
}