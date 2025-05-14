import 'package:coachera/core/utils/app_context.dart';
import 'package:flutter/material.dart';

enum ButtonSize { normal, small }

class PrimaryButton extends StatelessWidget {
  final Function()? onPressed;
  final Color? background;
  final Color? textColor;
  final Color? splash;
  final bool isLoading;
  final Widget? child;
  final String text;
  final ButtonSize type;

  const PrimaryButton({
    super.key,
    this.onPressed,
    this.background,
    this.textColor,
    this.splash,
    this.type = ButtonSize.normal,
    this.isLoading = false,
    this.child,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: type == ButtonSize.normal ? 48 : 38,
          width: double.infinity,
          decoration: BoxDecoration(
            color: onPressed == null
                ? context.colors.outline
                : background ?? context.colors.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Material(
            borderRadius: BorderRadius.circular(12),
            type: MaterialType.button,
            color: Colors.transparent,
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              splashColor: onPressed == null
                  ? context.colors.outline
                  : splash ?? context.colors.primaryContainer.withAlpha(48),
              onTap: !isLoading ? onPressed : null,
              child: Container(
                alignment: Alignment.center,
                child: child ??
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: onPressed == null
                            ? context.colors.surface
                            : textColor ?? context.colors.onPrimary,
                      ),
                    ),
              ),
            ),
          ),
        ),
        // if (isLoading && onPressed != null)
        //   Shimmer.fromColors(
        //     baseColor: background?.withOpacity(0.75) ??
        //         context.colors.primaryContainer.withOpacity(0.75),
        //     highlightColor: splash?.withOpacity(0.25) ??
        //         context.colors.surface.withOpacity(0.25),
        //     enabled: true,
        //     child: const Skeleton(
        //       borderRadius: curvedBor,
        //       height: 56,
        //       width: 300,
        //     ),
        //   )
      ],
    );
  }
}
