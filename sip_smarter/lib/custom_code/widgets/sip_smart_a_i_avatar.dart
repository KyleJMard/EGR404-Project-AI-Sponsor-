// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:math' as math;

class SipSmartAIAvatar extends StatefulWidget {
  const SipSmartAIAvatar({
    Key? key,
    required this.width,
    required this.height,
    this.size,
    this.isThinking = false,
  }) : super(key: key);

  final double width;
  final double height;

  /// If provided, this controls the orb diameter. If null, we use min(width, height).
  final double? size;

  final bool isThinking;

  @override
  State<SipSmartAIAvatar> createState() => _SipSmartAIAvatarState();
}

class _SipSmartAIAvatarState extends State<SipSmartAIAvatar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // FlutterFlow still controls layout using width/height.
    // We use `size` for the actual orb diameter.
    final double boxW = widget.width;
    final double boxH = widget.height;

    final double fallback = math.min(boxW, boxH);
    final double diameter = (widget.size != null && widget.size! > 0)
        ? math.min(widget.size!, fallback)
        : fallback;

    return SizedBox(
      width: boxW,
      height: boxH,
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            final pulse =
                1.0 + math.sin(_controller.value * 2 * math.pi) * 0.04;

            final rotation =
                widget.isThinking ? _controller.value * 2 * math.pi : 0.0;

            return Transform.scale(
              scale: pulse,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Glow
                  Container(
                    width: diameter * 1.18,
                    height: diameter * 1.18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFF8F1D6C).withOpacity(0.40),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),

                  // Core orb
                  Container(
                    width: diameter,
                    height: diameter,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF6A0D4E),
                          Color(0xFF8F1D6C),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),

                  // Highlight
                  Positioned(
                    top: diameter * 0.18,
                    left: diameter * 0.22,
                    child: Container(
                      width: diameter * 0.22,
                      height: diameter * 0.22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.18),
                      ),
                    ),
                  ),

                  // Thinking ring
                  if (widget.isThinking)
                    Transform.rotate(
                      angle: rotation,
                      child: Container(
                        width: diameter * 1.42,
                        height: diameter * 1.42,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFC85B9C).withOpacity(0.65),
                            width: math.max(1.5, diameter * 0.03),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
