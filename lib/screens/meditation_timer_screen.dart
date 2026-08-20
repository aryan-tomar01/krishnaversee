import 'dart:async';
import 'dart:math' as math;
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MeditationTimerScreen extends StatefulWidget {
  const MeditationTimerScreen({super.key});

  @override
  State<MeditationTimerScreen> createState() => _MeditationTimerScreenState();
}

class _MeditationTimerScreenState extends State<MeditationTimerScreen> {
  static const Duration _totalDuration = Duration(minutes: 15);
  Duration _remaining = _totalDuration;
  Timer? _timer;
  bool _isRunning = false;

  final AudioPlayer _audioPlayer = AudioPlayer();
  String _selectedSound = "Ganges Flow";

  final Map<String, String> _soundAssets = const {
    "Ganges Flow": "sounds/river.mp3",
    "Temple Bells": "sounds/temple_bells.mp3",
    "Forest Silence": "sounds/forest.mp3",
  };

  @override
  void initState() {
    super.initState();
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  double get _progress =>
      1 - (_remaining.inMilliseconds / _totalDuration.inMilliseconds);

  String get _formattedTime {
    final minutes = _remaining.inMinutes.toString().padLeft(2, '0');
    final seconds = (_remaining.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }


  void _toggleStart() {
    if (_isRunning) {
      _pauseTimer();
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    if (_remaining.inSeconds <= 0) return;

    setState(() => _isRunning = true);

    _playSelectedSound();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remaining.inSeconds <= 1) {
        timer.cancel();
        setState(() {
          _remaining = Duration.zero;
          _isRunning = false;
        });
        _audioPlayer.stop();
        _showCompletionDialog();
      } else {
        setState(() {
          _remaining -= const Duration(seconds: 1);
        });
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
    _audioPlayer.pause();
    setState(() => _isRunning = false);
  }

  void _cancelMeditation() {
    _timer?.cancel();
    _audioPlayer.stop();
    setState(() {
      _isRunning = false;
      _remaining = _totalDuration;
    });
    Navigator.pop(context);
  }

  Future<void> _playSelectedSound() async {
    final asset = _soundAssets[_selectedSound];
    if (asset == null) return;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(asset));
  }

  void _selectSound(String title) {
    setState(() => _selectedSound = title);
    if (_isRunning) {
      _playSelectedSound();
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xff102131),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          "Meditation Complete",
          style: TextStyle(color: Color(0xffD4A64A)),
        ),
        content: const Text(
          "You have completed your 15 minute meditation. Om Shanti.",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() => _remaining = _totalDuration);
            },
            child: const Text(
              "OK",
              style: TextStyle(color: Color(0xffD4A64A)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff071421),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),

                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.menu, color: Colors.white),
                    ),
                    const Spacer(),
                    const Text(
                      "Bhagavad Gita",
                      style: TextStyle(
                        color: Color(0xffD4A64A),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                const Text(
                  "Meditation Timer",
                  style: TextStyle(
                    color: Color(0xffD4A64A),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  '"Fixed in Yoga, perform your actions"',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                const SizedBox(height: 35),

                SizedBox(
                  height: 250,
                  width: 250,
                  child: CustomPaint(
                    painter: _TimerRingPainter(progress: _progress),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _formattedTime,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _remaining.inSeconds <= 0
                                ? "COMPLETE"
                                : "REMAINING",
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 13,
                              letterSpacing: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  children: [
                    Expanded(
                      child: Divider(color: Colors.white.withValues(alpha: 0.15)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xffD4A64A),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.spa,
                          color: Color(0xffD4A64A),
                          size: 16,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: Colors.white.withValues(alpha: 0.15)),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "AMBIENT SOUND",
                    style: TextStyle(
                      color: Color(0xffD4A64A),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                _soundTile(Icons.waves, "Ganges Flow"),
                const SizedBox(height: 12),
                _soundTile(
                    Icons.notifications_active_outlined, "Temple Bells"),
                const SizedBox(height: 12),
                _soundTile(Icons.forest, "Forest Silence"),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffD4A64A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    onPressed: _toggleStart,
                    child: Text(
                      _isRunning ? "PAUSE" : "START MEDITATION",
                      style: const TextStyle(
                        fontSize: 15,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff071421),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: _cancelMeditation,
                    child: const Text(
                      "CANCEL",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _soundTile(IconData icon, String title) {
    final bool selected = _selectedSound == title;

    return GestureDetector(
      onTap: () => _selectSound(title),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xffD4A64A).withValues(alpha: 0.12)
              : const Color(0xff102131),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? const Color(0xffD4A64A)
                : Colors.white.withValues(alpha: 0.06),
            width: selected ? 1.2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected ? const Color(0xffD4A64A) : Colors.white70,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: selected ? const Color(0xffD4A64A) : Colors.white,
                  fontSize: 15,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_circle,
                color: Color(0xffD4A64A),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}

class _TimerRingPainter extends CustomPainter {
  final double progress;

  _TimerRingPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 10) / 2;

    final trackPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    final progressPaint = Paint()
      ..color = const Color(0xffD4A64A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    final sweep = (1 - progress) * 2 * math.pi;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweep,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _TimerRingPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

