import 'package:flutter/material.dart';
class GlowingSpaButton extends StatefulWidget {
  final VoidCallback onTap;

  const GlowingSpaButton({
    super.key,
    required this.onTap,
  });
  @override
  State<GlowingSpaButton> createState() => _GlowingSpaButtonState();
}

class _GlowingSpaButtonState extends State<GlowingSpaButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(
      begin: 10,
      end: 35,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              // Outer Glow
              BoxShadow(
                color: const Color(0xffD4A64A).withValues(alpha: 0.20),
                blurRadius: _glowAnimation.value + 20,
                spreadRadius: 8,
              ),

              // Middle Glow
              BoxShadow(
                color: const Color(0xffD4A64A).withValues(alpha: 0.35),
                blurRadius: _glowAnimation.value,
                spreadRadius: 5,
              ),

              // Inner Glow
              BoxShadow(
                color: const Color(0xffD4A64A).withValues(alpha: 0.60),
                blurRadius: _glowAnimation.value / 2,
                spreadRadius: 2,
              ),
            ],
          ),
          child: child,
        );
      },

      child: FloatingActionButton(
        onPressed: widget.onTap,

        backgroundColor: const Color(0xffD4A64A),

        elevation: 0,

        shape: const CircleBorder(),

        child: const Icon(
          Icons.local_florist,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}