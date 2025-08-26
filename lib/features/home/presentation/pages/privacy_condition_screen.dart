import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart'; // مهم للترجمة

import '../../../../core/utils/app_context.dart';

class PrivacyConditionScreen extends StatelessWidget {
  const PrivacyConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> data = [
      {"type": "bigTitle", "content": "screens.privacy.title"},
      {"type": "title", "content": "screens.privacy.info_collection.title"},
      {"type": "body", "content": "screens.privacy.info_collection.body"},
      {"type": "title", "content": "screens.privacy.usage.title"},
      {"type": "body", "content": "screens.privacy.usage.body"},
      {"type": "title", "content": "screens.privacy.control.title"},
      {"type": "body", "content": "screens.privacy.control.body"},
      {"type": "bigTitle", "content": "screens.terms.title"},
      {"type": "title", "content": "screens.terms.use_service.title"},
      {"type": "body", "content": "screens.terms.use_service.body"},
      {"type": "title", "content": "screens.terms.user_responsibility.title"},
      {"type": "body", "content": "screens.terms.user_responsibility.body"},
      {"type": "title", "content": "screens.terms.intellectual_property.title"},
      {"type": "body", "content": "screens.terms.intellectual_property.body"},
      {"type": "title", "content": "screens.terms.service_modifications.title"},
      {"type": "body", "content": "screens.terms.service_modifications.body"},
      {"type": "title", "content": "screens.terms.termination.title"},
      {"type": "body", "content": "screens.terms.termination.body"},
      {"type": "title", "content": "screens.terms.limitation_liability.title"},
      {"type": "body", "content": "screens.terms.limitation_liability.body"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("privacy_terms.title").tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          separatorBuilder: (context, index) => data[index]["type"] != "title"
              ? const SizedBox(height: 16)
              : const SizedBox(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            if (item["type"] == "title" || item["type"] == "bigTitle") {
              return Text(
                item["content"]!.tr(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: item["type"] == "bigTitle"
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: item["type"] == "bigTitle"
                          ? context.colors.primary
                          : context.colors.outlineVariant.withAlpha(240),
                    ),
              );
            } else {
              return Text(
                item["content"]!.tr(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: context.colors.outlineVariant.withAlpha(160),
                    ),
              );
            }
          },
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
//
// import '../../../../core/utils/app_context.dart';
//
// class PrivacyConditionScreen extends StatelessWidget {
//   const PrivacyConditionScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final List<Map<String, String>> data = [
//       {"type": "bigTitle", "content": "Privacy Policy"},
//       {"type": "title", "content": "Information Collection"},
//       {
//         "type": "body",
//         "content":
//             "We may collect your name, email, and usage data to personalize your experience."
//       },
//       {"type": "title", "content": "How We Use Data"},
//       {
//         "type": "body",
//         "content":
//             "Your data is used only to improve our services, provide support, and keep Coachera secure."
//       },
//       {"type": "title", "content": "Your Control"},
//       {
//         "type": "body",
//         "content":
//             "You can request to delete your data at any time by contacting our support team."
//       },
//       {"type": "bigTitle", "content": "Terms & Conditions"},
//       {"type": "title", "content": "1. Use of Service"},
//       {
//         "type": "body",
//         "content":
//             "Coachera provides digital coaching and habit tracking for educational and personal development purposes. You agree not to misuse the app or attempt unauthorized access."
//       },
//       {"type": "title", "content": "2. User Responsibility"},
//       {
//         "type": "body",
//         "content":
//             "You are responsible for your account activity. Do not share your credentials or post harmful, misleading, or illegal content."
//       },
//       {"type": "title", "content": "3. Intellectual Property"},
//       {
//         "type": "body",
//         "content":
//             "All content, logos, and designs within the app are owned by Coachera. You may not copy or distribute without permission."
//       },
//       {"type": "title", "content": "4. Service Modifications"},
//       {
//         "type": "body",
//         "content":
//             "We may update or suspend features for maintenance or improvements, with or without notice."
//       },
//       {"type": "title", "content": "5. Termination"},
//       {
//         "type": "body",
//         "content":
//             "We reserve the right to terminate or suspend your access if you violate these terms."
//       },
//       {"type": "title", "content": "6. Limitation of Liability"},
//       {
//         "type": "body",
//         "content":
//             "Coachera is provided 'as is'. We are not liable for any indirect, incidental, or consequential damages arising from app use."
//       }
//     ];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Privacy & Terms"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView.separated(
//           separatorBuilder: (context, index) => data[index]["type"] != "title"
//               ? const SizedBox(height: 16)
//               : const SizedBox(),
//           itemCount: data.length,
//           itemBuilder: (context, index) {
//             final item = data[index];
//             if (item["type"] == "title" || item["type"] == "bigTitle") {
//               return Text(
//                 item["content"]!,
//                 style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                     fontWeight: item["type"] == "bigTitle"
//                         ? FontWeight.bold
//                         : FontWeight.normal,
//                     color: item["type"] == "bigTitle"
//                         ? context.colors.primary
//                         : context.colors.outlineVariant.withAlpha(240)),
//               );
//             } else {
//               return Text(
//                 item["content"]!,
//                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                     color: context.colors.outlineVariant.withAlpha(160)),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
