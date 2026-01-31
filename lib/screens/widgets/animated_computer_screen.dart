import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class AnimatedComputerScreen extends StatefulWidget {
  final bool isDarkMode;
  final double size;

  const AnimatedComputerScreen({
    Key? key,
    required this.isDarkMode,
    required this.size,
  }) : super(key: key);

  @override
  State<AnimatedComputerScreen> createState() => _AnimatedComputerScreenState();
}

class _AnimatedComputerScreenState extends State<AnimatedComputerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _codeController;
  int _lineCount = 0;

  final List<Map<String, dynamic>> _codeLines = [
    {'color': Colors.purple, 'text': 'class', 'indent': 0},
    {'color': Colors.blue, 'text': '  QAEngineer', 'indent': 1},
    {'color': Colors.orange, 'text': '    extends', 'indent': 2},
    {'color': Colors.green, 'text': '      Professional', 'indent': 3},
    {'color': Colors.cyan, 'text': '        skills: [', 'indent': 4},
    {'color': Colors.pink, 'text': '          Selenium,', 'indent': 5},
    {'color': Colors.yellow, 'text': '          Postman,', 'indent': 5},
    {'color': Colors.red, 'text': '          JMeter', 'indent': 5},
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
  }

  void _initializeAnimation() {
    _codeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _codeController.addListener(() {
      if (_codeController.value < 0.1) {
        setState(() => _lineCount = 0);
      } else {
        final newCount = (_codeController.value * 8).floor();
        if (newCount != _lineCount) {
          setState(() => _lineCount = newCount);
        }
      }
    });
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Widget _buildWindowButton(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildCodeLine(int index) {
    if (index >= _codeLines.length) return const SizedBox.shrink();

    final line = _codeLines[index];
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(width: (line['indent'] as int) * 12.0),
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: line['color'] as Color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            line['text'] as String,
            style: GoogleFonts.firaCode(
              color: line['color'] as Color,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size * 0.65,
      decoration: BoxDecoration(
        color: widget.isDarkMode
            ? const Color(0xFF1E1E2E)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: widget.isDarkMode
              ? Colors.white.withOpacity(0.1)
              : Colors.grey.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: (widget.isDarkMode ? Colors.cyan : Colors.blue)
                .withOpacity(0.3),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          // Title bar with window buttons
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: widget.isDarkMode
                  ? const Color(0xFF2A2A3E)
                  : const Color(0xFFF5F5F5),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 12),
                _buildWindowButton(Colors.red),
                const SizedBox(width: 6),
                _buildWindowButton(Colors.yellow),
                const SizedBox(width: 6),
                _buildWindowButton(Colors.green),
              ],
            ),
          ),

          // Code content area
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  math.min(_lineCount, 8),
                      (index) => _buildCodeLine(index),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}