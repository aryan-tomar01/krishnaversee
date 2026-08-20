import 'dart:async';
import 'package:flutter/material.dart';
import 'package:krishnaversee/models/verse_data.dart';

import '../../models/chapter.dart';
import '../../repository/verse_repository.dart';
import '../../services/supabase_service.dart';
import '../../utils/app_colors.dart';
import 'package:audioplayers/audioplayers.dart';

class ChapterDetailScreen extends StatefulWidget {
  final Chapter chapter;

  const ChapterDetailScreen({
    super.key,
    required this.chapter,
  });

  @override
  State<ChapterDetailScreen> createState() => _ChapterDetailScreenState();
}

class _ChapterDetailScreenState extends State<ChapterDetailScreen> {


  late Future<List<VerseData>> _versesFuture;
  final AudioPlayer player = AudioPlayer();
  int? _playingVerseNo;
  bool _isPlaying = false;
  StreamSubscription? _playerCompleteSubscription;

  @override
  void initState() {
    super.initState();

    print("Chapter Opened: ${widget.chapter.number}");

    _versesFuture = VerseRepository.loadChapterVerses(widget.chapter.number);

    _versesFuture.then((value) {
      print("Total Verses: ${value.length}");
      if (value.isNotEmpty) {
        print(value.first.sanskrit);
      }
    }).catchError((e) {
      print("ERROR: $e");
    });

    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      if (mounted) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _playerCompleteSubscription?.cancel();
    player.dispose();
    super.dispose();
  }

  Future<void> _handlePlayPause(VerseData verse) async {
    final int verseNo = verse.verseNumber;

    try {
      if (_playingVerseNo == verseNo && _isPlaying) {
        await player.pause();

        if (mounted) {
          setState(() {
            _isPlaying = false;
          });
        }

        return;
      }

      await player.stop();

      final audioUrl = SupabaseService.getVerseAudioUrl(
        chapterNumber: widget.chapter.number,
        verseNumber: verseNo,
      );

      print("Playing audio: $audioUrl");

      await player.play(
        UrlSource(audioUrl),
      );

      if (mounted) {
        setState(() {
          _playingVerseNo = verseNo;
          _isPlaying = true;
        });
      }
    } catch (e) {
      print("Audio Error: $e");

      if (mounted) {
        setState(() {
          _isPlaying = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Audio play nahi ho paaya: $e',
            ),
          ),
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final chapter = widget.chapter;

    return Scaffold(
      backgroundColor: AppColors.bgBottom,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, chapter),
            Expanded(
              child: FutureBuilder<List<VerseData>>(
                future: _versesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColors.gold),
                    );
                  }

                  final verses = snapshot.data ?? [];

                  if (verses.isEmpty) {
                    return _buildComingSoon(chapter);
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: verses.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final verse = verses[index];
                      return _VerseCard(
                        verse: verse,
                        chapterNumber: chapter.number,
                        isPlaying: _playingVerseNo == verse.verseNumber && _isPlaying,
                        onPlayPause: () => _handlePlayPause(verse),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Chapter chapter) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 12),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.gold, size: 20),
          ),
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.gold, width: 1.2),
            ),
            child: Text(
              chapter.number.toString(),
              style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chapter.title,
                  style: const TextStyle(
                    color: AppColors.cyanAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${chapter.subtitle} • ${chapter.verseCount} Verses',
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComingSoon(Chapter chapter) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.auto_stories_outlined, color: AppColors.gold, size: 44),
            const SizedBox(height: 16),
            Text(
              'Verse content for "${chapter.title}" not loaded yet',
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textWhite, fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'Add assets/verses/${chapter.number}.json with this chapter\'s verses '
                  '(or connect it to your API) to display them here.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _VerseCard extends StatelessWidget {
  final VerseData verse;
  final int chapterNumber;
  final bool isPlaying;
  final VoidCallback onPlayPause;

  const _VerseCard({
    required this.verse,
    required this.chapterNumber,
    required this.isPlaying,
    required this.onPlayPause,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Verse ${verse.verseNumber}',
                  style: const TextStyle(
                    color: AppColors.gold,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              if (chapterNumber == 1 && verse.verseNumber <= 47)
                IconButton(
                  onPressed: onPlayPause,
                  icon: Icon(
                    isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_fill,
                    color: AppColors.gold,
                    size: 32,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            verse.sanskrit,
            style: const TextStyle(
              color: AppColors.goldLight,
              fontSize: 15,
              height: 1.6,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (verse.transliteration.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              verse.transliteration,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 12,
                fontStyle: FontStyle.italic,
                height: 1.4,
              ),
            ),
          ],
          const Divider(color: AppColors.cardBorder, height: 20),
          Text(
            verse.translation,
            style: const TextStyle(color: AppColors.textWhite, fontSize: 13.5, height: 1.5),
          ),
          if (verse.meaning != null) ...[
            const SizedBox(height: 8),
            Text(
              verse.meaning!,
              style: const TextStyle(color: AppColors.cyanAccent, fontSize: 12.5, height: 1.5),
            ),
          ],
        ],
      ),
    );
  }
}