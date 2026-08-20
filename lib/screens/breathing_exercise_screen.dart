import 'package:flutter/material.dart';
class BreathingExerciseScreen extends StatefulWidget {
  const BreathingExerciseScreen({super.key});

  @override
  State<BreathingExerciseScreen> createState() =>
      _BreathingExerciseScreenState();
}

class _BreathingExerciseScreenState extends State<BreathingExerciseScreen>
    with SingleTickerProviderStateMixin {
  static const int _inhaleSeconds = 4;
  static const int _exhaleSeconds = 4;
  static const int _totalCycles = 5;

  late final AnimationController _controller;
  late final Animation<double> _scale;

  bool _isRunning = false;
  int _completedHalfCycles = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: _inhaleSeconds),
      reverseDuration: const Duration(seconds: _exhaleSeconds),
    );

    _scale = Tween<double>(begin: 0.82, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.addStatusListener(_onStatusChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onStatusChanged(AnimationStatus status) {
    if (!_isRunning) return;

    if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
      _advancePhase(status);
    }
  }

  void _advancePhase(AnimationStatus finishedStatus) {
    final nextHalfCycles = _completedHalfCycles + 1;

    if (nextHalfCycles >= _totalCycles * 2) {
      setState(() {
        _completedHalfCycles = _totalCycles * 2;
        _isRunning = false;
      });
      _showCompletionDialog();
      return;
    }

    setState(() => _completedHalfCycles = nextHalfCycles);

    if (finishedStatus == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  void _startSession() {
    setState(() {
      _isRunning = true;
      _completedHalfCycles = 0;
    });
    _controller.forward(from: 0);
  }

  void _pauseSession() {
    _controller.stop();
    setState(() => _isRunning = false);
  }

  void _restartCurrentPhase() {
    if (!_isRunning) return;
    if (_controller.status == AnimationStatus.forward) {
      _controller.forward(from: 0);
    } else {
      _controller.reverse(from: 1);
    }
  }

  void _skipToNextPhase() {
    if (!_isRunning) return;
    final currentStatus = _controller.status;
    _controller.stop();
    _advancePhase(
      currentStatus == AnimationStatus.forward
          ? AnimationStatus.completed
          : AnimationStatus.dismissed,
    );
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xff102131),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          "Session Complete",
          style: TextStyle(color: Color(0xffD4A64A)),
        ),
        content: Text(
          "You completed $_totalCycles breathing cycles. Well done.",
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() => _completedHalfCycles = 0);
            },
            child: const Text("OK", style: TextStyle(color: Color(0xffD4A64A))),
          ),
        ],
      ),
    );
  }


  String get _phaseTitle {
    if (!_isRunning && _completedHalfCycles == 0) return "Prepare";
    return _controller.status == AnimationStatus.forward ? "Inhale" : "Exhale";
  }

  String get _phaseSubtitle {
    if (!_isRunning && _completedHalfCycles == 0) return "FIND A COMFORTABLE SEAT";
    return _controller.status == AnimationStatus.forward
        ? "BREATHE IN SLOWLY"
        : "BREATHE OUT SLOWLY";
  }

  int get _completedFullCycles => _completedHalfCycles ~/ 2;

  double get _sessionProgress => _completedHalfCycles / (_totalCycles * 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff071421),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),

              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                  const Spacer(),
                  const Text(
                    "Breathing Exercise",
                    style: TextStyle(
                      color: Color(0xffD4A64A),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.settings, color: Color(0xffD4A64A)),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: Text(
                  _phaseTitle,
                  key: ValueKey(_phaseTitle),
                  style: const TextStyle(
                    color: Color(0xffD4A64A),
                    fontSize: 32,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              Text(
                _phaseSubtitle,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 13,
                  letterSpacing: 1.5,
                ),
              ),

              const Spacer(),

              AnimatedBuilder(
                animation: _scale,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scale.value,
                    child: child,
                  );
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xff0d1c2b),
                    border: Border.all(
                      color: const Color(0xffD4A64A).withValues(alpha: 0.4),
                      width: 1.5,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.local_florist,
                      color: Color(0xffD4A64A),
                      size: 48,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_totalCycles, (index) {
                  final filled = index < _completedFullCycles;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: filled
                          ? const Color(0xffD4A64A)
                          : Colors.white.withValues(alpha: 0.2),
                    ),
                  );
                }),
              ),

              const Spacer(),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "SESSION PROGRESS",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    "${(_sessionProgress * 100).round()}%",
                    style: const TextStyle(
                      color: Color(0xffD4A64A),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: _sessionProgress,
                  minHeight: 5,
                  backgroundColor: Colors.white.withValues(alpha: 0.08),
                  valueColor: const AlwaysStoppedAnimation(Color(0xffD4A64A)),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _restartCurrentPhase,
                    icon: const Icon(
                      Icons.skip_previous,
                      color: Colors.white54,
                      size: 28,
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    height: 52,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffD4A64A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                        elevation: 0,
                      ),
                      onPressed: _isRunning ? _pauseSession : _startSession,
                      icon: Icon(
                        _isRunning ? Icons.pause : Icons.play_arrow,
                        color: const Color(0xff071421),
                      ),
                      label: Text(
                        _isRunning ? "Pause" : "Start Session",
                        style: const TextStyle(
                          color: Color(0xff071421),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _skipToNextPhase,
                    icon: const Icon(
                      Icons.skip_next,
                      color: Colors.white54,
                      size: 28,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}