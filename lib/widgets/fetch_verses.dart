import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

// Real, well-known verse counts per chapter (sum = 700)
const Map<int, int> chapterVerseCounts = {
  1: 47,
  2: 72,
  3: 43,
  4: 42,
  5: 29,
  6: 47,
  7: 30,
  8: 28,
  9: 34,
  10: 42,
  11: 55,
  12: 20,
  13: 35,
  14: 27,
  15: 20,
  16: 24,
  17: 28,
  18: 78,
};

Future<void> main() async {
  final outputDir = Directory('assets/verses');
  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }

  for (final chapter in chapterVerseCounts.keys) {
    final verseCount = chapterVerseCounts[chapter]!;
    final List<Map<String, dynamic>> chapterVerses = [];

    stdout.writeln('Fetching Chapter $chapter ($verseCount verses)...');

    for (int verse = 1; verse <= verseCount; verse++) {
      final url = Uri.parse('https://vedicscriptures.github.io/slok/$chapter/$verse');

      try {
        final response = await http.get(url);

        if (response.statusCode == 200) {
          final Map<String, dynamic> data = jsonDecode(response.body);

          final sanskrit = (data['slok'] ?? '').toString().trim();
          final transliteration = (data['transliteration'] ?? '').toString().trim();

          // English translation — Swami Sivananda commentary block
          final siva = data['siva'] as Map<String, dynamic>?;
          final translation = (siva?['et'] ?? 'Translation not available for this verse.')
              .toString()
              .trim();

          // Optional Hindi meaning — Swami Tejomayananda commentary block
          final tej = data['tej'] as Map<String, dynamic>?;
          final meaning = (tej?['ht'] as String?)?.trim();

          chapterVerses.add({
            'verseNumber': verse,
            'sanskrit': sanskrit,
            'transliteration': transliteration,
            'translation': translation,
            if (meaning != null && meaning.isNotEmpty) 'meaning': meaning,
          });

          stdout.writeln('  ✓ $chapter.$verse');
        } else {
          stdout.writeln('  ✗ $chapter.$verse failed — HTTP ${response.statusCode}');
        }
      } catch (e) {
        stdout.writeln('  ✗ $chapter.$verse error — $e');
      }

      // Be polite to the free API
      await Future.delayed(const Duration(milliseconds: 300));
    }

    final outFile = File('assets/verses/$chapter.json');
    const encoder = JsonEncoder.withIndent('  ');
    outFile.writeAsStringSync(encoder.convert(chapterVerses));
    stdout.writeln('Saved assets/verses/$chapter.json (${chapterVerses.length} verses)\n');
  }

  stdout.writeln('Done! All chapters saved to assets/verses/');
}