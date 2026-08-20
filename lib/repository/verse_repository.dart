import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/verse_data.dart';

class VerseRepository {
  static Future<List<VerseData>> loadChapterVerses(int chapterNumber) async {
    try {
      final raw = await rootBundle
          .loadString('assets/verses/$chapterNumber.json');
      final List<dynamic> decoded = jsonDecode(raw);
      return decoded
          .map((e) => VerseData.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // File not added yet for this chapter — return empty so the UI
      // can show a friendly "coming soon" state instead of crashing.
      print("VERSE LOAD ERROR for chapter $chapterNumber: $e");
      return [];
    }
  }
}