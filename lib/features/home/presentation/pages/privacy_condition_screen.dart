import 'package:coachera/core/localization/keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/utils/app_context.dart';

final List<Map<String, dynamic>> faq = [
  {
    "Question": LocaleKeys.screens_FAQ_q1_Question.tr(),
    "Answer": [
      LocaleKeys.screens_FAQ_q1_Answer_a1.tr(),
      LocaleKeys.screens_FAQ_q1_Answer_a2.tr(),
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q2_Question.tr(),
    "Answer": [
      LocaleKeys.screens_FAQ_q2_Answer_a1.tr(),
      LocaleKeys.screens_FAQ_q2_Answer_a2.tr(),
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q3_Question.tr(),
    "Answer": [
      LocaleKeys.screens_FAQ_q3_Answer_a1.tr(),
      LocaleKeys.screens_FAQ_q3_Answer_a2.tr(),
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q4_Question.tr(),
    "Answer": [
      LocaleKeys.screens_FAQ_q4_Answer_a1.tr(),
      LocaleKeys.screens_FAQ_q4_Answer_a2.tr(),
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q5_Question.tr(),
    "Answer": [
      LocaleKeys.screens_FAQ_q5_Answer_a1.tr(),
      LocaleKeys.screens_FAQ_q5_Answer_a2.tr(),
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q6_Question.tr(),
    "Answer": [
      LocaleKeys.screens_FAQ_q6_Answer_a1.tr(),
      LocaleKeys.screens_FAQ_q6_Answer_a2.tr(),
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q7_Question.tr(),
    "Answer": [
      LocaleKeys.screens_FAQ_q7_Answer_a1.tr(),
      LocaleKeys.screens_FAQ_q7_Answer_a2.tr(),
      LocaleKeys.screens_FAQ_q7_Answer_a3.tr(),
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q8_Question.tr(),
    "Answer": [
      LocaleKeys.screens_FAQ_q8_Answer_a1.tr(),
      LocaleKeys.screens_FAQ_q8_Answer_a2.tr(),
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q9_Question.tr(),
    "Answer": [
      LocaleKeys.screens_FAQ_q9_Answer_a1.tr(),
      LocaleKeys.screens_FAQ_q9_Answer_a2.tr(),
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q10_Question.tr(),
    "Answer": [
      LocaleKeys.screens_FAQ_q10_Answer_a1.tr(),
      LocaleKeys.screens_FAQ_q10_Answer_a2.tr(),
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q11_Question.tr(),
    "Answer": [
      LocaleKeys.screens_FAQ_q11_Answer_a1.tr(),
      LocaleKeys.screens_FAQ_q11_Answer_a2.tr(),
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q12_Question.tr(),
    "Answer": [
      LocaleKeys.screens_FAQ_q12_Answer_a1.tr(),
      LocaleKeys.screens_FAQ_q12_Answer_a2.tr(),
      LocaleKeys.screens_FAQ_q12_Answer_a3.tr(),
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q13_Question.tr(),
    "Answer": [
      LocaleKeys.screens_FAQ_q13_Answer_a1.tr(),
      LocaleKeys.screens_FAQ_q13_Answer_a2.tr(),
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q14_Question.tr(),
    "Answer": [
      LocaleKeys.screens_FAQ_q14_Answer_a1.tr(),
      LocaleKeys.screens_FAQ_q14_Answer_a2.tr(),
    ]
  },
  {
    "Question": LocaleKeys.screens_FAQ_q15_Question.tr(),
    "Answer": [
      LocaleKeys.screens_FAQ_q15_Answer_a1.tr(),
      LocaleKeys.screens_FAQ_q15_Answer_a2.tr(),
    ]
  },
];

class PrivacyConditionScreen extends StatefulWidget {
  const PrivacyConditionScreen({super.key});

  @override
  State<PrivacyConditionScreen> createState() => _PrivacyConditionScreenState();
}

class _PrivacyConditionScreenState extends State<PrivacyConditionScreen>
    with SingleTickerProviderStateMixin {
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.canPop(context) ? context.pop() : null,
          icon: Icon(context.isLTR
              ? TablerIcons.chevron_left
              : TablerIcons.chevron_right),
        ),
        title: Text("Privacy and Conditions"),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        padding: EdgeInsets.only(
          top: 16,
          left: 16.0,
          right: 16.0,
          bottom: 16 + context.bottomPadding,
        ),
        itemCount: faq.length,
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
                trailing:
                    Icon(isExpanded ? TablerIcons.plus : TablerIcons.minus),
                title: Text(faq[index]['Question']!),
                children: List.generate(
                  faq[index]['Answer'].length,
                  (answerIndex) => Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 3,
                            backgroundColor: context.colors.onPrimaryContainer
                                .withAlpha(160),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            faq[index]['Answer'][answerIndex],
                            style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colors.onPrimaryContainer
                                    .withAlpha(160)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                // List.generate(_['lessons'].length, (lessonIndex) {
                // final lesson = section['lessons'][lessonIndex];
                // return ListTile(
                //   contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                //   title: Text(
                //     lesson['title'],
                //     style: const TextStyle(color: Colors.white),
                //   ),
                //   subtitle: Text(
                //     lesson['duration'],
                //     style: const TextStyle(color: Color(0xFFA7A7A7)),
                //   ),
                //   trailing: const Icon(
                //     Icons.play_circle_fill,
                //     color: Color(0xFFFFBD12),
                //   ),
                //   onTap: () {
                //     Handle lesson tap
                // },
                // );
                // }),
                ),
            /*   ),
         */
          );
        },
      ),
    );
  }
}
