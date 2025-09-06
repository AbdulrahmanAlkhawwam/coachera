import 'package:coachera/core/constants/res.dart';
import 'package:coachera/core/utils/app_context.dart';
import 'package:coachera/core/utils/app_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LearningPathAds extends StatefulWidget {
  final VoidCallback onTap;

  const LearningPathAds({super.key, required this.onTap});

  @override
  State<LearningPathAds> createState() => _LearningPathAdsState();
}

class _LearningPathAdsState extends State<LearningPathAds> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: Container(
          height: context.height / 5,
          decoration: BoxDecoration(
            color: context.colors.secondary,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: context.colors.primaryContainer,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Container(
              margin: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF00C9A7),
                    Color(0xFF92FE9D),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  Positioned(
                      left: -195,
                      bottom: -58,
                      height: 240,
                      child: AppImage(
                        Res.learningPathAds,
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "Learning Path\nis Available Now",
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: context.colors.surface,
                          fontFamily: GoogleFonts.laBelleAurore().fontFamily),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
