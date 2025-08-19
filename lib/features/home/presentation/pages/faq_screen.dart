import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/localization/keys.g.dart';
import '../../../../core/utils/app_context.dart';

final List<Map<String, dynamic>> faqKeys = [
  {
    "Question": LocaleKeys.screens_FAQ_q1_Question,
    "Answer": [
      LocaleKeys.screens_FAQ_q1_Answer_a1,
      LocaleKeys.screens_FAQ_q1_Answer_a2,
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q2_Question,
    "Answer": [
      LocaleKeys.screens_FAQ_q2_Answer_a1,
      LocaleKeys.screens_FAQ_q2_Answer_a2,
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q3_Question,
    "Answer": [
      LocaleKeys.screens_FAQ_q3_Answer_a1,
      LocaleKeys.screens_FAQ_q3_Answer_a2,
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q4_Question,
    "Answer": [
      LocaleKeys.screens_FAQ_q4_Answer_a1,
      LocaleKeys.screens_FAQ_q4_Answer_a2,
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q5_Question,
    "Answer": [
      LocaleKeys.screens_FAQ_q5_Answer_a1,
      LocaleKeys.screens_FAQ_q5_Answer_a2,
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q6_Question,
    "Answer": [
      LocaleKeys.screens_FAQ_q6_Answer_a1,
      LocaleKeys.screens_FAQ_q6_Answer_a2,
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q7_Question,
    "Answer": [
      LocaleKeys.screens_FAQ_q7_Answer_a1,
      LocaleKeys.screens_FAQ_q7_Answer_a2,
      LocaleKeys.screens_FAQ_q7_Answer_a3,
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q8_Question,
    "Answer": [
      LocaleKeys.screens_FAQ_q8_Answer_a1,
      LocaleKeys.screens_FAQ_q8_Answer_a2,
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q9_Question,
    "Answer": [
      LocaleKeys.screens_FAQ_q9_Answer_a1,
      LocaleKeys.screens_FAQ_q9_Answer_a2,
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q10_Question,
    "Answer": [
      LocaleKeys.screens_FAQ_q10_Answer_a1,
      LocaleKeys.screens_FAQ_q10_Answer_a2,
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q11_Question,
    "Answer": [
      LocaleKeys.screens_FAQ_q11_Answer_a1,
      LocaleKeys.screens_FAQ_q11_Answer_a2,
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q12_Question,
    "Answer": [
      LocaleKeys.screens_FAQ_q12_Answer_a1,
      LocaleKeys.screens_FAQ_q12_Answer_a2,
      LocaleKeys.screens_FAQ_q12_Answer_a3,
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q13_Question,
    "Answer": [
      LocaleKeys.screens_FAQ_q13_Answer_a1,
      LocaleKeys.screens_FAQ_q13_Answer_a2,
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q14_Question,
    "Answer": [
      LocaleKeys.screens_FAQ_q14_Answer_a1,
      LocaleKeys.screens_FAQ_q14_Answer_a2,
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q15_Question,
    "Answer": [
      LocaleKeys.screens_FAQ_q15_Answer_a1,
      LocaleKeys.screens_FAQ_q15_Answer_a2,
    ]
  },
];

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen>
    with SingleTickerProviderStateMixin {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.canPop(context) ? context.pop() : null,
          icon: Icon(
            context.isLTR ? TablerIcons.chevron_left : TablerIcons.chevron_right,
          ),
        ),
        title: Text("FAQ"), // <-- you can also localize this if needed
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        padding: EdgeInsets.only(
          top: 16,
          left: 16.0,
          right: 16.0,
          bottom: 16 + context.bottomPadding,
        ),
        itemCount: faqKeys.length,
        itemBuilder: (context, index) {
          final isExpanded = _expandedIndex == index;

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ExpansionTile(
              onExpansionChanged: (expanded) =>
                  setState(() => _expandedIndex = expanded ? index : null),
              initiallyExpanded: isExpanded,
              trailing: Icon(isExpanded ? TablerIcons.plus : TablerIcons.minus),
              title: Text(faqKeys[index]['Question'].toString().tr()),
              children: List.generate(
                (faqKeys[index]['Answer'] as List).length,
                    (answerIndex) => Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 3,
                          backgroundColor:
                          context.colors.onPrimaryContainer.withAlpha(160),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          (faqKeys[index]['Answer'][answerIndex] as String).tr(),
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colors.onPrimaryContainer
                                .withAlpha(160),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
