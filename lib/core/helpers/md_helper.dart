import 'package:coachera/core/utils/app_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

/// [MdHelper] widget to render Markdown content with custom styles.
class MdHelper extends StatelessWidget {
  final String markdownData;
  final ScrollController? scrollController;

  const MdHelper({
    super.key,
    required this.markdownData,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Markdown(
      controller: scrollController,
      data: normalizeMd(markdownData),
      styleSheet: _buildMarkdownStyle(context),
      selectable: true,
      onTapLink: (text, href, title) async {
      },
    );
  }

  /// Custom style for Markdown rendering
  MarkdownStyleSheet _buildMarkdownStyle(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MarkdownStyleSheet(
      a: TextStyle(
        color: colorScheme.primary,
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.w500,
      ),
      p: const TextStyle(fontSize: 16, height: 1.6),
      pPadding: const EdgeInsets.symmetric(vertical: 8),
      code: TextStyle(
        backgroundColor: Colors.amber.withOpacity(0.2), // خلفية للكود inline
        fontFamily: 'monospace',
        fontSize: 14,
      ),
      h1: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: colorScheme.primary,
      ),
      h1Padding: const EdgeInsets.only(top: 16, bottom: 8),
      h2: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: colorScheme.secondary,
      ),
      h2Padding: const EdgeInsets.only(top: 14, bottom: 6),
      h3: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      h3Padding: const EdgeInsets.only(top: 12, bottom: 6),
      h4: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      h4Padding: const EdgeInsets.only(top: 10, bottom: 6),
      h5: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      h5Padding: const EdgeInsets.only(top: 8, bottom: 4),
      h6: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      h6Padding: const EdgeInsets.only(top: 6, bottom: 4),
      em: const TextStyle(fontStyle: FontStyle.italic),
      strong: const TextStyle(fontWeight: FontWeight.bold),
      del: const TextStyle(decoration: TextDecoration.lineThrough),
      blockquote: TextStyle(
        color: colorScheme.onSurface.withOpacity(0.7),
        fontStyle: FontStyle.italic,
      ),
      blockquotePadding: const EdgeInsets.all(8),
      blockquoteDecoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
        border: Border(left: BorderSide(color: colorScheme.primary, width: 4)),
      ),
      img: const TextStyle(fontSize: 14),
      checkbox: TextStyle(color: colorScheme.primary),
      blockSpacing: 12.0,
      listIndent: 24.0,
      listBullet: const TextStyle(fontSize: 16),
      listBulletPadding: const EdgeInsets.only(right: 8),
      tableHead: const TextStyle(fontWeight: FontWeight.bold),
      tableBody: const TextStyle(fontSize: 14),
      tableHeadAlign: TextAlign.center,

      tableBorder: TableBorder.all(width: 0.5, color: Colors.grey),
      tableColumnWidth: const FlexColumnWidth(),
      tableScrollbarThumbVisibility: true,
      tableCellsPadding: const EdgeInsets.all(8),
      tableCellsDecoration: const BoxDecoration(),
      tableVerticalAlignment: TableCellVerticalAlignment.middle,
      codeblockDecoration: BoxDecoration(
        color: context.colors.primaryContainer, // خلفية أغمق للـ code block
        borderRadius: BorderRadius.circular(8),
      ),
      codeblockPadding: const EdgeInsets.all(12),
      horizontalRuleDecoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 2.0, color: colorScheme.outline),
        ),
      ),
      textAlign: WrapAlignment.start,
      h1Align: WrapAlignment.start,
      h2Align: WrapAlignment.start,
      h3Align: WrapAlignment.start,
      h4Align: WrapAlignment.start,
      h5Align: WrapAlignment.start,
      h6Align: WrapAlignment.start,
      unorderedListAlign: WrapAlignment.start,
      orderedListAlign: WrapAlignment.start,
      blockquoteAlign: WrapAlignment.start,
      codeblockAlign: WrapAlignment.start,
      superscriptFontFeatureTag: 'sups',
    );
  }
}

String normalizeMd(String s) {
  if (s.isEmpty) return s;
  final lines = s.replaceAll('\r\n', '\n').split('\n');

  int? minIndent;
  for (final l in lines) {
    if (l.trim().isEmpty) continue;
    final i = l.length - l.trimLeft().length;
    if (minIndent == null || i < minIndent) minIndent = i;
  }
  final indent = minIndent ?? 0;
  final out =
      lines.map((l) => l.length >= indent ? l.substring(indent) : l).join('\n');
  return out.trim();
}
