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
