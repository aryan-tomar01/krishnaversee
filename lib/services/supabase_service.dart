import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseClient client =
      Supabase.instance.client;

  static String getVerseAudioUrl({
    required int chapterNumber,
    required int verseNumber,
  }) {
    final verse =
    verseNumber.toString().padLeft(2, '0');

    final url = client.storage
        .from('gita-audio')
        .getPublicUrl(
      'chapter_${chapterNumber.toString().padLeft(2, '0')}/'
          'shlok$chapterNumber.$verse.mp3',
    );

    print("SUPABASE AUDIO URL: $url");

    return url;
  }
}